%% Made By jsh
% This file is Main Start Code
% 1. Get Airfoil Coordinates Data fomr Data.txt
% 2. Get RHS
% 3. Cal. Cp & Plot
clear;
clc;

fileName = 'data.txt';
DA=importdata(fileName);
XY=DA;
    
XP = XY(:,1); YP = XY(:,2); N = length(XP);
[AN,AT,XC,YC,NHAT,THAT] = Before_Tre(XP,YP,N);
uinfty = 1;
for j=1:N
b(j,1) = uinfty*NHAT(j,1) +0*NHAT(j,2);
end
Sources = AN\b; ut = AT*Sources - THAT(:,1);
cp = 1 - ut.^2; plot(XC,cp,'-ok',XP,YP,'k')
xlabel(' x '),ylabel(' Cp ')