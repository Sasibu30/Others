function y=M4_2_function(t,x00)
y=zeros(2,1);

A=1; w=0; m=5; 
wn=30;
y(1)=x00(2);
y(2)=-(wn)^2*x00(1)-(0.06*wn)*x00(2)+0.06*wn*(-A*w*sin(w*t))+wn^2*(A*cos(w*t));