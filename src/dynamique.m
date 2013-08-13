function [tmp, vm, vmv, vmh, vmax, acc] = dynamique(data)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    X = data(:,1);
    Y = data(:,2);
    T = data(:,3);
    s = size(T);
    tmp = T(s(1),1)-T(1,1);
    vm = 0;
    vmv = 0;
    vmh = 0;
    vmax = 0;
    acc = 0;
    for i=1:s(1)-1
        dist = distance(X(i),X(i+1),Y(i),Y(i+1));
        vmax = max(vmax, dist./(T(i+1)-T(i)));
        vm = vm + dist;
        vmv = vmv + abs(Y(i+1)-Y(i));
        vmh = vmh + abs(X(i+1)-X(i));
    end
    for i=1:s(1)-2
        acc = acc + distance(X(i),X(i+2),Y(i),Y(i+2));
    end
    acc = acc ./ (tmp*tmp);
    vm = vm ./ tmp;
    vmv = vmv ./ tmp;
    vmh = vmh ./ tmp;
end

function d = distance(xa,xb,ya,yb)
    d = sqrt((xb-xa)^2+(yb-ya)^2);
end