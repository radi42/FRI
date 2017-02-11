gen=1000;
matPrech=[0.2, 0.5, 0.3; 0.3, 0.5, 0.2; 0.6, 0.1, 0.3];
kumMat=cumsum(matPrech,2);


a=zeros(1,gen);
a(1)=1;
stavy=zeros(3,gen);
x=zeros(3,gen);
stavy(2,1)=1;
x(2,1)=1;


for i=2:gen
   predtym = a(i-1);
   r=rand(1);
   for j=1:3
       if(r < kumMat(predtym+1,j))
           a(i) = j-1;
           break;
       end
   end
   stavy(a(i)+1,i)=1;
   for k=1:3
       x(k,i) = sum(stavy(k,:))/i;
   end
end
plot(1:gen,x(1,:), 1:gen,x(2,:), 1:gen,x(3,:));
%kontrola = P^20;
%kontrola1 = Y(:,n);
