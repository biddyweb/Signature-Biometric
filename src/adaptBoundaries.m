function [dataNew1, dataNew2] = adaptBoundaries(data1, data2) 

% Same width
[data1, data2] = adaptDim(1, data1, data2);
% Same Height
[dataNew1, dataNew2] = adaptDim(2, data1, data2);

%subplot(2, 2, 2), plot(dataNew1(:,1), dataNew1(:,2), '.');
%title('Final set of point used for file 1');
%hline = refline(0, 0);
%set(hline,'Color','r');

%subplot(2, 2, 4), plot(dataNew2(:,1), dataNew2(:,2), '.');
%title('Final set of point used for file 2');
%hline = refline(0, 0);
%set(hline,'Color','r');
end