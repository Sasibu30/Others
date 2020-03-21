function y=fun1(t,x00)
y=zeros(2,1);


F0=20; w=17; m=3; k=1000; c=2*sqrt(4*m*k);
y(1)=x00(2);
y(2)=-(k/m)*x00(1)-(c/m)*x00(2)+(F0/m)*cos(w*t);


