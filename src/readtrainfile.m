function res = readtrainfile(file)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    fid=fopen(file);
    i = 1;
    while 1
        tline = fgetl(fid);
        if ~ischar(tline)
            break;
        end
        if ~strcmp(tline, '')
            C = textscan(tline, '%s', 'delimiter', ' ');
            res(i) = C;
            i = i + 1;
        end
    end
    fclose(fid);
end

