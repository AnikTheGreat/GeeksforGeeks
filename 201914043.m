points = [1,51;2,54;3,56;4,61;5,70;6,88;7,123;8,164;9,218;10,330;11,424;12,482;13,621;14,803;15,1012;16,1231;17,1572;18,1838;19,2144;20,2456;21,2948;22,3382;23,3772;24,4186;25,4689;26,4998;27,5416;28,5913;29,6462;30,7103;31,7667;32,8238;33,8790;34,9455;35,10143;36,10929;37,11719;38,12425;39,13134;40,13770;41,14657;42,15691;43,16660;44,17822;45,18863;46,20065;47,20995;48,22268;49,23870;50,25121;51,26738;52,28511;53,30205;54,32078;55,33610;56,35585;57,36751;58,38292;59,40321;60,42844;61,44608];    
x = points(:,1);
global y;
y = points(:,2);

plot(x,y,'O');
title("Total Cases vs Date"),grid on,xlabel("Date"),ylabel("Total Case");
hold on;
nsize=size(points,1);
sumx = sum(x);
sumx2 = sum(x.^2);
sumy = sum(y);
sumx3 = sum(x.^3);
sumxy = sum(x.*y);
sumx4 = sum(x.^4);
sumx2y = sum((x.^2).*y);
A = [nsize,sumx,sumx2;sumx,sumx2,sumx3;sumx2,sumx3,sumx4];
b = [sumy;sumxy;sumx2y];
AB=[A, b];

%Partial Pivoting Mechanism

[m,n]=size(AB);

for j=1:m-1
    for i=1:m-1
    if(AB(i,1)<AB(i+1,1))
        for k=1:n
        temp=AB(i,k);
        AB(i,k)=AB(i+1,k);
        AB(i+1,k)=temp;
        end
    end
    end
end

%Naive Gauss Elimination method

apex=AB(2,1)/AB(1,1);
AB(2,:)=AB(2,:)- apex*AB(1,:);
apex=AB(3,1)/AB(1,1);
AB(3,:)=AB(3,:)- apex*AB(1,:);

apex=AB(3,2)/AB(2,2);
AB(3,:)=AB(3,:)-apex*AB(2,:);

eq=zeros(3,1);

for i=m:-1:1
    eq(i)=(AB(i,end)-AB(i,i+1:m)*eq(i+1:m))/AB(i,i);
end
a0 = eq(1);
a1=  eq(2);
a2 = eq(3);
global ypred;
ypred = a0 + a1*x + a2*(x.^2);
plot(x,ypred);
st = sum((y-sumy/nsize).^2);
sr = sum((y-a0-a1*x-a2*(x.^2)).^2);
r = (st-sr)/st;

fprintf("Goodnes of fit is %f percent\n",r*100);
in = input('Enter tha Date please: ');
fprintf("The actual Number of Cases is: %d\n",actual(in));
fprintf("The predicted Number of Cases is: %f\n",pred(in));

function [out] = actual(z)
global y;
out = y(z);
end
function [out] = pred(z)
global ypred;
out = ypred(z);
end