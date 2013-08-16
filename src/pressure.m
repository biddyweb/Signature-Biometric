function pres = pressure(data)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    pres = 0;
    s = size(data);
    for i=1:s(1)
        pres = pres + data(i,7);
    end
    pres = pres ./ s(1);
end

