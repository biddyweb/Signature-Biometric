function [] = main(file1, file2)
% --------------- Beginning of pre-treatment -----------------------
    mat = readfile(file1);
    
    % Plot the point cloud, unchanged
    plot(mat(:,1), mat(:,2),'.');
    title('File 1');
    hold on;
    
    [mat] = moindreCarre(mat);
    data1 = translate(mat);
    % See what changes the pre-treatment did
%     fid = fopen('test.txt', 'w');
%     [m, n] = size(data);
%     fprintf(fid, '%i\n', m);
%     for i=1:m
%         fprintf(fid,'%i %i %i %i %i %i %i\n', data(i,1), data(i,2), data(i,3), data(i,4), data(i,5), data(i,6), data(i,7));
%     end
%     fclose(fid);
    t = [transpose(data1(:,1)); transpose(data1(:,2))];
    hline = refline(0, 0);
    set(hline,'Color','k')
    figure;
    
    % --- Second File (Same treatment) ---
    
    mat = readfile(file2);
    
    % Plot the point cloud, unchanged
    plot(mat(:,1), mat(:,2),'.');
    title('File 2');
    hold on;
    
    mat = moindreCarre(mat);
    data2 = translate(mat);
    r = [transpose(data2(:, 1));transpose(data2(:, 2))];
    hline = refline(0, 0);
    set(hline,'Color','k')
   
    % ----------------- End of pre-treatment ------------------------
    dist = deplacement(data1,data2);
    fprintf('Distance: %i\n', dist);
    [Dist, D , k ,w] = dtw(t, r);
    fprintf('Distance: %i\n', Dist);
end