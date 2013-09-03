function [depl,distTrait,distrapp,distXrapp,distYrapp,distTanSum,distTan] = deplacement(data)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    X = data(:,1);
    s = size(X);
    depl = (max(X) - min(X))./s(1);
    Y = data(:,2);
    num = 0;
    den = 0;
    numX = 0;
    numY = 0;
    denX = 0;
    denY = 0;
    distTanSum = 0;
    distTrait = 0;
    for i=1:s(1)-1
        tmp1 = Y(i+1,1)-Y(i);
        tmp2 = X(i+1,1)-X(i);
        if tmp2 ~= 0
            distTanSum = distTanSum + atan(tmp1./tmp2);
        else
            distTanSum = distTanSum + atan(0);
        end
        num = num - tmp2;
        den = den - tmp1;
        distTrait = distTrait + dist(X(i+1,1),X(i),Y(i+1,1),Y(i));
        numX = numX + max(-tmp2,0);
        numY = numY + max(tmp1,0);
        denX = denX + min(-tmp2,0);
        denY = denY + min(tmp1,0);
    end
    distrapp = num ./ den;
    distYrapp = -numY./denY;
    distXrapp = -numX./denX;
    distTan = atan((Y(s(1),1)-Y(1,1))./(X(s(1),1)-X(1,1)));
end

function d = dist(xa,xb,ya,yb)
    d = sqrt((xb-xa)^2+(yb-ya)^2);
end

