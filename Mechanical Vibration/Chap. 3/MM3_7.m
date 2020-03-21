function []=MM3_7()
clear;
clc;
%%
t=0:0.01:2;
x0=[0.1;0.2];
[t,x] = ode23('MM3_7_fun',t,x0);
plot(t,x(:,1))
xlabel('Time (s)','fontsize',13);
ylabel('Displacement (m)', 'fontsize',13);grid

end

