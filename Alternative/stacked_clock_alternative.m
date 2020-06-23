%stacked_clock_alternative.m
clc;
clear all;
close all;

%% Parameters
%d,h,m,s
% r=[17,7,9,13,5]; %steps
% l=1;    %length
% faktor=1/3;
% depth=5;
r=[12,6,10,6,10]; %Definition of time keeping system (how many hours, how many minutes per hour, how many seconds per minute...)
l=1;    %length
faktor=1/3; %How the length decreases for the fingers
depth=5;
step_width=5;


%% Script
%how often until a cycle repeats
 i=depth:-1:1;
 li=l*faktor.^(depth-i);  %length
 %li(1)=sum(li(2:end));
% stepsi=r.^i;

% s2=1;
% for m=2:depth   %everything always lines up :D
%     sn=1+stepsi(m)./stepsi(2)*1/r(1);
%     for j=3:m
%         sn=sn+stepsi(m)./stepsi(j)*1/r;
%     end
%     s2=[s2 sn];
% end

steps=r(end);
for i=2:length(r)
    steps=[r(length(r)-i+1)*steps(1) steps];
end

s2=1;
for i=2:length(r)   %everything always lines up :D
    sn=1+steps(i)./steps(2)*1/r(1);
    for j=3:i
        sn=sn+steps(i)./steps(j)*1/r(j-1);
    end
    s2=[s2 sn];
end

figure('Position', [10 10 900 900])

x=zeros(steps(1)+1,1);
y=zeros(steps(1)+1,1);
y(1)=sum(li);
for i=1:steps(1)*step_width   %all the seconds 
    angles=s2.*i./steps/step_width*2*pi;
    
    y0=li.*cos(angles);
    x0=li.*sin(angles);
    
    x(i+1)=sum(x0);
    y(i+1)=sum(y0);

end

plot(x,y,'Color', 0.75*[1 1 1])
axis equal
drawnow

set(gca,'Visible','off');
hold on;

i=round(rand(1)*steps(1));
while 1==1
    i=mod(i,steps(1));
    angles=s2.*i./steps*2*pi;
    
    y0=li.*cos(angles);
    x0=li.*sin(angles);
    
    for j=1:length(r)
        x1(j)=sum(x0(1:j));
        y1(j)=sum(y0(1:j));
    end
    
    if exist('a')
        delete(a);
    end
    
    a=plot([0 x1],[0 y1],'Color', 0.25*[1 1 1],'Linewidth',1.5);
    
    drawnow();
    i=i+1;
end
