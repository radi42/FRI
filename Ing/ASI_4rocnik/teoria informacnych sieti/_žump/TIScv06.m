a=0.4;
b=0.6;
n=1000;
x=zeros(1,n);
X=zeros(2,n);
x(1,1)=1;
X(1,1)=sum(x);
for i=2:n    
   if(x(1,i-1) == 1)
       if (rand(1)>b)
           x(1,i)=0;
       else
           x(1,i)=1;
       end
   else
       if (rand(1)>a)
           x(1,i)=1;
       else
           x(1,i)=0;
       end
   end
   X(1,i)=sum(x)/i;
end
X(2,1:n)=ones(1,n)-X(1,1:n);
plot(1:n,X(1,1:n),1:n,X(2,1:n));