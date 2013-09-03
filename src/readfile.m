function [C] = readfile( name )
    fid=fopen(name);
    l = textscan(fid,'%n',1);
    nLines = l{1};
    C = zeros(nLines, 7);
    for i=1:nLines
        temp = textscan(fid, '%n %n %n %n %n %n %n',1);
        for j=1:7
            C(i,j)=temp{j};
        end
    end
    fclose(fid);
end

