function [] = MainP6(hand)
%% Set
clc;
clear;

%initial condition
L1 = 1.82;
L2 = 0.72;
L3 = 0.68;
L4 = 0.85;
ThetaA = 54/180*pi;
%% Input

for T2=-pi/3.3:pi/100:pi/3.3
    

%fprintf('T2 = %f\n',T2);
%% Calculation
[T3 ,T4] = CalculationForP6_51(L1, L2 ,L3,L4,T2);
    

w2 = 80; %rpm
w3 = ( L2*w2 )*( sin( T4 - T2))/( L3 * sin( T3 -T4) );  %rpm

[V_P_x , V_P_y] = V_For_P(L1,w2,w3,T3,T2,ThetaA);

 %% position
O2x=0;
O2y=0;

O4x=O2x + L1;
O4y=O2y + 0;

Ax=O2x + L2*cos(T2);
Ay=O2y + L2*sin(T2);

Bx=O4x + L4*cos(T4);
By=O4y + L4*sin(T4);

Px= Ax +0.97*cos(T3+54/180*pi);
Py= Ay +0.97*sin(T3+54/180*pi);

PVx = Px + V_P_x;
PVy = Py + V_P_y;

%% Plot
%fprintf('T2 = %f\n',T2);
%fprintf('T2 = %f\n',T2);
%fprintf('T2 = %f\n',T2);

x=[O2x Ax Px Bx Ax Bx O4x ];
    
y=[O2y Ay Py By Ay By O4y ];
    
plot(x,y,'linewidth',10);
grid on
axis([0 2 -1 2])
title('4-Link-Mechanism')

hold on
a=[Px PVx];
b=[Py PVy];
plot(a,b, 'linewidth',5,'Color',[0.1,0.5,0])
hold off
       
drawnow() 
end