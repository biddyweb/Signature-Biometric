function [] = showBoundingBox(data)

mins = [min(data(:, 1)), min(data(:, 2))];
w = max(data(:, 1)) - mins(1);
h = max(data(:, 2)) - mins(2);
rectangle('Position', [mins(1), mins(2), w, h], 'LineWidth', 2, 'EdgeColor', 'g');

end