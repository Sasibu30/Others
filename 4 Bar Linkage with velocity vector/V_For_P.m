function [V_P_x , V_P_y] = V_For_P(L1,w2,w3,T3,T2,ThetaA)



V_A_x=w2*L1*cos(pi/2-T2);
V_A_y=w2*L1*sin(pi/2-T2);

V_PA_x=0.97*w3*(-sin(T3 + ThetaA));
V_PA_y=0.97*w3*(cos(T3 + ThetaA));


V_P_x=V_PA_x +V_A_x;
V_P_y=V_PA_y +V_A_y;

