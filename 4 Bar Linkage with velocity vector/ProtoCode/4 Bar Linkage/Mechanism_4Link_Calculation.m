function []=Mechanism_4Link_Calculation(handle,T2)
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

   
    [T3,T4] = Mechanism_Calculation(L1,L2,L3,L4,T2,handle);  % T3 T4 ������ ���� �ؾߵǴµ� �ڵ� ������ ���� �� �ؼ�
        
    

   if handle==1
       disp('Open');
   elseif handle==2
       disp('Crossed');
   end
   
   disp('==================');
   fprintf('Theta3 = %f\n',T3*180/pi);
   fprintf('Theta4 = %f\n',T4*180/pi);







