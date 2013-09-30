function testfunc(nametrain, nametest)
    load(nametrain);
    res2 = readtrainfile(nametest);
    [n2,m2] = size(res2);
    fid=fopen('score.txt', 'w');

    score = -1000,000000;
    decisionFloor = -0.7507;
    caracFloors = [1.4130e+07, 1.3437e+03, 0.0184, 48.9787];
    coeff = [0.222, 0.1678, 0.2531, 0.3571];

    for i=1:m2
        name = res2{i}{1};
        id = res2{i}{2};
        l = map(id);
        [n1,m1] = size(l);
        
        scores = 0;
        for j=1:n1
            scores = scores + getScore(name, l{j}, coeff, caracFloors);
        end
        score = scores / n1;
        
        % fixme: interval
        if score <= decisionFloor
            decision = 't';
        else
            decision = 'f';
        end
        fprintf(fid,'%s %s %f %s\n',name, id, score, decision); 
    end

end

