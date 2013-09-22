close all;
clear;
trainfunc('trainlst.txt');
testfunc('train.mat', 'testlst.txt');
%main('USER1_2.txt','USER1_3.txt');
%distvect = testTrait([1], 10);