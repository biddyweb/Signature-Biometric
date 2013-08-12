function theta = getAngle(a, b, c)

v1 = [a(1) - b(1), a(2) - b(2)];
v2 = [b(1) - c(1), b(2) - c(2)];

theta = acos((v1(1) * v2(1) + v1(2) * v2(2)) / (sqrt(v1(1) * v1(1) + v1(2) * v1(2)) * sqrt(v2(1) * v2(1) + v2(2) * v2(2))));

end