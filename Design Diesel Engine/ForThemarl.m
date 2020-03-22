clear;
clc;
%%
k=1.4;
r=10;
rc=3;
dim=50;         %rpm interval

for r=10:19
    
    % Calculate P ,v , T
    for rc=2:10
    T1=288;
    P1=101.3;
    v1=0.816;

    v2=v1/r;
    T2=T1*(v1/v2)^(k-1);
    P2=P1*(v1/v2)^(k);

    v3=rc*v2;
    T3=T2*(v3/v2);
    P3=P2;

    v4=v1;
    T4=T3*(v3/v4)^(k-1);
    P4=P3*(v3/v4)^(k);
    
    %Search proper Temperature
    
    if T3<1500       
        fprintf('r=%f ---- rc=%f\n',r,rc);
        rpm = linspace(1000,3000,dim);
    
         for v0=1000:1000:3000;         % fuel unit cc



           v=v0*10^(-6);                %fuel unit m^3
    
           m=v/v1;
           disp('======================= ');
           fprintf('CC=%f\n',v0); 
           
            for n=1:4                   %number of engine cylinder
    
                fprintf('n=%f\n',n);            
                hp=n*m*1/60 * rpm *(1.005*(T3-T2) - 0.718*(T4-T1))/0.764;
        
             for i=1:dim
                if 295<hp(i) && hp(i)<305           %Search nearly 300HP
        
                Qin  = 6*1.005*(T3-T2);
                Qout = 6*0.718*(T4-T1);
                actual_Qin = m*n*0.718*(T4-T1);
                Nth= 1-((0.718*(T4-T1))/(1.005*(T3-T2)));
                oil=45187.2;                        %Fuel Heating (kj/kg)
                Am = (n*hp(i)*1/Nth)/oil;           %Fuel Comsuption        
    
    
                disp(' ');
                fprintf('hp=%f ---\n',hp(i)); 
                disp(' ');
                fprintf('Qin = %f\n',Qin);
                disp(' ');
                fprintf('Qout = %f\n',Qout);
                disp(' ');
                fprintf('Actual Qin = %f\n',actual_Qin);
                disp(' ');
                fprintf('연료소모량 = %f\n', Am);
                disp(' ');
                fprintf('N(th) = %f\n',Nth);
        
                disp(' ');
         
         
         
                end
             end
             disp('end');
             
            end
         end
    end
    end
end





