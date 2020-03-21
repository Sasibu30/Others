function y = MM3_7_fun(t,x)
y=zeros(2,1);
y(1)=x(2);
y(2)=-0.2*x(2)-50*x(1)+2;
end