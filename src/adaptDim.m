function [dataNew1, dataNew2] = adaptDim(dim, data1, data2)

dataNew1 = data1;
dataNew2 = data2;

minX1 = min(data1(:, dim));
minX2 = min(data2(:, dim));
maxX1 = max(data1(:, dim));
maxX2 = max(data2(:, dim));

minX = min(minX1, minX2);
maxX = max(maxX1, maxX2);

D = maxX - minX;

d = maxX1 - minX1;
[m, ~] = size(data1);
for i = 1:m
    dataNew1(i, dim) = (dataNew1(i, dim) - minX1) * D / d + minX;
end

d = maxX2 - minX2;
[m, ~] = size(data2);
for i = 1:m
    dataNew2(i, dim) = (dataNew2(i, dim) - minX2) * D / d + minX;
end

end