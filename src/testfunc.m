function testfunc(nametrain, nametest)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    load(nametrain);
    res2 = readtrainfile(nametest);
    [n2,m2] = size(res2);   
    for i=1:m2
        name = res2{i}{1};
        id = res2{i}{2};
        l = map(id);
        [n1,m1] = size(l);
        for j=1:n1
            main(name, l{j});
        end
    end

end

