function [datanew, a, b] = moindreCarre(data)

    [m, n] = size(data);
    X = zeros(m,1);
    Y = zeros(m,1);
    for i=1:m
        X(i,1) = data(i,1);
        Y(i,1) = data(i,2);
    end
    
    % Get mean
    Xbar = mean(X);
    Ybar = mean(Y);
    
    % Get variance and covariance
    XV = var(X);
    c = sum((X - Xbar)' * (Y - Ybar));
    
    a = c / sum((X - Xbar).^2);
    b = Ybar - a * Xbar;
    
    % Draw ax + b
    hline = refline(a, b);
    set(hline,'Color','k')
    
    x = 1000;
    y = a * x;
    theta = acos(x / (sqrt(x^2 + y^2)));

    % Perform rotation
    datanew = zeros(m,n);
    datanew(:,1) = X(:,1) * cos(theta) - Y(:,1)*sin(theta);
    datanew(:,2) = X(:,1) * sin(theta) + Y(:,1)*cos(theta);
end

