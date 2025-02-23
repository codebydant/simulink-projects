%ENTRENAMIENTO DE LA RED CON LAS PRIMERAS 1400 MUESTRAS
close all
U=Entrada; %%Datos de entrada
Y=Salida; %%Datos de salida deseados
Phi=[Y(1:end-1),U(1:end-1)]';
YReal=[Y(2:end)]';

%%
Red=newff(Phi,YReal,[10],{'tansig','purelin','trainlm'});
Red.dividefcn='';
Red=train(Red,Phi,YReal);

gensim(Red,0.1);