clc
clear all
%close all
format short

% slotovanie

count = 2000;
probability = 0.5;
slotSize = 50;

a = zeros(1, count);

for i = 1:count
    if (rand() < probability) 
        a(i) = 1;
    end
end

subplot(2,1,1)
plot(a);

b = zeros(1, count/slotSize);
index = 1;
for j = 1 : slotSize : count
    s = 0;
    for k = j : (j+slotSize-1)
        s = s + a(k);
    end
    b(index) = s;
    index = index + 1;
end

subplot(2,1,2);
plot(b);


% %on/off - stav 0 a 1
% count = 1000;
% probability = 0.5; % pravdepodobnost ze zacinam v stave 1
% alfa = 0.2; %z nuly do jednotky
% beta = 0.8; %z jednotky do nuly
% data = zeros(1, count);
% probabilities = zeros(1, count);
% 
% if rand() < probability 
%     data(1) = 0;
% else
%     data(1) = 1;
% end
% 
% for i = 2:count
%     if data(i-1) == 0
%         %ak som v nule
%         if rand() < alfa 
%             %preskocim do jednotky
%             data(i) = 1;
%         else
%             %inak ostavam v nule
%             data(i) = 0;
%         end
%     else
%         %ak som v jednotke
%         if rand() < beta
%             %preskocim do nuly
%             data(i) = 0;
%         else
%             %inak ostavam v jednotke
%             data(i) = 1;
%         end
%     end
% end
% 
% 
% for time = 1 : count
%     sum = 0;
%     for i = 1 : time
%         if data(i) == 1
%             sum = sum + 1;
%         end
%     end
%     %fprintf('do casu %d bolo %d jednotiek\n', time, sum);
%     probabilities(time) = sum / time;
% end
% 
% t = linspace(1, count, count);
% %plot(t,data,0,-0.1,2,1.1)
% subplot(2,1,1);
% plot(data);
% subplot(2,1,2);
% plot(t, probabilities, t, 1-probabilities);
% 
% %matica prechodov
%  A = [0.3 0.7; 0.2 0.8];
%  p = [0, 1];
%  p = p*A;
%  p = p*A;
%  p = p*A;
%  p = p*A;
%  p = p*A;
%  p = p*A;
%  disp(p)
% %alebo
% disp(A^10)


