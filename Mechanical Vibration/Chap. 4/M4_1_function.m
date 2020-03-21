function y=M4_1_function(t,x00)
y=zeros(2,1);

F0=500; w=16*pi; m=5; k=2000; c=0;
y(1)=x00(2);
y(2)=-(k/m)*x00(1)-(c/m)*x00(2)+(F0/m)*cos(w*t);