function LB = buf_kon(Pp,Pv,maxBuffer,pocet)
format short

maxVstup = 1;                                % moze naraz prist
maxVystup = 1;                               % moze naraz odist
vstup = binornd(maxVstup,Pp,[1,pocet]);      % co prichadza
prijate = 0;                                 % kolko paketov bolo prijatych
vystupT = binornd(maxVystup,Pv,[1,pocet]);   % teoreticky mozny vystup
vystupR = zeros(1,pocet);                    % realny vystup z buffra
buffer = zeros(1,pocet);                     % zaplnenie buffra

for i = 1 : pocet
    
    prijate = prijate + vstup(i);
   
    if prijate > maxBuffer
        prijate = maxBuffer;
    end
 
    if prijate >= vystupT(i)
        prijate = prijate - vystupT(i);
        vystupR(i) = vystupT(i);
        buffer(i) = prijate;
    else
        vystupR(i) = prijate;
        prijate = 0;
        buffer(i) = prijate;
    end
end

Histogram = zeros(1,maxBuffer+1);
for i = 1 : pocet
  Histogram(buffer(i)+1) = Histogram(buffer(i)+1)+1;
end

figure('name', 'Tok');
subplot(3,1,1);
plot(vstup);
axis([1 pocet -0.1 maxVstup+0.1]);
title('Vstupny signal Bi(1,Pp)');
subplot(3,1,2);
plot(vystupT);
axis([1 pocet -0.1 maxVystup+0.1])
title('Vystup Bi(1,Pv)');
subplot(3,1,3);
plot(vystupR);
axis([1 pocet -0.1 maxVystup+0.1])
title('Realny vystup z buffra');

figure('name', 'Buffer');
subplot(2,1,1);
plot(buffer);
axis([1 pocet 0 maxBuffer+0.5]);
title('Zaplnenie buffra');
subplot(2,1,2);
bar(0:maxBuffer,Histogram);
axis([-0.5 maxBuffer+0.5 0 max(Histogram)+2]);
title('Histogram');

% disp('Vyuzitie vysielaca [%]');
% disp(length(vystupnyTok(vystupnyTok>0))/pocet*100);

end

