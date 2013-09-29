function testfunc(nametrain, nametest)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    load(nametrain);
    res2 = readtrainfile(nametest);
    [n2,m2] = size(res2);
    fid=fopen('score.txt', 'w');
    score = -1000,000000;
    decision = 't';
    for i=1:m2
        name = res2{i}{1};
        id = res2{i}{2};
        l = map(id);
        [n1,m1] = size(l);
        for j=1:n1
            main(name, l{j});
        end
        fprintf(fid,'%s %s %f %s\n',name, id, score, decision); 
    end

end

