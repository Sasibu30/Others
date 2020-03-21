function [] = MainP6_2(hand,Z)
if hand==1
%initial condition

L1 = 56.4;
L2 = 25.4;
L3 = 52.3;
L4 = 59.2;



%% Input

for T2=-pi/1.5:pi/100:pi/1.5
    
w2 = 100; %rpm
ThetaA = 31/180*pi;
%fprintf('T2 = %f\n',T2);
%% Calculation
[T3 ,T4] = CalculationForP6_51(L1, L2 ,L3,L4,T2);
    


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

Px= Ax +77.7*cos(T3-ThetaA);
Py= Ay +77.7*sin(T3-ThetaA);

%Calculation
PVx = Px + V_P_x;
PVy = Py + V_P_y;

v=(V_P_x^2+V_P_y^2);
%=================

scale=10^-3;
PVx = Px + V_P_x*scale;
PVy = Py + V_P_y*scale;
%% Plot
%fprintf('T2 = %f\n',T2);
%fprintf('T2 = %f\n',T2);
%fprintf('T2 = %f\n',T2);



if rem(Z,2)==1
    
    plot(Px,Py,'o');
    hold on
    axis([-100 100 -100 100])
    title('4-Link-Mechanism')
else    
    x=[O2x Ax Bx Px Ax Bx O4x ];
    
    y=[O2y Ay By Py Ay By O4y ];
    
    plot(x,y,'linewidth',3);
    grid on
    axis([-100 100 -100 100])
    title('4-Link-Mechanism')

    hold on
   
    a=[Px PVx];
    b=[Py PVy];
    plot(a,b, 'linewidth',5,'Color',[0.1,0.5,0])
    hold off
end
       
drawnow() 
end
end