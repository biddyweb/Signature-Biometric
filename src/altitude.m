function alt = altitude(data)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    alt = 0;
    s = size(data);
    for i=1:s(1)
        alt = alt + data(i,6);
    end
    alt = alt ./ s(1);
end
