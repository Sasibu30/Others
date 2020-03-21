clear;
clc;

%%
%By Runge Kutta method
x1=1; 
dotx1=0;
x2=0; 
dotx2=0;
x3=0; 
dotx3=0;

x0=[x1; dotx1; x2; dotx2; x3; dotx3;];
t=0:0.01:5;
[t,x] = ode23('M8_2_function',t,x0);

plot(t, x(:,1),t, x(:,3), t, x(:,5),'r:'); % Runge Kutta method
xlabel('Time (s)');
ylabel('Displacement (m)'); grid on
legend('x1(t)','x2(t)','x3(t)');












