function []=Mechanism_4Link(handle)
%% ============ Set up ===================

L1=100;
L2=40;
L3=120;
L4=80;

%% Calculation Section
%% Commander Al
disp('Calculation Completed');
disp(' ');
disp(' ');
disp('================================');



%% Movie 
for T2=0:0.1:20
    
    [T3,T4] = Mechanism_Calculation(L1,L2,L3,L4,T2,handle);  % T3 T4 저장을 따로 해야되는데 코딩 상으로 저장 안 해서
    
    
    %% Position Exp
    O2_x=0;
    O2_y=0;

    O4_x=O2_x + L1;
    O4_y=O2_y + 0;

    A_x=O2_x + L2*cos(T2);
    A_y=O2_y + L2*sin(T2);

    B_x=O4_x + L4*cos(T4);
    B_y=O4_y + L4*sin(T4);
    
    
    %% Graph Plot
    
    x=[O2_x A_x B_x O4_x ];
    
    y=[O2_y A_y B_y O4_y ];
    
    plot(x,y,'linewidth',10);
    axis([-150 150 -150 150]);
    grid on
    title('4-Link-Mechanism')
    drawnow;
    
    
    
  %% Check
  
  fprintf('T2 = %f   T4 = %f \n',T2*180/pi,T4*180/pi);
end
  
    
  












