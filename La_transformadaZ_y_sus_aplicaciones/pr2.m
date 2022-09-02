%PRACTICA 2
%FUNCIONES DE TRANSFERENCIA
%%                          EJERCICIO_2
%%                                                           apartado 2.1.1
%cargamos los archivos
load ap2mat.mat
figure;zplane(B1,A1);title('H1');
figure;zplane(B2,A2);title('H2');
figure;zplane(B3,A3);title('H3');
figure;zplane(B4,A4);title('H4');
%{
H1 y H3 vemos que contienen los mimos polos y mimos ceros en las mismas
ubicaciones y analogamente nos encontramos esta situacion en H2 Y H4
%}

%%                                                           apartado 2.1.2
%representamos en freq
%% H1
figure;freqz(B1,A1);title('representacion en frecuencia H1');
%% H2
figure;freqz(B2,A2);title('representacion en frecuencia H2');
%% H3
figure;freqz(B3,A3);title('representacion en frecuencia H3');
%% H4
figure;freqz(B4,A4);title('representacion en frecuencia H4');

grpdelay(B1,A1);
%%                                                           apartado 2.1.3
%{
Como observamos, a medida que nos acercamos a nuestro polo, la ganancia
aumenta creando una especie de pico y el sistema es valido ya que su modulo
es menor al de unidad siendo el mismo 0.85, como vemos los polos contenidos
en H1 se encuentran a una distancia mayor que los polos concentrados en H3
, en el caso de ver que pasa con la fase, tenemos que observar que esta
ocurriendo con nuestro retardo de grupo,
%}

%%                                                           apartado 2.1.4
%%  H1
x=zeros(1,31);
x(1)=1;
stem(x);
y_1=filter(B1,A1,x);
figure;stem(y_1);

%% H2
x=zeros(1,31);
x(1)=1;
stem(x);
y_2=filter(B2,A2,x);
figure;stem(y_2);

%% H3
x=zeros(1,31);
x(1)=1;
stem(x);
y_3=filter(B3,A3,x);
figure;stem(y_3);

%% H4
x=zeros(1,31);
x(1)=1;
stem(x);
y_4=filter(B4,A4,x);
figure;stem(y_4);
%{
definimos primero nuestro vector con 0 y el primer valor 1 , es como el
filtro
%}
%%                                                           apartado 2.1.5
%% H1
figure;impz(y_1);
%% H2
figure;impz(y_2);
%% H3
figure;impz(y_3);
%% H4
figure;impz(y_4);


%%                                                          apartado 2.1.6
%{
veamos los dos modulos de cada uno:
A1_pk=roots(A1);
A1_abs=abs(roots(A1));
A3_pk=roots(A3);
A3_abs=abs(roots(A3));
Como vemos el modulo de los polos de A1 es 0.85 y de A3 es 0.95 entonces
A3=[1-0.95*exp(j*pi/4)] 
A1=[1-0.85*exp(j*pi/4)] 
Decrece mas rapido A1, aqui influye la atenuacion de la señal, A3, tiene un modulo mayor, haciendo que retrase mas su
atenuacion, como vemos tambien nuestra representacion en frecuencia, su
"pico" es mas pronunciado, a medida que nos acercamos a la circunferencia
unidad, dicho "pico" tiende a una ganancia infinito, mejor, genera una
respuesta en frecuencia mayor, atenuando mas lentamente la señal y cuando
nos encontremos fuera de nuestra circunferencia unidad, (modulo>1) nuestra
respuesta en frecuencia es infinito.
%}
%si el modulo es mas grande, la exponencial es mas larga
%%                               EJERCICIO_3  
%%                                                          apartado 3.1.1
load retgrupomat.mat;
[E,f]=espectro(s);
figure;stem(s);
plot(s);
%pulso de freq entre 100 y 200 baja y mas alta de 200 a 300 y media de 0  a 100
%estamos modulando 
figure;freqz(B,A);%3 pulsos en frecuencia 
%en amplitud da ganancia de 10 Db y atenua en 0.7pi, es un filtro paso
%bajos para ver lo que hace la fase, tenemos que dibujar el retardo de
%grupo
figure;grpdelay(B,A);
%la frecuencia 0.4 la retarda a 0.7, hay distintos retardos en funcion de
%la frecuencia del pulso
%la frecuencia 0.2 la retarda 30 muestras
figure;freqz(s,1)
%transformada de la place, tenemos 3 impulsos en 0.2 0.4 0.75, matlab usa
%frecuencia normalizada que es w/pi
y=filter(B,A,s);
figure;plot(s);
figure;plot(y);
%{
%transformada de la place, tenemos 3 impulsos en 0.2 0.4 0.75, matlab usa
frecuencia normalizada que es w/pi

%retrasa y atenua el pulso , el retraso es la distorsion de fase
tenemos que ver el retardod e grupo

%vemos que 0.2 tiene un retardo de 30 muestras y el de 0.4 tiene solo 3.8
muestras y el otro 30 por eso se han separado 
filtros con polos, todos distorsion de fase, en señales digitales si
generan problemas con la voz no 
%}
%primero calcula la señal de entrada 

%%                                                          apartado 3.2.1
load transitmat.mat
figure;plot(x)%entra un tono y se apaga
%vemos que tiene polos y es un filtro estable que da ganancia a frecuencias
%bajas, si vemos la tf de fourier tenemos dicha ganancia
%filtros con ceros, es lineal
figure;zplane(B,A);
figure;freqz(B,A);
y=filter(B,A,x);
figure;plot(y)
figure;impz(y);
%transitorio inicial, de 15 y luego el regimen permanente sinusoidal y
%luego se vuelve estable

%%                                                      apartado 4.1.1
%Fase lineal
load ap4mat.mat;
%%Sistema1
figure;zplane(B1,A1);
%%sistema2
figure;zplane(B2,A2);
%%sistema3
figure;zplane(B3,A3);
%%sistema1
figure;freqz(B1,A1);
%%sistema2
figure;freqz(B2,A2);
%%sistema3
figure;freqz(B3,A3);%es el sistema lineal

figure;grpdelay(B3,A3);%tiene un retardo contante de 1 muestra
%un filtro simetrico no genera distorsion de fase, cuando hay polos ya no
%hay linealidad
%%                                                      apartado 4.2.1
%sistema 6
figure;zplane(B6,A6);%estable
%sistema 7
figure;zplane(B7,A7);%no estable
%sistema 6

%%                                                      apartado 4.2.2
%sistema 6
x=zeros(1,31);
x(1)=1;
figure;stem(x);
y_6=filter(B6,A6,x);
figure;stem(y_6);

%sistema 7
x=zeros(1,31);
x(1)=1;
figure;stem(x);
y_7=filter(B7,A7,x);
figure;stem(y_7);
%{
el sistema 7 es un sistema no estable con los polos fuera de la
circunferencia unidad, con lo cual tiende a infinito, en el tiempo se
encuentra con una exp creciente
%}

%%                                                     apartado 4.3.1
figure;freqz(B8,A8);
figure;grpdelay(B8,A8);
figure;zplane(B8,A8);

%{
comprobar que el modulo es 1 y es una constante y todas las frecuencias se
atenuan lo mismo
%}
%%                                                      apartado 4.3.2

x=zeros(1,31);
x(1)=1;
stem(x);
y_1=filter(B8,A8,x);
figure;stem(y_1);

s=B8/A8;
[E,f]=espectro(s);%sale una constante
%{
Si, porque su modulo en frecuencia es una constante
%}
%%                                                     apartado 4.3.3
%{
para afinar el instrumento a cualquier frecuencia deseada y en frecuencia
deberia de tener una respuesta constante de 1
es un filtro que queremos que atenue una determinada frecuencia, se hace
poniendo un 0, la que queremos cargarnos, tenemos que jugar con polos y
ceros juntos 
%}
%%              FILTRO NOTCH
f0=1/8;
w0=2*pi*f0;
cero =exp(j*w0);
polo=0.9999*exp(j*w0);
figure;zplane(cero);
[B,A]=zp2tf([cero;conj(cero)],[polo;conj(polo)],1);
[H,W]=freqz(B,A);
figure;zplane(B,A);
figure;plot(H,abs(W));
figure;freqz(B,A);