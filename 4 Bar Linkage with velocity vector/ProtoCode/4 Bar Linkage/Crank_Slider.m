function [] =Crank_Slider(handle)
%% set up
clc;

L2=40;  %a
L3=120; %b
c=-20;  %offset

disp('Calculation Completed');
disp(' ');
disp(' ');
disp('=====================================');

%% Movie

for T2=0:0.01:2*pi
    
%% Calculation
if handle ==1 
% open
T3=asin( (L2*sin(T2)-c)/L3 )+pi; %Theta 3 open

d=L2*cos(T2)-L3*cos(T3);
elseif handle==2

% crossed
T3=asin( (L2*sin(T2)-c)/L3 ); %Theta 3 crossed

d=L2*cos(T2)-L3*cos(T3);
end   
%% Position Exp
O2_x=0;
O2_y=0;

A_x=O2_x+L2*cos(T2);
A_y=O2_y+L2*sin(T2);

B_x=O2_x + d;
B_y=O2_y + 0 +c;

%% Graph Plot
x=[O2_x A_x B_x];
y=[O2_y A_y B_y];

plot(x,y,'LineWidth',10);
grid on
axis([-200 200 -200 200]);
drawnow;

%% Check
  
  fprintf('T2 = %f   T3 = %f \n',T2*180/pi,T3*180/pi)
  fprintf('d = %f\n',d);
  disp('');
end




