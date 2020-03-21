function [v] = MainP6_2_v(T2)
%initial condition

L1 = 56.4;
L2 = 25.4;
L3 = 52.3;
L4 = 59.2;



%% Input


    
w2 = 100; %rpm
ThetaA = 31/180*pi;
%fprintf('T2 = %f\n',T2);
%% Calculation
[T3 ,T4] = CalculationForP6_51(L1, L2 ,L3,L4,T2);
    


w3 = ( L2*w2 )*( sin( T4 - T2))/( L3 * sin( T3 -T4) );  %rpm

[V_P_x , V_P_y] = V_For_P(L1,w2,w3,T3,T2,ThetaA);

v=sqrt(V_P_x^2+V_P_y^2);
%=================
