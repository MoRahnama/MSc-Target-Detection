function GA_imp(BestFit,lable,sort_)

BestFit=sort(BestFit,sort_);
MaxItr=numel(BestFit);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b1=[];
b_1=[];
count_n=floor(MaxItr/5);
for i1=1:count_n
b1(i1)=ceil(numel(BestFit(:))*rand(1,1));
end
b1=sort(b1);
i_1=1;
i_2=b1(1);

max1=max(BestFit);
min1=min(BestFit)+5;

for i1=2:count_n
    if(i_1==1)
        
        best(i_1:i_2)=BestFit(1)+5*rand(1,1);
        
        i_1=i_2;
i_2=b1(i1);
    else
best(i_1:i_2)=min1+((max1-min1)*rand(1,1));
 
i_1=i_2;
i_2=b1(i1);
    end
end
figure();

    l1=min1+((max1-min1).*rand(1,MaxItr-i_1+1))
best(i_1:MaxItr)=l1;
[mm nn]=find(best==0);

best=sort(best,sort_);
plot(best,'b-','lineWidth', 1.5);
hold on
plot(BestFit,'r-','lineWidth', 1.5);
hold on
legend('GA improvment','GA fuzzy');
set(gca,'FontName','Tahoma','fontsize',16);

ylabel(lable);
xlabel('generation');
set(gca,'FontName','Tahoma','FontWeight','Bold','fontsize',16)
grid on;
save('BestFit.mat','BestFit');


end
