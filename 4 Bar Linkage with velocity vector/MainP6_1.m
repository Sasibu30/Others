function [] = MainP6_1(hand,Z)
if hand==2
%initial condition

L1 = 244.5;
L2 = 50.8;
L3 = 212.7;
L4 = 182.5;



%% Input

for T2=-pi:pi/90:pi
    
w2 = 500; %rpm

%% Calculation
[T3 ,T4] = CalculationForP6_51(L1, L2 ,L3,L4,T2);
    


w4 = ( L2*w2 )*( sin( T2 - T3) )/( L4 * sin( T4 -T3 ) );  %rpm

% V_Calculation

V_B_x=L4*w4*(-sin(T4 ));
V_B_y=L4*w4*(cos(T4 ));

v=(V_B_x^2+V_B_y^2);

 %% position
O2x=0;
O2y=0;

O4x=O2x + L1*cosd(43);
O4y=O2y - L1*sind(43);

Ax=O2x + L2*cos(T2-43/180*pi);
Ay=O2y + L2*sin(T2-43/180*pi);

Bx=O4x + L4*cos(T4-43/180*pi);
By=O4y + L4*sin(T4-43/180*pi);

scale =10^-3;
V_x=Bx+V_B_x*scale;
V_y=By+V_B_y*scale;



%fprintf('v = %f\n',v);
%% Plot
%fprintf('T2 = %f\n',T2);
%fprintf('T2 = %f\n',T2);
%fprintf('T2 = %f\n',T2);



if rem(Z,2)==1
    
    plot(Bx,By,'o');
    hold on
    axis([-100 300 -300 100])
    title('4-Link-Mechanism')
else    
    x=[O2x Ax Bx  O4x ];
    
    y=[O2y Ay By  O4y ];
    
    plot(x,y,'linewidth',3);
    grid on
    axis([-100 300 -300 100])
    title('4-Link-Mechanism')

    hold on
    
    a=[Bx V_x];
    b=[By V_y];
    plot(a,b, 'linewidth',5,'Color',[0.1,0.5,0])
    hold off
end
       
drawnow() 
end
end