function [datanew, a, b] = moindreCarre(data)

    [m, n] = size(data);
    X = data(:,1);
    Y = data(:,2);
    
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
    for i=3:n
        datanew(:,i) = data(:,i);
    end
end

