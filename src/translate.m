function [datanew] = translate(data)
% Përform a translation of the points so that their gravity center is (0, 0)
    [m, n] = size(data);
    X = data(:,1);
    Y = data(:,2);
    
    Xbar = mean(X);
    Ybar = mean(Y);
    
    datanew = zeros(m, n);
    for i = 1:m
        datanew(i,1) = X(i,1)-Xbar;
        datanew(i,2) = Y(i,1)-Ybar;
        for j=3:n
            datanew(i,j) = data(i,j);
        end
    end
end

