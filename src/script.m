close all;
clear;
%readfile('Reda_27092013_103517.txt');
%readfile('Reda_27092013_103529.txt');
%readfile('Reda_27092013_103547.txt');
trainfunc('trainlst.txt');
testfunc('train.mat', 'testlst.txt');
%main('USER1_2.txt','USER1_3.txt');
%distvect = testTrait([1], 10);