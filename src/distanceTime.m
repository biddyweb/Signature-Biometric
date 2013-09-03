function dist = distanceTime(d1, d2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    data1 = d1;
    data2 = d2;
    s1 = size(data1);
    s2 = size(data2);
    t1 = data1(1,3);
    t2 = data2(1,3);
    data1(:,3) = data1(:,3) - t1;
    data2(:,3) = data2(:,3) - t2;
    t1 = data1(s1(1),3);
    t2 = data2(s2(1),3);
    data1(:,3) = data1(:,3) / t1;
    data2(:,3) = data2(:,3) / t2;
    dist = 0;
    for i=1:s1(1)
        for j=1:s2(1)
            if (data1(i,3) > data2(j,3))
                dist = dist + abs(data1(i,3) * d(data1(i,1),data2(j,1),data1(i,2),data2(j,2)));
            else
                dist = dist + abs(data2(j,3) * d(data1(i,1),data2(j,1),data1(i,2),data2(j,2)));
            end
        end
    end
end

function di = d(xa,xb,ya,yb)
    di = sqrt((xb-xa)^2+(yb-ya)^2);
end

