function [dist] = deplacement(data1, data2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    X1 = data1(:,1);
    X2 = data2(:,1);
    s1 = size(X1);
    s2 = size(X2);
    depl1 = (max(X1) - min(X1))./s1(1);
    depl2 = (max(X2) - min(X2))./s2(1);
    dist = abs(depl1-depl2);
    Y1 = data1(:,2);
    Y2 = data2(:,2);
    num = 0;
    den = 0;
    numX = 0;
    numY = 0;
    denX = 0;
    denY = 0;
    distTanSum1 = 0;
    distTrait1 = 0;
    for i=1:s1(1)-1
        tmp1 = Y1(i+1,1)-Y1(i);
        tmp2 = X1(i+1,1)-X1(i);
        if tmp2 ~= 0
            distTanSum1 = distTanSum1 + atan(tmp1./tmp2);
        else
            distTanSum1 = distTanSum1 + atan(0);
        end
        num = num - tmp2;
        den = den - tmp1;
        distTrait1 = distTrait1 + distance(X1(i+1,1),X1(i),Y1(i+1,1),Y1(i));
        numX = numX + max(-tmp2,0);
        numY = numY + max(tmp1,0);
        denX = denX + min(-tmp2,0);
        denY = denY + min(tmp1,0);
    end
    distrapp1 = num ./ den;
    distYrapp1 = -numY./denY;
    distXrapp1 = -numX./denX;
    num = 0;
    den = 0;
    numX = 0;
    numY = 0;
    denX = 0;
    denY = 0;
    distTanSum2 = 0;
    distTrait2 = 0;
    for i=1:s2(1)-1
        tmp1 = Y2(i+1,1)-Y2(i);
        tmp2 = X2(i+1,1)-X2(i);
        if tmp2 ~= 0
            distTanSum2 = distTanSum2 + atan(tmp1./tmp2);
        else
            distTanSum2 = distTanSum2 + atan(0);
        end
        num = num - tmp2;
        den = den - tmp1;
        distTrait2 = distTrait2 + distance(X2(i+1,1),X2(i),Y2(i+1,1),Y2(i));
        numX = numX + max(-tmp2,0);
        numY = numY + max(tmp1,0);
        denX = denX + min(-tmp2,0);
        denY = denY + min(tmp1,0);
    end
    distrapp2 = num ./ den;
    distYrapp2 = -numY./denY;
    distXrapp2 = -numX./denX;
    dist = dist + abs(distTanSum1-distTanSum2);
    dist = dist + abs(distrapp1-distrapp2);
    distTan1 = atan((Y1(s1(1),1)-Y1(1,1))./(X1(s1(1),1)-X1(1,1)));
    distTan2 = atan((Y2(s2(1),1)-Y2(1,1))./(X2(s2(1),1)-X2(1,1)));
    dist = dist + abs(distTan1-distTan2);
    dist = dist + abs(distXrapp1-distXrapp2);
    dist = dist + abs(distYrapp1-distYrapp2);
    %dist = dist + abs(distTrait1-distTrait2);
end

function d = distance(xa,xb,ya,yb)
    d = sqrt((xb-xa)^2+(yb-ya)^2);
end

