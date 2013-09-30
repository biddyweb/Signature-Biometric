function score = getScore(file1, file2, coeff, caracFloors)

    mat = readfile(file1);
    mat = moindreCarre(mat);
    data1 = translate(mat);
    [n2,r2] = boxcount(data1);
    df = -diff(log(n2)) ./ diff(log(r2));
    fracDim1 = mean(df(4:8));
    data1 = reduceNbPoints(data1);

    mat = readfile(file2);
    mat = moindreCarre(mat);
    data2 = translate(mat);
    [n2,r2] = boxcount(data2);
    df = -diff(log(n2))./diff(log(r2));
    fracDim2 = mean(df(4:8));
    data2 = reduceNbPoints(data2);
    
    [data1, data2] = adaptBoundaries(data1, data2);
    
    t = [transpose(data1(:,1)); transpose(data1(:,2))];
    r = [transpose(data2(:, 1));transpose(data2(:, 2))];
    [~, distTrait1, ~, ~, ~, ~, ~] = deplacement(data1);
    [~, distTrait2, ~, ~, ~, ~, ~] = deplacement(data2);
    pres1 = pressure(data1);
    pres2 = pressure(data2);
    [Dist, ~ , ~ ,~] = dtw(t, r);

    dtw_score = 1 - Dist / caracFloors(1);
    curv_score = 1 - distancecurv(data1,data2,distTrait1,distTrait2) / caracFloors(2);
    frac_score = 1 - abs(fracDim1 - fracDim2) / caracFloors(3);
    press_score = 1 - abs(pres1-pres2) / caracFloors(4);

    score = coeff(1) * dtw_score + coeff(2) * curv_score + coeff(3) * frac_score + coeff(4) * press_score;
end