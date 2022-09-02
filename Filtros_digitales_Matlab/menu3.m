%desarrollo de clase
%% Practica 3. DISEÑO DE FILTROS DIGITALES IIR.

%En todos los apartados sobre diseño de filtros IIR, tenga en
%cuenta que MATLAB considera las frecuencias de corte de los 
%filtros normalizadas r
%especto a la mitad de la frecuencia de muestreo, fs/2.

% TIPO 1: Funciones para determinar el orden dadas ciertas
%expecificaciones. Estas funciones reciben como entrada los parametros de
%la mascara de tolerancia y devuelven el orden y la frecuencia de corte
%necesarios para las funciones que diseñan propiamente.

    % buttord
    % cheb1ord
    % cheb2ord
    % ellipord

% TIPO 2: Funciones para diseñar el filtro, reciben el orden y la
% frecuencia de corte devueltos por la funcion que determina el orden y el
% rizado en las bandas.
% - butter - cheby1 - cheby2 - ellip

% Considere las siguientes especificaciones:
%1) PasoBajo,
%2) fs = 2000 hz
%3) fmax bandapaso = 200 hz
%4) fmin bandaatenuada = 400 hz
%5) Amax bandapaso = 5 dB
%6) Amin bandaatenuada = 35 dB

% Determine el orden y diseñe el filtro para cada una de las cuatro aproximaciones mencionadas.
% Seguidamente conteste a las siguientes preguntas:
type = 'low';
f=2000;fp=200;fs=400;Rp=5;Rs=35;
Wp=2*fp/f;Ws=2*fs/f;
%Todos los filtros si por ejemplo lo hacemos con FIR, sale como en la
%figura 1, aunque si lo hacemos con butterworth vamos a ver que el maximo
%es la unidad,o sea cuando el rizado de banda de paso es costante, siempre
%esta entre delta +1 y delta -1 , el ancho de banda de transicion es aquel
%que me exige mas orden, relajamos el ancho de banda de transicion



%% Con Butterworth
%Nb = orden butterworth
%WnB = frecuencia del filtro
[Nb,WnB] = buttord(Wp,Ws,Rp,Rs);
[Bb,Ab] = butter(Nb,WnB,type);
[Hb,w] = freqz(Bb,Ab);
figure;
subplot(211),plot(w*f/(2*pi),20*log10(abs(Hb)));
title('filtro Butterworth');xlabel('Frecuencia (Hz)');ylabel('Magnitud (dB)');
subplot(212),plot(w*f/(2*pi),angle(Hb)*180/pi);
xlabel('Frecuencia (Hz)');ylabel('Fase (Grados)');
%{
%El filtro de Butterworth efectua la aproximacion mediante el criterio de
%maxima uniformidad en la banda pasante. Es decir tener una respuesta en
%frecuencia lo mas plana posible.

%Observamos en el primer plot como hasta los 200Hz obtenemos una respuesta
%plana por parte del filtro.
%cada familia de filtros tiene dos lllamadas, una que lemetemos los
%parametros y nos devuelve el orden y la frecuencia de corte(no nos interesa)

La salida de ls segundas funciones, devuelve los ceros y polos
Siempre la entrada en DECIBELIOS
%}
%% Con Cherisev Tipo I. (ondulacion de banda de paso)

[Nc1,Wnc1] = cheb1ord(Wp,Ws,Rp,Rs);
[Bc1,Ac1] = cheby1(Nc1,Rp,Wnc1,type);
[Hc1,w] = freqz(Bc1,Ac1);
figure;
subplot(211);plot(w*f/(2*pi),20*log10(abs(Hc1))); title('Cherisev I'); xlabel('Frecuencia Hz');ylabel('Magnitud dB');
subplot(212);plot(w*f/(2*pi),angle(Hc1)*180/pi);xlabel('Frecuencia Hz');ylabel('Fase grados');

%Observamos en este caso y como debe de ser en este tipo de filtro, se
%produce una caida más pronunciada que con el filtro Butterworth(en frecuencia).
%Este tipo de filtros tienen la propiedad de minimizar el error entre la
%caracteristica del filtro idealizada y la real, dentro del rango del
%filtro.

%% Chebyshev tipo II.

[Nc2,Wnc2]=cheb2ord(Wp,Ws,Rp,Rs);
[Bc2,Ac2]=cheby2(Nc2,Rs,Ws,type);
[Hc2,w]=freqz(Bc2,Ac2);
figure;
subplot(211),plot(w*f/(2*pi),20*log10(abs(Hc2)));title('Chebyshev II');xlabel('Frecuencia (Hz)');ylabel('Magnitud (dB)');
subplot(212),plot(w*f/(2*pi),angle(Hc2)*180/pi);xlabel('Frecuencia (Hz)');ylabel('Fase (Grados)');
% Estos filtros a diferencia de los Chebyshev I presentan ceros y polos, 
% su rizado es constante en la banda de rechazo y además presentan una caída 
% monotónica en la banda pasante.

%% Elíptico.

[Ne,Wne]= ellipord(Wp,Ws,Rp,Rs);
[Be,Ae] = ellip(Ne,Rp,Rs,Wne,type);
[Hc3,w]= freqz(Be,Ae);
figure;
subplot(211);plot(w*f/(2*pi),20*log10(abs(Hc3)));title('Elliptico');xlabel('Frecuencia Hz');ylabel('Magnitud (dB)');
subplot(212);plot(w*f/(2*pi),angle(Hc3)*180/pi);xlabel('Frecuencia (Hz)');ylabel('Fase (Grados)');

%filtro de cauer
% Están diseñados de manera que consiguen estrechar la zona de transición 
% entre bandas y, además, acotando el rizado en esas bandas. La diferencia 
% con el filtro de Chevyshev es que este sólo lo hace en una de las bandas.
% 
% Estos filtros suelen ser más eficientes debido a que al minimizar la zona 
% de transición, ante unas mismas restricciones consiguen un menor orden.
% 
% Por el contrario son los que presentan una fase menos lineal.

%% PREGUNTA NUMERO UNO. (filtro lowpass)
% Orden necesario para cada una de las aproximaciones. ¿Cual es el menor?, ¿y el mayor?

    % buttord -> 5
    % cheb1ord -> 4
    % cheb2ord -> 4
    % ellipord -> 3
% El filtro de mayor orden es el de Butterworth y el de menor es el
% elíptico. El orden de cada una de las aproximaciones podemos saberlo
% observando el "Workspace".

%% PREGUNTA NUMERO DOS. (filtro low pass)
% Represente el modulo de la respuesta en frecuencia en decibelios para los cuatro filtros
% disenados. Represente el eje de frecuencias en hercios analogicos. Ajuste el eje vertical
% entre 5 y -70 dB (axis). Verifique el cumplimiento de las especificaciones en los 4 casos.
% Dibuje el diagrama de polos y ceros en un plano z. Compruebe que son filtros estables.
% Butterworth
[Hb,wb] = freqz(Bb,Ab);
figure; subplot(221); plot(wb*f/(2*pi),20*log10(abs(Hb)));title('Butterworth');xlabel('Frecuencia (Hz)');ylabel('Magnitud (dB)');axis([0 1000 -70 5]);
% Chebyshev I
[Hc1,w]=freqz(Bc1,Ac1);
subplot(222),plot(w*f/(2*pi),20*log10(abs(Hc1)));title('Chebyshev I');xlabel('Frecuencia (Hz)');ylabel('Magnitud (dB)');axis([0 1000 -70 5]);
% Chebyshev II
[Hc2,w]=freqz(Bc2,Ac2);
subplot(223),plot(w*f/(2*pi),20*log10(abs(Hc2)));title('Chebyshev II');xlabel('Frecuencia (Hz)');ylabel('Magnitud (dB)');axis([0 1000 -70 5]);
% Elíptico
[He,w]=freqz(Be,Ae);
subplot(224),plot(w*f/(2*pi),20*log10(abs(He)));title('Elíptico');xlabel('Frecuencia (Hz)');ylabel('Magnitud (dB)');axis([0 1000 -70 5]);
%% PREGUNTA NUMERO TRES. (filtro low pass)

% El comportamiento en cada una de las bandas de paso y atenuada puede ser de dos tipos:
% 1. Monotono. ´
% 2. Rizado constante: oscilatorio con la amplitud de todas las oscilaciones iguales.
% Indique para cada uno de los tipos de aproximacion el tipo de comportamiento en la banda ´
% de paso y atenuada
%si es oscilatorio, el orden siempre es menor

% Butterworth
%parte de uno y va decreciendo siempre
 % Rizado en banda de paso: MONOTONO
 % Rizado en banda atenuada:MONOTONO
% Chevishev 1
 % Rizado en banda de paso: RIZADO CONSTANTE
 % Rizado en banda atenuada:MONOTONO
% Chevishev 2
 % Rizado en banda de paso: MONOTONO
 % Rizado en banda atenuada:RIZADO CONSTANTE
% Eliptico
 % Rizado en banda de paso: RIZADO CONSTANTE
 % Rizado en banda atenuada: RIZADO CONSTANTE
 
 
 
 

%% Diseño de filtro paso banda:
% El siguiente paso es disenar un filtro paso banda con cada una de las aproximaciones posi- ˜
% bles, considere las siguientes especificaciones:
type = 'bandpass';
f = 22050;%Frecuencia de muestreo
%clipa todo
% fp1 = 350; fp2 = 3350; %Frecuencias de las bandas de paso
% fs1 = 250; fs2 = 3450; %Frecuencias de la banda atenuada
% fs = [fs1 fs2];
% fp = [fp1 fp2];
%telefono
fp1 = 375; fp2 = 3325; %Frecuencias de las bandas de paso
fs1 = 225; fs2 = 3475; %Frecuencias de la banda atenuada
fs = [fs1 fs2];
fp = [fp1 fp2];

Rp = 1 ;%Atenuacion maxima en la banda de paso.
Rs = 50;%Atenuacion minima en al banda de atenuada.
Wp = 2*fp/f;
Ws = 2*fs/f;
%Butterworth
[Nb,WnB] = buttord (Wp,Ws,Rp,Rs);
[Bb,Ab] = butter (Nb,WnB,type);
[Hb,wb] = freqz(Bb,Ab);
%Chevishev 1
[Nc1,Wnc1] = cheb1ord (Wp,Ws,Rp,Rs);
[Bc1,Ac1] = cheby1 (Nc1,Rp,Wnc1,type);
[Hc1,wc1] = freqz(Bc1,Ac1);
%Chevishev 2
[Nc2,Wnc2] = cheb2ord (Wp,Ws,Rp,Rs);
[Bc2,Ac2] = cheby2 (Nc2,Rs,Ws,type);
[Hc2,wc2] = freqz(Bc2,Ac2);
%Eliptico
[Ne,Wne] = ellipord (Wp,Ws,Rp,Rs);
[Be,Ae] = ellip (Ne,Rp,Rs,Wne,type);
[He,we] = freqz(Be,Ae);
%todas las 'w' son iguales, de ahi que no diferenciamos al aplicar (buttord,chev1ord,chev2ord y ellipord)
figure;
subplot(221),plot(wc1*f/(2*pi),20*log10(abs(Hb))),title('Butterworth');xlabel('Frecuencia (Hz)');ylabel('Magnitud (dB)');xlim([0 11025])
subplot(222),plot(wc1*f/(2*pi),20*log10(abs(Hc1))),title('Chebysev I');xlabel('Frecuencia (Hz)');ylabel('Magnitud (dB)');xlim([0 11025])
subplot(223),plot(wc1*f/(2*pi),20*log10(abs(Hc2))),title('Chebysev II');xlabel('Frecuencia (Hz)');ylabel('Magnitud (dB)');xlim([0 11025])
subplot(224),plot(wc1*f/(2*pi),20*log10(abs(He))),title('Elíptico');xlabel('Frecuencia (Hz)');ylabel('Magnitud (dB)');xlim([0 11025])
%{
simulacion de llamada de telefono, comprobar siempre que es estable ,
SIEMPRE 
%}


%% Apartado 1 (bandpass)
figure;
subplot(221);zplane(Bb,Ab);title('Diagrama de polos y ceros filtro Butterworth');
subplot(222);zplane(Bc1,Ac1);title('Diagrama de polos y ceros filtro Chebysev I');
subplot(223);zplane(Bc2,Ac2);title('Diagrama de polos y ceros filtro Chebysev II');
subplot(224);zplane(Be,Ae);title('Diagrama de polos y ceros filtro Elíptico');
%Las cuatro aproximaciones son inestables.

%% Apartado 2 (bandpass)
% Compruebe el retardo de grupo para cada aproximacion.
%el retardo de grupo es algo que no controlamos, adelantamos y retrasamos
%muestras de tal manera que cuando tengamos el resultado, se puede escuchar
%la distorsion de fase

figure;
subplot(221);grpdelay(Bb,Ab);title('Retardo de grupo Butterworth');
subplot(222);grpdelay(Bc1,Ac1);title('Retardo de grupo Chevishev 1');
subplot(223);grpdelay(Bc2,Ac2);title('Retardo de grupo Chevishev 2');
subplot(224);grpdelay(Be,Ae);title('Retardo de grupo Eliptico');

%% Apartado 3 (bandpass)
% Filtre el fichero voz.wav con cada una de las cuatro aproximaciones. Compruebe si es
% audible la distorsion de fase.
[x,fs1] = audioread('voz.wav');
yb = filter(Bb,Ab,x);
yc1 = filter(Bc1,Ac1,x);
yc2 = filter(Bc2,Ac2,x);
ye = filter(Be,Ae,x);

%IMPORTANTE: Vector de tiempos (muestras temporales)
t = (0:length(x)-1)/fs1;

%Filtrado por las cuatro aproximaciones
figure;
subplot(221);plot(t,yb);xlabel('Tiempo (s)');ylabel('Magnitud');title('Audio filtrado aprox. butterworth');
subplot(222);plot(t,yc1);xlabel('Tiempo (s)');ylabel('Magnitud');title('Audio filtrado aprox. chevishev 1');
subplot(223);plot(t,yc2);xlabel('Tiempo (s)');ylabel('Magnitud');title('Audio filtrado aprox. chevishev 2');
subplot(224);plot(t,ye);xlabel('Tiempo (s)');ylabel('Magnitud');title('Audio filtrado aprox. eliptico');

audiowrite('vozbutter.wav',yb,fs1);%sordo
audiowrite('vozcheby1.wav',yc1,fs1);%sordo
audiowrite('vozcheby2.wav',yc2,fs1);%sordo
audiowrite('vozellip.wav',ye,fs1);%clipado
%{
solo tiene una respuesta parecida el elíptico, 
en el butter se vuelve inestable, chebishev 
tambien pero en el eliptico confunde ,
vemos las raices del eliptico, si que 
tenemos polos muy poco fuera del circulo
unidad, cuando tengo un polo fuera de unidad, 
la señal se vuelve inestable en algún momento, 
cambiamos las frecuencias de corte y un ancho
de badna de transcion mas grande , 
siguen siendo inestables , exceto el eliptico que 
parece estable aunque debe de comprobarse, elimina 
altas frecuencias , cuando hay vocales sordas, se lo
carga tambien 
fp1 = 375; fp2 = 3325; %Frecuencias de las bandas de paso
fs1 = 225; fs2 = 3475; %Frecuencias de la banda atenuada
fs = [fs1 fs2];
fp = [fp1 fp2];
%}
figure;
plot(t,x);hold on;plot(t,ye);title("comparacion");legend("original","señal eliptica");hold off;


%% Diseno de un ecualizador digital

%% Apartado 1

% Programe una funcion MATLAB ecualizador(B1,A1,B2,A2,B3,A3,G1,G2,G3,x)
% que reciba como entradas los par·metros de cada filtro, las ganancias de cada rama (en ¥
% dB) y la seÒal de entrada, y que devuelva la seÒal de salida y[n] (ve·se figura 2). Haga uso
% de la funcion MATLAB filter() para implementar los filtrados.

%% Apartado 2

% Determine el orden y diseÒe los tres filtros del ecualizador, H1(z), H2(z)y H3(z), con
% los siguientes requisitos:

% - El ecualizador se va a utilizar con senales analÛgicas muestreadas a 44.1 Khz. ¥
% - Las bandas de paso, atenuadas y de transicion son las mostradas en la figura 3, donde ¥
%   f1 = 3150 hz., f2 = 9450 hz., d1 = 400 hz. y d2 = 800 hz.
% - Atenuacion m·xima en bandas de paso: 1 dB. ¥
% - Atenuacion mÌnima en banda atenuada: 40 dB.
% - H1(z) debe ser paso bajo Chebyshev tipo II.
% - H2(z) debe ser paso banda Chebyshev tipo I.
% - H3(z) debe ser paso alto elÌptico.
%{
tenemos que ver como la señal de audio, la mayor parte de la energia esta
en baja frecuencia,la mayor parte de la energia de concentra por debajo de
3000, pero sigue habiendo informacion importante por encima pero es menor,
diseñar 3 filtros.
%}
f=44100;f1=3150;f2=9450;d1=400;d2=800;Rp=1;Rs=40;

% Paso bajo
Wp=2*f1/f;Ws=Wp+2*d1/f;
[Nc2,Wc2]=cheb2ord(Wp,Ws,Rp,Rs);
[Bc2,Ac2]=cheby2(Nc2,Rs,Wc2,'low');
[Hc2,w]=freqz(Bc2,Ac2);

% Paso banda
Wp=2*[f1 f2]/f;Ws=2*[f1-d1 f2+d2]/f;
[Nc1,Wc1]=cheb1ord(Wp,Ws,Rp,Rs);
[Bc1,Ac1]=cheby1(Nc1,Rp,Wc1,'bandpass');
[Hc1,w]=freqz(Bc1,Ac1);

% Paso alto
Wp=2*f2/f;Ws=2*(f2-d2)/f;
[Ne,We]=ellipord(Wp,Ws,Rp,Rs);
[Be,Ae]=ellip(Ne,Rp,Rs,We,'high');
[He,w]=freqz(Be,Ae);

% Orden paso bajo -> 12
% Orden paso banda -> 10
% Orden paso alto -> 6

%% Apartado 3

% Dibuje la respuesta en frecuencia de los tres filtros en una misma grafica.

figure;
plot(w*f/(2*pi),20*log10(abs(Hc2))),title('Filtro paso bajo');xlabel('Frecuencia (Hz)');ylabel('Magnitud (dB)');hold on
plot(w*f/(2*pi),20*log10(abs(Hc1))),title('Filtro paso banda');xlabel('Frecuencia (Hz)');ylabel('Magnitud (dB)');hold on
plot(w*f/(2*pi),20*log10(abs(He))),title('Filtro paso alto');xlabel('Frecuencia (Hz)');ylabel('Magnitud (dB)');legend('paso bajo','paso banda','paso alto');hold off

%% Apartado 4
% El fichero audio.wav contiene música muestrada a 44.1 khz. Vamos a pasar dicha señal
% por el ecualizador para comprobar la importancia de cada una de las bandas de frecuencias
% de la senal. Ejecute el programa ecualizador() tres veces para obtener las señales
% y1, y2 y y3, utilizando los filtros H1, H2 y H3 que acaba de disear y con los valores de
% ganancia que se indican en la siguiente tabla:

%   G1            G2           G3
% y1 0 dB       -40 dB      -40 dB
% y2 -40 dB     0 dB        -40 dB
% y3 -40 dB     -40 dB      0 dB

[x,fs] = audioread('audio.wav');
G1 = [0 -40 -40];
G2 = [-40 0 -40];
G3 = [-40 -40 0];
%Inicializamos la senal de salida a cero

y=zeros(length(x),3);
%La rellenamos
figure;
for i = 1:3
   y(:,i) = ecualizador(Bc2,Ac2,Bc1,Ac1,Be,Ae,G1(i),G2(i),G3(i),x);%ecualizamos 
   audiowrite(['audioy',num2str(i),'.wav'],y(:,i),fs); %generamos nuestro audio total
   plot(length(y(:,i)));title('ECUALIZADO');xlabel('');ylabel('');hold on
end
legend('y1','y2','y3');hold off;
%Nos devuelve audioy1,audioy2,audioy3.
%{
cae la sensacioon de sonoridad, el oido es mas sensible en cuanto a
percepcion, en alta freq, estamos quitando muchas frecuencias
%}



%% 4. Diseno de filtros digitales FIR 
%% Diseno de filtros FIR por el método de las ventanas

% MATLAB tiene dos funciones para disenar filtros por enventanado: 
% - fir1(): disena filtros de una sola banda, es decir, los filtros: paso bajo, paso alto, paso ˜
% banda y de banda eliminada.
% - fir2(): disena filtros FIR especificados por tramos o multibanda. ˜
% Nosotros utilizaremos fir1().


% Utilizando fir1(), disene los tres filtros siguientes todos ellos de frecuencia de corte 0.2:
% a) h1 de longitud 15 coeficientes y con ventana rectangular.
% b) h2 de longitud 15 coeficientes y con ventana hamming.
% c) h3 de longitud 31 coeficientes y con ventana rectangular.

N1 = 15; N2 = 15; N3 = 31; Wn = 0.2; type = 'low';
A = 1;
B1 = fir1(N1-1,Wn,type,ones(1,N1));
B2 = fir1(N2-1,Wn,type,hamming(N2));
B3 = fir1(N3-1,Wn,type,ones(1,N3));
%% Apartado 2.
% Dibuje las 3 respuestas impulsivas y compruebe su simetría
h1=impz(B1,A);
h2=impz(B2,A);
h3=impz(B3,A);

figure;
subplot(311);stem(0:length(h1)-1,h1);xlabel('Muestras (n)');ylabel('Valor');title('Respuesta al impulso de H1');
subplot(312);stem(0:length(h2)-1,h2);xlabel('Muestras (n)');ylabel('Valor');title('Respuesta al impulso de H2');
subplot(313);stem(0:length(h3)-1,h3);xlabel('Muestras (n)');ylabel('Valor');title('Respuesta al impulso de H3');
%Todas presentan simetria par.

%% Apartado 3.
% Dibuje el módulo en escala lineal de la respuesta en frecuencia de los filtros agrupando ´
% en una misma gráfica primero la respuesta en frecuencia de h1 y h2 y en otra de h1 y h3.

[H1,w1] = freqz(B1,A);
[H2,w2] = freqz(B2,A);
[H3,w3] = freqz(B3,A);
%w1 = w2.
%w1 = w3.
figure;
subplot(121);plot(w1/pi,abs([H1 H2]));xlabel('Frec digital');ylabel('Magnitud');title('Respuesta en frecuencia de H1(rectangular m15) y H2(hamming)');
subplot(122);plot(w1/pi,abs([H1 H3]));xlabel('Frec digital');ylabel('Magnitud');title('Respuesta en frecuencia de H1(rectangular m15) y H3(rectangular m30)');

%% Apartado 4.
% Responda a las siguientes cuestiones:

% - Para un mismo número de coeficientes del filtro, el ancho de banda de transición, ´
% ¿depende del tipo de ventana? (compare respuesta de h1 y h2).

%si, podemos ver como para el mismo numero de muestrtasa el ancho de banda
%de transicion del filtro con enventanado rectangular es menor que en
% el caso de enventanado con hamming, por lo que el ancho de banda si que
% depende del enventanado

% - El rizado en la banda de paso, ¿depende del tipo de ventana? (compare respuesta de
% h1 y h2).

%Si como se puede apreciar, en hamming, no existe rizado, bueno, si existe
%pero es tan pequeño que se hace inapreciable , en cambia en la rectangular
%le rizado es mas pronunciado,con lo cual depende del tipo de ventana.

% El ancho de banda de transicion, ¿depende de la longitud de la ventana? (compare ´
% respuesta de h1 y h3).

%Si, en el caso de que se haga mediante un enventanado como rectangular,
%es inversamente proporcional a la longitud de la ventana , para un mayor
%numero de muestras, el ancho de banda de transicion es menor

% - El rizado en la banda de paso, ¿depende de la longitud de la ventana? (compare
% respuesta de h1 y h3).

% El rizado no depende de la longitud de la ventana, pues es muy similar en ambos casos.

%% Apartado 5

% - Para un mismo tipo de ventana, indique que aspectos (rizado y anchura de banda de
% transición) mejoran, empeoran o se quedan igual por cambiar el número de coeficientes 
% del filtro. (comparar las respuestas de h1 y h3).

% Al aumentar el número de coeficientes se reduce el ancho de banda de
% transición, pero el rizado permanece igual.

%% Apartado 6

% -A la vista de las respuestas anteriores, indique que elegiría primero a la hora de diseñar,
% el tipo de ventana o el número de coeficientes del filtro.

% En primer lugar se establecería el número de coeficientes y
% posteriormente se elegiría la ventana que permitiese cumplir las
% especificaciones, ya que si eligiesemeos primero la ventana, podriamos
% obtener un número de coeficientes mayor, con lo cual, primero debemos de
% realizar las especificaciones de nuestro filtro y luego el filtro que 
% mas se adapte a nuestras necesidades.

%% Apartado 7.

% Diseñe un filtro paso banda entre 300 y 3400 Hz con un ancho de banda de transición de 
% 100 Hz y un rizado de 50 dB (frecuencia de muestreo de 22050 Hz). Determine la ventana
% y el orden requerido. Filtre el fichero voz.wav y compruebe si ha habido mejora frente
% a los filtros IIR, ya que ahora no hay distorsion de fase.
fp1=300;fp2=3400;%frecuencias de parada
If=100;%incremento de freq
fc = [fp1 fp2];%frecuencia central
A=50;fs=22050;%fs y A
type='bandpass';

% Al diseñar el filtro con enventanado el rizado en banda de paso es el
% mismo que en banda atenuada. Además este aspecto depende de la ventana.
% Observando una tabla con las distintas ventanas,estas caracteristicas se
% pueden satisfacer con ventanda de Hamming.


% Para la ventana de Hamming el ancho de banda de transición se
% puede calcular del siguiente modo: 3.84*f/2M. Por tanto M será:
M = ceil(6.6*fs/(2*If));

[x,fsv] = audioread('voz.wav');
Wc=2*pi*fc/fs;
Wc=Wc/pi;

Bh = fir1(M,Wc,type,hamming(M+1));
[H,w] = freqz(Bh,1);
figure;
plot(fs*w/(2*pi),20*log10(abs(H)));
xlabel('Frecuencia (Hz)'),ylabel('Magnitud (dB)');title('Filtro con ventana de Hamming');
y=filter(Bh,1,x);
audiowrite('vozFIR.wav',y,fsv);

%% Apartado 1

% Diseñe un filtro de 61 coeficientes utilizando firpm y las especificaciones:

% - Atenuada: de 0 a 300 hz.
% - Paso: de 300 a 3400 hz.
% - Atenuada: de 3400 a 11025 hz. 
% - Ancho de banda de transición: 100 hz.

% Calcule y represente el módulo de la respuesta en frecuencia en escala lineal. Comente las 
% desviaciones frente a la respuesta deseada que observa. ¿Son mayores en la banda de paso o en la atenuada?
N=60;
If=100;
fs=22050;
fp=[300 3400];
f=[0,2*(fp(1)-If)/fs,2*fp(1)/fs,2*fp(2)/fs,2*(fp(2)+If)/fs,1 ];
a=[0 0 1 1 0 0];
A=1;
B=firpm(N,f,a);
[H,w]=freqz(B,A);
figure
plot(w*fs/(2*pi),abs(H));xlabel('Frecuencia (Hz)');ylabel('Módulo');title('Filtro paso banda');
% Las desviaciones son similares en banda de paso y en banda atenuada.


%% Apartado 2

% Diseñe un filtro de 131 coeficientes utilizando firpm y las mismas especificaciones anteriores.
% Calcule y represente el módulo de la respuesta en frecuencia en escala lineal. Compare las 
% desviaciones frente a la respuesta deseada que observa con las vistas para 61 coeficientes.

N2=130;
B2=firpm(N2,f,a);
[H2,w]=freqz(B2,A);
figure
plot(w*fs/(2*pi),abs(H2));xlabel('Frecuencia (Hz)');ylabel('Módulo');title('Filtro paso banda');xlim([0 fs/2])

%% Apartado 3

% Diseñe un filtro de 131 coeficientes utilizando firpm y las mismas especificaciones anteriores, 
% pero considere que los errores en la banda atenuada deben ser 10 veces menores que en la de paso.
% Calcule y represente el módulo de la respuesta en frecuencia en escala lineal. Compare
% las desviaciones frente a la respuesta deseada que observa con las vistas en el punto 2.
% Indique cuales representan una mejora y cuáles un empeoramiento frente al mencionado 
% apartado 2.
r=10;
w=[1,1/r,1];

B3=firpm(N2,f,a,w);
[H3,w]=freqz(B3,A);
figure;
plot(w*fs/(2*pi),abs(H3));xlabel('Frecuencia (Hz)');ylabel('Módulo');title('Filtro paso banda');
% Para un mayor número de coeficientes las desviaciones son menores.
%% Apartado 4
% 4. Dise˜ne un filtro de 131 coeficientes, con las mismas especificaciones que los anteriores,
% pero considerando un ancho de banda de transici ´on de 300 hz.
% Calcule y represente el m ´odulo de la respuesta en frecuencia en escala lineal. Compare
% las desviaciones frente a la respuesta deseada que observa con las vistas en el punto 2.
% Indique qu´e aspectos mejoran y cu´ales empeoran.
%%                                                                                    
r=10;
w=[1,1/r,1];
N2=130;
If=300;
fs=22050;
fp=[300 3400];
f=[0,2*(fp(1)-If/2)/fs,2*(fp(1)+If/2)/fs,2*(fp(2)-If/2)/fs,2*(fp(2)+If/2)/fs,1 ];
a=[0 0 1 1 0 0];
B3=firpm(N2,f,a,w);
[H3,w]=freqz(B3,1);
figure;
plot(w*fs/(2*pi),abs(H3));xlabel('Frecuencia (Hz)');ylabel('Módulo');title('Filtro paso banda');

%% Apartado 5
% 5. Dise˜ne un filtro, con las especificaciones iniciales, considerando un rizado en banda de
% paso de 1 dB y un rizado en banda de atenuaci ´on de 50 dB. Determine el orden necesario.
% Compruebe que el filtro cumple las especificaciones. Compare el orden obtenido con los
% casos IIR y FIR con dise˜no mediante enventanado.
%{
al ser 50dB el mas restrictivo, haremos uso de un enventanado de hamming
%}

%%                                                                                          
If=100;
fs=22050;
fp=[300 3400];
f=[0,2*(fp(1)-If/2)/fs,2*(fp(1)+If/2)/fs,2*(fp(2)-If/2)/fs,2*(fp(2)+If/2)/fs 1];
a=[0 0 1 1 0 0];
A=1;
%{
N=floor(3.3*fs/If);
B=fir2(N,f,a,hamming(N+1));%no usar 
[H,w]=freqz(B,A);%[H,w]=freqz(B,A,orden);
figure;plot(w*fs/(2*pi),20*log10(abs(H)));xlabel('Frecuencia (Hz)');ylabel('Módulo');title('Filtro paso banda');
%}
% M = ceil(6.6*pi/((100)*2*pi/fs));
% B = fir1(M,[300 3400]/(fs/2),'bandpass',hamming(M+1));
% [H,F] = freqz(B,1,1024);
% figure;plot(F*fs/2/pi,20*log10(abs(H)));title(['fir hamming, orden:' num2str(M)]);
%    b = fir2(n,f,m)

%{
¿titulo?
%}
If=100;
Rp=1;
delta_p = (1-(10^(-Rp/20)));
delta_s=10^(-50/20);
fs=22050;
w=[1,delta_s/delta_p,1];%normalizado 
fp=[300 3400];
f=[0,2*(fp(1)-If/2)/fs,2*(fp(1)+If/2)/fs,2*(fp(2)-If/2)/fs,2*(fp(2)+If/2)/fs 1];
a=[0 0 1 1 0 0];
A=1;
Rp=1;
delta_p = (1-(10^(-Rp/20)));
delta_s=10^(-50/20);
M = ceil((-10*log10(delta_s*delta_p)-13)/(2.324*If*2*pi/fs));
B=firpm(M,f,a,w);
[H,F] = freqz(B,A,1024);
figure;plot(F*fs/2/pi,20*log10(abs(H)));title(['PARK, orden:' num2str(M)]);


%% 5. Conclusiones
% En esta practica se ha pretendido realizar un paseo por las principales 
% funciones disponibles en MATLAB para diseño de filtros digitales. Se han 
% revisado tanto los metodos de diseño de IIR como de FIR. Lo que se ha 
% pretendido es presentar las distintas funciones disponibles,
% sus parametros de diseño y la influencia de estos en el resultado final
% obtenido. No se ha experimentado con todas las funciones de diseño disponibles (ver designfilt()).

designfilt();


