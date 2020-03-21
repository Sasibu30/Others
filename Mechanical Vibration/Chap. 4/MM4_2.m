clear;
clc;

%% Mathematical 
y=zeros(251,1);
t=0:0.02:5;

for k=0:250;
    t1=t(1,k+1);
    y(k+1,1)=1-(exp(-0.9*t1))*( cos(30*t1) + 0.03*sin(30*t1) );
end

figure(1);
plot(t,y,'linewidth',1)
grid on
xlabel('Time(s)','fontsize',13);
ylabel('Displacement (m)','fontsize',13);
title('Mathematical Calculation','fontsize',12)
    
%%
clear;
%By Runge Kutta method

x0=0.1;
dotx0=0.2;
x00=[x0,dotx0];
t=0:0.02:5;
[t,x]=ode23('M4_2_function',t,x00);

X=fft(x(:,1));
N=length(X);
M=floor(N/2);
fHZ=(1/max(t))*[0:M-1];

figure(2);
plot(fHZ,abs(X(1:M)))
xlabel('Frequency (Hz)','fontsize',13);
ylabel('Magnitude','fontsize',13);
grid on

figure(3);
plot(t,x(:,1),'r');
grid on
xlabel('Time(s)','fontsize',13);
ylabel('Displacement (m)','fontsize',13);
title('By Runge Kutta method','fontsize',12);







