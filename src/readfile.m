function [C] = readfle( name )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    fid=fopen(name);
    l = textscan(fid,'%n',1);
    s = l{1};
    C = zeros(s, 7);
    for i=1:s
        temp = textscan(fid, '%n %n %n %n %n %n %n',1);
        for j=1:7
            C(i,j)=temp{j};
        end
    end
end

