clear;
clc;

%초기값
x0=0.0;
dotx0=0.0;
x00=[x0,dotx0];

%계산
t=0:0.01:10;

[t,x]=ode23('fun1',t,x00);
[t1,x1]=ode23('fun2',t,x00);
[t2,x2]=ode23('fun3',t,x00);

X=fft(x(:,1));
N=length(X);
M=floor(N/2);
fHZ=(1/max(t))*[0:M-1];

plot(t,x(:,1));
hold on
plot(t,x1(:,1));
hold on
plot(t,x2(:,1));
hold off
grid on

xlabel('Time(s)','fontsize',13);
ylabel('Displacement (m)','fontsize',13);
title('감쇠비에 따른 응답 비교','fontsize',12);
legend('감쇠비 = 2','감쇠비 = 1','감쇠비 = 0.1');


