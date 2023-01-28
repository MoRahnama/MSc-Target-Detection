function genetic_fuzzy()
global E_elec E_amp node_count screen paket_size position_sensor position_target station people pop_size count_generation target_count w1 w2 w3 w4 rediuce E_max
clc;
close all;
clc;
E_elec=50;
E_amp=10;
node_count=350;
target_count=75;
w1=0.3;
w2=0.2;
w3=0.2;
w4=0.3;
paket_size=200;
rediuce=30;
screen=500;
station=[floor(screen/2) floor(screen/2)];
people=[];
position_sensor=[];
people=struct('live_node',{},'fitness',{});
pop_size=100;%input('count of people:');
set_position();
E_max=Emax();
initial_first();
p1(1).fitness=0;
generation=input('count of generation:');
initial_first();
for i=1:generation
   clc
   it=i
   crossover_all();
   mutation();
   selection();
   best_cost(i)=people(1).fitness;
   en(i)=fit1(people(1));
 if(p1(1).fitness<people(1).fitness)
     p1=people(1);
     best_fit=p1(1).fitness;
     p2=people(1).live_node;
 end
 
end
live_node=numel(find(p2==1))
best_cost=sort(best_cost);
%plot(best_cost,'r-','lineWidth', 1.5);
GA_imp(best_cost,'fitness','ascend');
% set(gca,'FontName','Tahoma','fontsize',12);
% ylabel('fitness');
% xlabel('generation');
% set(gca,'FontName','Tahoma','FontWeight','Bold','fontsize',12)
% grid on;


best_cost=sort(en,'descend');
GA_imp(best_cost,'energy','descend');
%plot(best_cost,'b-','lineWidth', 1.5);
% set(gca,'FontName','Tahoma','fontsize',12);
% %ylabel('enerjy');
% %xlabel('generation');
% set(gca,'FontName','Tahoma','FontWeight','Bold','fontsize',12)
% grid on;


end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %                  wsn                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y=fit(pop)
global node_count target_count w1 w2 w3 w4  E_max
E_min=E(pop);
g=cal_g(pop);
gama=cal_gama(pop);
n=cal_n(pop);
K=target_count;
N=node_count;
y=100*(w1*(1-g/N)+w2*(gama/K)+w3*((n)/N)+w4*(E_min/E_max));
end

function en=fit1(pop)
global node_count target_count w1 w2 w3 w4  E_max
en=E(pop);
end

function y=Emax()
global E_elec E_amp node_count screen paket_size position_sensor 
p1=[];
l=paket_size;
 sum_energy=0;
  for i=1:node_count
        for j=1:node_count
           d=sqrt(((position_sensor(i,1)-position_sensor(j,1))^2)+((position_sensor(i,2)-position_sensor(j,2))^2));
           Er=(E_elec*l)+(E_amp*l*d*d);     
           ER=(E_elec*l);
           sum_energy=Er+ER+sum_energy;
        end
  end

for i=1:node_count
           d=sqrt(((position_sensor(i,1)-(screen/2))^2)+((position_sensor(i,2)-(screen/2))^2));
           Er=(E_elec*l)+(E_amp*l*d*d);     
           ER=(E_elec*l);
           sum_energy=Er+ER+sum_energy;
end
 
y=sum_energy;

end

function y=E(pop)
global E_elec E_amp screen paket_size position_sensor 
p1=[];
l=paket_size;
m1=find(pop(1).live_node==1);
 sum_energy=0;
for i=1:numel(m1)
    for j=1:numel(m1)
           d=sqrt(((position_sensor(m1(i),1)-position_sensor(m1(j),1))^2)+((position_sensor(m1(i),2)-position_sensor(m1(j),2))^2));
           Er=(E_elec*l)+(E_amp*l*d*d);     
           ER=(E_elec*l);
           sum_energy=Er+ER+sum_energy;
        end
  end

for i=1:numel(m1)
           d=sqrt(((position_sensor(m1(i),1)-(screen/2))^2)+((position_sensor(m1(i),2)-(screen/2))^2));
           Er=(E_elec*l)+(E_amp*l*d*d);     
           ER=(E_elec*l);
           sum_energy=Er+ER+sum_energy;
end
y=sum_energy;
end

function g=cal_g(pop)
m1=find(pop(1).live_node==1);
g=numel(m1);
end

function gama=cal_gama(pop)
global E_elec E_amp node_count screen paket_size position_sensor position_target station people pop_size count_generation target_count w1 w2 w3 w4 rediuce
m1=find(pop(1).live_node==1);
gama=0;
for j=1:target_count
   bama=0; 
  for i=1:numel(m1)
          d=sqrt(((position_sensor(m1(i),1)-position_target(j,1))^2)+((position_sensor(m1(i),2)-position_target(j,2))^2));
          if(d<=rediuce)
            bama=bama+1;
          end
  end
  if(bama>0)
      gama=gama+1;
  end
end

end

function n=cal_n(pop)
global E_elec E_amp node_count screen paket_size position_sensor position_target station people pop_size count_generation target_count w1 w2 w3 w4 rediuce
m1=find(pop(1).live_node==1);
n=0;
for i=1:numel(m1)
    m=0;
  for j=1:numel(m1)
          d=sqrt(((position_sensor(m1(i),1)-position_sensor(m1(j),1))^2)+((position_sensor(m1(i),2)-position_sensor(m1(j),2))^2));
          if(d<=rediuce)
            m=m+1;
          end
  end
  if(m>0)
      n=n+1;
  end
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function set_position()
global  position_sensor node_count position_target target_count
for i=1:node_count
    position_sensor(i,1)=floor(300*rand(1,1));
    position_sensor(i,2)=floor(300*rand(1,1));
end

for i=1:target_count
    position_target(i,1)=floor(300*rand(1,1));
    position_target(i,2)=floor(300*rand(1,1));
end


end


function initial_first()
global node_count people pop_size
for i=1:pop_size
    people(i).live_node=zeros(1,node_count);
    people(i).live_node(:)=round(rand(1,node_count));
    people(i).fitness=fit(people(i));
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   genetic                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function crossover_all()
global   pop_size 
p=pop_size;
pop_=struct('live_node',{},'fitness',{},'cluster_node',{});
for i=1:floor(pop_size/2)
 pop1=1+round((pop_size-1)*rand(1,1));
 pop2=1+round((pop_size-1)*rand(1,1));
 crossover(pop1,pop2);
end
end

function crossover(p1,p2)
global   people node_count
pop_=struct('live_node',{},'fitness',{});
pop_(1).live_node=zeros(1,node_count);
mask=round(rand(1,node_count));
for i=1:node_count
      if(mask(i)==1)
            pop_(1).live_node(i)=people(p1).live_node(i);
        else
            pop_(1).live_node(i)=people(p2).live_node(i);
        end
end
 pop_(1).fitness=fit(pop_(1));
people(numel(people)+1)=pop_(1);
end

function mutation()
global people pop_size node_count
c1=fuzzy_();
c1=round(c1*pop_size);
for i=1:c1
    pop1=1+round((pop_size-1)*rand(1,1));
    r=1+round((node_count-1)*rand(1,1));
    c=round(rand(1,1));
    people(pop1).live_node(r)=c;
    people(pop1).fitness=fit(people(pop1));
end

end

function selection()
global  chanel_count people pop_size f h e user_count
for i=1:numel(people)
    for j=1:numel(people)-1
        if(people(j).fitness<people(j+1).fitness)
            p1=people(j);
            people(j)=people(j+1);
            people(j+1)=p1;
        end
    end
end
p1=people(1:pop_size);
people=p1;
end


function y=fuzzy_()
global  people pop_size
for i=1:numel(people)
    for j=1:numel(people)-1
        if(people(j).fitness<people(j+1).fitness)
            p1=people(j);
            people(j)=people(j+1);
            people(j+1)=p1;
        end
    end
end
s=0;
for i=2:pop_size
s=people(i).fitness+s;
end
D=(people(1).fitness)/s;
y1=0;
if(D<=0.25)
    y1=0.8;
end
if(0.25<D && D<=0.5)
    y1=0.6;
end
if(0.5<D & D<=0.75)
    y1=0.4;
end
if(0.75<D & D<=1)
    y1=0.2;
end
y=y1;
end





















