function [v] = MainP6_v(T2)
%% Set

%initial condition
L1 = 1.82;
L2 = 0.72;
L3 = 0.68;
L4 = 0.85;


%% Input

  
w2 = 80; %rpm
ThetaA = 54/180*pi;
%% Calculation
[T3 ,T4] = CalculationForP6_51(L1, L2 ,L3,L4,T2);
   

w3 = ( L2*w2 )*( sin( T4 - T2))/( L3 * sin( T3 -T4) );  %rpm

[V_P_x , V_P_y] = V_For_P(L1,w2,w3,T3,T2,ThetaA);



%Calculation
v=sqrt(V_P_x^2+V_P_y^2);

%============================


