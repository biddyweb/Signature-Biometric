function rapp = correlTemp(data)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [m,~] = size(data);
    Xbar = mean(data(:,1));
    Ybar = mean(data(:,2));
    num = 0;
    denX = 0;
    denY = 0;
    for i=1:m
        valX = (data(i,1)-Xbar);
        valY = (data(i,2)-Ybar);
        num = num + valX*valY;
        denX = denX + valX*valX;
        denY = denY + valY*valY;
    end
    rapp = num / (sqrt(denX)*sqrt(denY));

end

