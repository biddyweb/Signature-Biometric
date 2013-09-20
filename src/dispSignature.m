function dispSignature(n)
    for i=1:6
        path = strcat('USER', int2str(n));
        path = strcat(path, '_');
        path = strcat(path, int2str(i));
        path = strcat(path, '.txt')
        C = readfile(path);
        subplot(2, 3, i);
        plot(C(:,1), C(:,2));
    end
end