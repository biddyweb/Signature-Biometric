function [dataNew] = reduceNbPoints(data)
% Reduce the number of points for a more efficient and easy comparison.
    
[n, ~] = size(data);

% Keep first and last points in the reduction
dataNew(1, :) = data(1, :);

step = 3; % Get a sample every "step" number of points
currIndex = 2;
maxTheta = 0; % something higher than pi, the angle will always be lower;
maxIndex = 2;

% I should keep the min theta but somehow getAngle gives me the contrary...
% So I test for the max angle. Not very important.
for i = 3:n - 2
    if (mod(i, step) == 0)
        dataNew(currIndex, :) = data(maxIndex, :);
        currIndex = currIndex + 1;
        maxTheta = 0;
    end
    tmpTheta = getAngle(data(i - 1, 1:2), data(i, 1:2), data(i + 1, 1:2));
    if (tmpTheta > maxTheta)
        maxTheta = tmpTheta;
        maxIndex = i;
    end
end
dataNew(currIndex, :) = data(n, :);

%plot(dataNew(:, 1), dataNew(:, 2), 'k*');

end