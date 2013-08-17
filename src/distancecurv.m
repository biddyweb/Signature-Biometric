function dist = distancecurv(data1, data2, distTrait1, distTrait2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    dist = 0;
    [N,~]=size(data1);
    [M,~]=size(data2);
    for n=1:N
        for m=1:M
            dist = dist + abs(distan(data1,n)./distTrait1 - distan(data2,m)./distTrait2);
        end
    end

end

function d = distan(data, imax)
    d = 0;
    for i=2:imax
        d = d + sqrt((data(i-1,1)-data(i,1))^2+(data(i-1,2)-data(i,2))^2);
    end
end