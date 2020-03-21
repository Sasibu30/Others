function [T3,T4] = Mechanism_Calculation(L1,L2,L3,L4,T2,handle)

%Link ratio
K1=L1/L2;
K2=L1/L4;
K3=( (L2)^2-(L3)^2+(L4)^2+(L1)^2 )/(2*L2*L4);
K4=L1/L3;
K5=( (L4)^2-(L1)^2-(L2)^2-(L3)^2 )/(2*L2*L3);
%%
if handle==1  %open

    %Calculate T3
    E=-2*sin(T2);
    D=cos(T2)-K1+K4*cos(T2)+K5;
    F=K1+(K4 -1)*cos(T2) + K5;

    T3=2*atan( ( -E-sqrt(E^2-4*D*F))/(2*D) );

%Calculate T4
    A=cos(T2)-K1-K2*cos(T2)+K3;
    B=-2*sin(T2);
    C=K1-(K2+1)*cos(T2)+K3;

    T4=2*atan(( -B-sqrt(B^2-4*A*C))/(2*A) );

elseif handle==2 %crossed

%Calculate T3
    E=-2*sin(T2);
    D=cos(T2)-K1+K4*cos(T2)+K5;
    F=K1+(K4 -1)*cos(T2) + K5;

    T3=2*atan( ( -E+sqrt(E^2-4*D*F))/(2*D) );

%Calculate T4
    A=cos(T2)-K1-K2*cos(T2)+K3;
    B=-2*sin(T2);
    C=K1-(K2+1)*cos(T2)+K3;

    T4=2*atan(( -B+sqrt(B^2-4*A*C))/(2*A) );

    
end

