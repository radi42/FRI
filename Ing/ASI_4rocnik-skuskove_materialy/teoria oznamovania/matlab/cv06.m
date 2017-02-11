clc;
clear all;
slovo=[2,2,2,1,2,-1,1,-1,2,1,2,2,1,1,-1,-1,2,2,2,1,1,0,-1,2];
pocBit=24;
pocBaz=24;
dlzkaS=size(slovo);
pocet=dlzkaS(2)*pocBit;
povodny=zeros(1,pocet);
sum=[0,0,1,0, 1,1,0,1, 1,1,1,0, 0,1,1,1, 0,1,1,0, 0,1,0,0, 1,1,0,1, 0,1,1,1, 1,0,0,1];
v=[1,1,1,1 ; 1,-1,1,-1 ; 1,1,-1,-1 ; 1,-1,-1,1];
vSum=zeros(1,pocBaz);
for i = 1:pocBaz
    for j =1:pocBit
        vSum(1,i)=v(i,j)*v(i,j)+vSum(1,i);     
    end;
end;
for i = 1:dlzkaS(2)
    for j = 1:pocBit
    povodny(i*pocBit-pocBit+j)=v(slovo(i),j);
    end;
end;
vysledny=povodny+sum;
fprintf('slovo je:\n');
disp(slovo);
%fprintf('sumy:\n');
%disp(vSum);
disp('bazy su:');
disp(v);
%disp('slovo iduce sietou');
%disp(povodny);
%disp('šum');
%disp(sum);
%disp('k prijmacu dorazi');
%disp(vysledny);
hladasMax=zeros(pocBaz,1);
akeMax=zeros(1,mod(pocet,pocBit));
fprintf('Interpretácia slova po odšumení vyzerá takto: \n');
fprintf('{');
for k = 1:pocet
    if mod(k,pocBit)==1
        for i = 1:pocBaz
            for j = 1:pocBit
                hladasMax(i,1)=vysledny(k-1+j)*v(i,j)+hladasMax(i,1);
            end;
            hladasMax(i,1)=hladasMax(i,1)/vSum(1,i);      
        end;
        akeMax(mod(k,pocBit))=hladasMax(1,1);
        for i = 1:pocBaz  
            if akeMax(mod(k,pocBit))<=hladasMax(i,1)
                akeMax(mod(k,pocBit))=hladasMax(i,1);      
            end;    
        end;
        %fprintf('Vhodny bazicky vektor pre %1.2f je ',akeMax(mod(k,pocBit)));
        for i = 1:pocBaz
            if akeMax(mod(k,pocBit))==hladasMax(i,1)
                fprintf('%d ',i);
            end;    
        end;
        fprintf(' ;  ');
        %fprintf(' vektor\n');
        hladasMax=zeros(pocBaz,1);
    end;
end;
fprintf(' }\n');