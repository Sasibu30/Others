function [v] = MainP6_1_v(T2)
%initial condition

L1 = 244.5;
L2 = 50.8;
L3 = 212.7;
L4 = 182.5;



%% Input


    
w2 = 500; %rpm

%% Calculation
[T3 ,T4] = CalculationForP6_51(L1, L2 ,L3,L4,T2);
    


w4 = ( L2*w2 )*( sin( T2 - T3) )/( L4 * sin( T4 -T3 ) );  %rpm

% V_Calculation

V_B_x=L4*w4*(-sin(T4 ));
V_B_y=L4*w4*(cos(T4 ));

v=sqrt(V_B_x^2+V_B_y^2);


