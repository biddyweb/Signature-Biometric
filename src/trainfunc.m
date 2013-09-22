function trainfunc(name)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    res = readtrainfile(name);
    [n,m] = size(res);
    map = containers.Map();
    for i=1:m
        [n1,m1] = size(res{i});
        key = res{i}{1};
        values = cell(1,n1-1);
        for j=2:n1
            values{1,j-1} = res{i}{j};
        end
        map(key) = values;
    end
    save('train.mat', 'map');
end

