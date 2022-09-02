function [E ,f]=espectro(x)
%[E f]=espectro(x)
% Calcula el espectro (TF) de una señal
% Devuelve la TF y un vector de frecuencias.
%
%Para representar el resultado hacer 'plot(f,E)'

Lfft=2048;
E=abs(fft(x,Lfft));
f=(1:2048)-1;
f=f/2048;
L2=Lfft/2+1;
f=f(1:L2);
E=E(1:L2);
figure;plot(f,E);