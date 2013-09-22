function [] = main(file1, file2)
% --------------- Beginning of pre-treatment -----------------------
    mat = readfile(file1);
    
    % Plot the point cloud, unchanged
    subplot(2, 2, 1), plot(mat(:,1), mat(:,2),'.');
    title('File 1');
    hold on;
    
    mat = moindreCarre(mat);
    data1 = translate(mat);
    [n2,r2] = boxcount(data1,'slope');
    df = -diff(log(n2))./diff(log(r2));
    disp(['Fractal dimension, Df = ' num2str(mean(df(4:8))) ' +/- ' num2str(std(df(4:8)))]);
    % Display points after translation
    plot(data1(:,1), data1(:,2), 'r.');
    data1 = reduceNbPoints(data1);
    showBoundingBox(data1);
    % See what changes the pre-treatment did
%     fid = fopen('test.txt', 'w');
%     [m, n] = size(data);
%     fprintf(fid, '%i\n', m);
%     for i=1:m
%         fprintf(fid,'%i %i %i %i %i %i %i\n', data(i,1), data(i,2), data(i,3), data(i,4), data(i,5), data(i,6), data(i,7));
%     end
%     fclose(fid);
    hline = refline(0, 0);
    set(hline,'Color','k');
    
    % --- Second File (Same treatment) ---
    
    mat = readfile(file2);
    
    % Plot the point cloud, unchanged
    subplot(2, 2, 3), plot(mat(:,1), mat(:,2),'.');
    title('File 2');
    hold on;
    
    mat = moindreCarre(mat);
    data2 = translate(mat);
    [n2,r2] = boxcount(data2,'slope');
    df = -diff(log(n2))./diff(log(r2));
    disp(['Fractal dimension, Df = ' num2str(mean(df(4:8))) ' +/- ' num2str(std(df(4:8)))]);
    % Display points after translation
    plot(data2(:,1), data2(:,2), 'r.');
    data2 = reduceNbPoints(data2);
    showBoundingBox(data2);
    hline = refline(0, 0);
    set(hline,'Color','k');
    
    % --- Shared pre-treatment ---
    
    % Maxe them have the same bounding box
    [data1, data2] = adaptBoundaries(data1, data2);
    
    %[data1, data2] = adjustNbPoint(data1,data2);
   
    % ----------------- End of pre-treatment ------------------------
    t1 = data1(1,3);
    t2 = data2(1,3);
    datatmp1(:,3) = data1(:,3)-t1;
    datatmp2(:,3) = data2(:,3)-t2;
    t = [transpose(data1(:,1)); transpose(data1(:,2)); transpose(datatmp1(:,3)); transpose(data1(:,5)); transpose(data1(:,6)); transpose(data1(:,7))];
    r = [transpose(data2(:, 1));transpose(data2(:,2)); transpose(datatmp2(:,3)); transpose(data2(:,5)); transpose(data2(:,6)); transpose(data2(:,7))];
    [depl1,distTrait1,distrapp1,distXrapp1,distYrapp1,distTanSum1,distTan1] = deplacement(data1);
    [depl2,distTrait2,distrapp2,distXrapp2,distYrapp2,distTanSum2,distTan2] = deplacement(data2);
    pres1 = pressure(data1);
    pres2 = pressure(data2);
    azi1 = azimuth(data1);
    azi2 = azimuth(data2);
    alt1 = altitude(data1);
    alt2 = altitude(data2);
    [tp1, vm1, vmv1, vmh1, vmax1, acc1] = dynamique(data1);
    [tp2, vm2, vmv2, vmh2, vmax2, acc2] = dynamique(data2);
    [Dist, D , k ,w] = dtw(t, r);
    fprintf('Distance: %i\n', Dist);
    dist1 = distancecurv(data1,data2,distTrait1,distTrait2);
    fprintf('Distance: %i\n', dist1);
    dist2 = distanceTime(data1,data2);
    fprintf('Distance: %i\n', dist2);
    fprintf('Distance cumul: %i\n', dist1+dist2+Dist);
    fprintf('Corel temp: %i\n', abs(correlTemp(data1)-correlTemp(data2)));
    figure;
    subplot(1, 2, 1);
    plot(data1(:,1),data1(:,2));
    subplot(1, 2, 2);
    plot(data2(:,1),data2(:,2));
end