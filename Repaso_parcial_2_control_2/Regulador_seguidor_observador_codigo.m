%% Regulador continuo
%SISTEMA EN VARIABLES DE ESTADO
A=[-1,0;0,2];
B=[1;1];
C=[1,1];
D=[0];
%CONTROLABILIDAD
co=ctrb(A,B);
rank(co); %rank=2=orden sist. --->controlable (condición necesaria)
%POLOS DESEADOS
Pd=roots([1,4,25])';            
%CÁLCULO DE LA MATRIZ DE GANANCIA K
k=place(A,B,Pd);

%% Seguidor continuo
%SISTEMA EN VARIABLES DE ESTADO
A=[-1,0;0,2];
B=[1;1];
C=[1,1];
D=[0];
%CONTROLABILIDAD
co=ctrb(A,B);
rank(co);
%POLOS DESEADOS
Pd=roots([1,4,25])'; 
%MATRICES AUMENTADAS
Aaum=[A,zeros(2,1);-C,0];
Baum=[B;0];
Pdaum=[Pd,-20];
%CÁLCULO DE LA MATRIZ DE GANANCIA kp y ki
K=place(Aaum,Baum,Pdaum);
Kp=K(1:1,1:2);
Ki=K(1:1,3:3);

%% Regulador en tiempo discreto
%SISTEMA EN VARIABLES DE ESTADO
A=[-1,0;0,2];
B=[1;1];
C=[1,1];
D=[0];
%CONTROLABILIDAD
co=ctrb(A,B);
rank(co); %rank=2=orden sist. --->controlable (condición necesaria)
%TIEMPO DE MUESTREO
tm=0.1; 
%ECUACIÓN DESEADA
num_ec_des_con=[25];
den_ec_des_con=[1 4 25];
ec_des_con=tf(num_ec_des_con,den_ec_des_con);
%DISCRETIZACIÓN
[A_dis,B_dis,C_dis,D_dis]=c2dm(A,B,C,D,tm,'zoh');
ec_des_dis=c2d(ec_des_con,tm,'zoh'); %ecuacion deseada discreto
Pol_des_dis=roots([1,-1.469,0.6703])'; %polos deseados discretos 
%CÁLCULO DE LA MATRIZ DE GANANCIA k
k_dis=place(A_dis,B_dis,Pol_des_dis);

%% seguidor en tiempo discreto
%SISTEMA EN VARIABLES DE ESTADO:
A=[-1,0;0,2];
B=[1;1];
C=[1,1];
D=[0];
%CONTROLABILIDAD
co=ctrb(A,B);
rank(co);
%TIEMPO DE MUESTREO
tm=0.1;
%ECUACIÓN DESEADA
num_ec_des_con=[25];
den_ec_des_con=[1 4 25];
ec_des_con=tf(num_ec_des_con,den_ec_des_con);
%DISCRETIZACIÓN
[A_dis,B_dis,C_dis,D_dis]=c2dm(A,B,C,D,tm,'zoh');
ec_des_dis=c2d(ec_des_con,tm,'zoh');
%POLOS DESEADOS DISCRETOS
Pol_des_dis=roots([1,-1.469,0.6703])';  
%MATRICES AUMENTADAS
A_dis_aum=[A_dis,B_dis;zeros(1,2),0];
B_dis_aum=[zeros(2,1);1];
Pol_des_aum=[Pol_des_dis,0.23];
%CÁLCULO DE LA MARIZ DE GANANCIAS Kp y Ki
K_dis=place(A_dis_aum,B_dis_aum,Pol_des_aum);
Kp=K_dis(1:1,1:2);
Ki=K_dis(1:1,3:3);

%% Observador de estados continuo
%SISTEMA EN VARIABLES DE ESTADO
A=[-1,0;0,2];
B=[1;1];
C=[1,1];
D=[0];
%CONTROLABILIDAD
ob=obsv(A,C);
rank(ob);
co=ctrb(A,B);
rank(co);
%ECUACIÓN DESEADA
num_ec_des=[25];
den_ec_des=[1 4 25];
ec_des=tf(num_ec_des,den_ec_des);
%POLOS DESEADOS
Pd=roots([den_ec_des])';
%MATRICES AUMENTADAS
A_aum=[A,zeros(2,1);-C,0];
B_aum=[B;0];
Pol_des_aum=[Pd,-20];
Po=[-10,-11];
%CÁLCULO DE h
h=place(A',C',Po)';
%CÁLCULO DE k
k=place(A_aum,B_aum,Pol_des_aum);
kp=k(1:1,1:2);
ki=k(1:1,3:3);

%% Observador de estados discreto
%SISTEMA EN VARIABLES DE ESTADO
A=[-1,0;0,2];
B=[1;1];
C=[1,1];
D=[0];
%CONTROLABILIDAD
co=ctrb(A,B);
rank(co);
%TIEMPO DE MUESTREO
tm=0.1;
%ECUACIÓN DESEADA
num_ec_des=[25];
den_ec_des=[1 4 25];
ec_des=tf(num_ec_des,den_ec_des);
%DISCRETIZACIÓN
[A_dis,B_dis,C_dis,D_dis]=c2dm(A,B,C,D,tm,'zoh');
ec_des_dis=c2d(ec_des,tm,'zoh');
Pol_des_dis=roots([1,-1.469,0.6703])';  
%MATRICES AUMENTADAS
A_aum=[A_dis,B_dis;zeros(1,2),0];
B_aum=[zeros(2,1);1];
Pol_des_aum=[Pol_des_dis,exp(-20*tm)];
Po=[exp(-10*tm),exp(-11*tm)];
%CÁLCULO DE h
h=place(A_dis',C_dis',Po)';
%CÁLCULO DE k
k=place(A_aum,B_aum,Pol_des_aum);
kp=k(1:1,1:2);
ki=k(1:1,3:3);

%% Observador de estados clásico continuo
%SISTEMA EN VARIABLES DE ESTADO
A=[-1,0;0,2];
B=[1;1];
C=[1,1];
D=[0];
%CONTROLABILIDAD
co=ctrb(A,B);
rank(co);
%ECUACIÓN DESEADA
num_ec_deseada=[25];
den_ec_deseada=[1 4 25];
ec_des=tf(num_ec_deseada,den_ec_deseada);
Pd=roots([den_ec_deseada])';
%MATRICES AUMENTADAS
aa=[A,zeros(2,1);-C,0];
ba=[B;0];
Pda=[Pd,-20];
Po=[-10,-11];
%CÁLCULO DE h
h=place(A',C',Po)';
%CÁLCULO DE k
k=place(aa,ba,Pda);
kp=k(:,1:2);
ki=k(:,3:3);
%FUNCIÓN DE TRANSFERENCIA Gy y Gu
[numy,deny]=ss2tf(A-h*C,h,kp,0);
Gy=tf(numy,deny);
[numu,denu]=ss2tf(A-h*C,B,kp,0);
Gu=tf(numu,denu);
%POLOS DE Gy y Gu
Pdy=roots([deny]);
Pdu=roots([denu]);

%% Observador de estados clásico discreto

%SISTEMA EN VARIABLES DE ESTADO
A=[-1,0;0,2];
B=[1;1];
C=[1,1];
D=[0];
%CONTROLABILIDAD
co=ctrb(A,B);
rank(co);
%TIEMPO DE MUESTREO
tm=0.1;
%ECUACIÓN DESEADA
num_ec_des=[25];
den_ec_des=[1 4 25];
ec_des=tf(num_ec_des,den_ec_des);
%DISCRETIZACIÓN
[A_dis,B_dis,C_dis,D_dis]=c2dm(A,B,C,D,tm,'zoh');
ec_des_dis=c2d(ec_des,tm,'zoh');
Pol_des_dis=roots([1,-1.469,0.6703])';  
%MATRICES AUMENTADAS
A_aum=[A_dis,B_dis;zeros(1,2),0];
B_aum=[zeros(2,1);1];
Pol_des_aum=[Pol_des_dis,exp(-20*tm)];
Po=[exp(-10*tm),exp(-11*tm)];
%CÁLCULO DE h
h=place(A',C',Po)';
%CÁLCULO DE k
k=place(A_aum,B_aum,Pol_des_aum);
kp=k(1:1,1:2);
ki=k(1:1,3:3);
%FUNCIÓN DE TRANSFERENCIA Gy y Gu
[numy,deny]=ss2tf(A-h*C,h,kp,0);
[numy_dis,deny_dis]=c2dm(numy,deny,tm,'zoh');
[numu,denu]=ss2tf(A-h*C,B,kp,0);
[numu_dis,denu_dis]=c2dm(numu,denu,tm,'zoh');

%POLOS DE Gy y Gu
Pdy=roots([deny]);
Pdu=roots([denu]);
%% Observador de estados discreto con regulador
%SISTEMA EN VARIABLES DE ESTADO
A=[-1,0;0,2];
B=[1;1];
C=[1,1];
D=[0];
%CONTROLABILIDAD
co=ctrb(A,B);
rank(co);
%TIEMPO DE MUESTREO
tm=0.1;
%ECUACIÓN DESEADA
num_ec_des=[25];
den_ec_des=[1 4 25];
%DISCRETIZACIÓN
[A_dis,B_dis,C_dis,D_dis]=c2dm(A,B,C,D,tm,'zoh');
den_ec_des_dis=c2dm(num_ec_des,den_ec_des,tm,'zoh');
Pol_des_dis=roots([den_ec_des_dis,0])';  
%POLOS DEL OBSERVADOR
Po=[exp(-10*tm),exp(-11*tm)];
%CÁLCULO DE h
h=place(A_dis',C_dis',Po)';
%CÁLCULO DE k
k=place(A_dis,B_dis,Pol_des_dis);



