clc;
clear all;
%% Sistema en variables de estado 
a=[-1 0;0 2]
b=[1;1]
c=[1,1]
d=0
polosdeseados=[-2+4.5826i,-2-4.5826i]
polosdeseadosaum=[polosdeseados,-20]
%% Diseño del seguidor continuo
aa=[a zeros(2,1);-c 0]
ba=[b;0]
kt=place(aa,ba,polosdeseadosaum)
kp=kt(:,1:2)
ki=kt(:,3:3)
%% Pasando a tiempo discreto
% [num,den]=ss2tf(a,b,c,d);
% sys=tf(num,den)

tm=0.1;
[adis,bdis,cdis,ddis]=c2dm(a,b,c,d,tm,'zoh')
% polossistcon=eig(a)
% polosistemadis=eig(adis)
% %% Comprobación de polos
% polo1=exp(-polossistcon(2)*tm)
% polo2=exp(-polossistcon(1)*tm)
%% Diseño el seguidor discreto
polo1disdes=exp(polosdeseados(1)*tm)
polo2disdes=exp(polosdeseados(2)*tm)
polosdiscredes=[polo1disdes,polo2disdes]
polosdiscredesaum=[polosdiscredes,exp(-20*tm)]
aadis=[adis,bdis;zeros(1,2),0]
badis=[zeros(2,1);1]
% aadis=[adis,zeros(2,1);-cdis,1]
% badis=[bdis;0]
ktdis=place(aadis,badis,polosdiscredesaum)
kpdis=ktdis(:,1:2)
kidis=ktdis(:,3:3)

%% Simulacion
ejemplodiscreto


