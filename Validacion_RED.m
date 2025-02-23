%%
%VALIDACIÓN DE LA RED CON 450 MUESTRAS RESTANTES
UVal=Entrada(1050:end);
YVal=Salida(1050:end);
PhiVal=[YVal(1:end-1),UVal(1:end-1)]';
YRealVal=[YVal(2:end)]';

%%
%SIMULACIÓN DE 1 PASO 
YRed=sim(Red,PhiVal);
TiempoVal=0:0.1:44.8;
plot(TiempoVal,YRealVal,TiempoVal,YRed);