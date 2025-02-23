%%
close all
U=Entrada;
Y=Salida;
W=Entrada;
Phi=[Y(2:end-1),Y(1:end-2),U(2:end-1),U(1:end-2),W(:1)]';
YReal=[Y(3:end)]';
%%
Red=newff(Phi,YReal,[9],{'tansig','purelin','trainlm'});
Red.dividefcn='';
Red.trainparam.epochs=250;
Red=train(Red,Phi,YReal);

gensim(Red,0.1);