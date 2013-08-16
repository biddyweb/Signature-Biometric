function azi = azimuth(data)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    azi = 0;
    s = size(data);
    for i=1:s(1)
        azi = azi + data(i,5);
    end
    azi = azi ./ s(1);
end

