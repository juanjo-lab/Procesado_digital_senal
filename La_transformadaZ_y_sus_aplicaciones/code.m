%{
apunte de clase:
roots, encontrar raices de un polinomio
unwrap, es para ver la fase de un sistema
grpdelay, retardo de grupo
freq, dibuja polos y ceros 
impz, 
B=[1,z^-1,z^-2...]

 B=1;
A=[1-0.9*exp(j*pi/4)] nuestra funcion de transferencia B/A
dibujamos el plazo z

si te acercas al polo la tranformada de fourier crece y se acerca a medida
que nos acercamos al polo en frecuencia, ese pico es la ganancia , cuanto
mas cerca del polo mas ganancia 

hace un efecto sumidero en los ceros y efecto montaña con los polos

si es un filtro con polo, tenemos que comprobarlo, comprobarlo en la
circunferencia unidad o mirando las raices del sistema en valor absoluto,
si es mayor que 1 el sistema no vale 

EXPLICACION DE LA PRACTICA
cargamos con load
larespuesta al impulso a mano o con impz

el tiempo del valor del modulo es mas grande y dura mas, comparar filtro 1
cn el 3 en el apartado 6

filtrado de señal 

%}
load ap2mat.mat
figure;zplane(B1,A1);
pk=roots(A1);
abs(roots(A1));
angle(A1);

%respuesta en freq
x=zeros(31,1);
x(1)=1;
stem(x);
y=filter(B1,A1,x);
stem(y);
figure;impz(y);

%filtrado de señal pnto 3
load retgrupomat.mat;
stem(s);
plot(s);
%pulso de freq en tre 100 y 200 y mas alta de 200 a 300 y media de 0  a 100
%estamos modulando 
freqz(B,A);
%en ampñitud da ganancia de 10 Db y atenua en 0.7pi, es un filtro paso
%bajos para ver lo que hace la fase, tenemos que dibujar el retardo de
%grupo
figure;grpdelay(B,A);
%la frecuencia 0.4 la retarda a 0.7, hay distintos retardos en funcion de
%la frecuencia del pulso
figure;freqz(s,1)
%transformada de la place, tenemos 3 impulsos en 0.2 0.4 0.75, matlab usa
%frecuencia normalizada que es w/pi
y=filter(B,A,s);
figure;plot(s);
figure;plot(y);%retrasa y atenua el pulso , el retraso es la distorsion de fase
%tenemos que ver el retardod e grupo
figure;grpdelay(B,A)

%vemos que 0.2 tiene un retardo de 30 muestras y el de 0.4 tiene solo 3.8
%muestras y el otro 30 por eso se han separado 
%filtros con polos, todos distorsion de fase, en señales digitales si
%generan problemas con la voz no 

%%transitorios infiltrados
load transitmat.mat
plot(x)%entra un tono y se apaga
%vemos que tiene polos y es un filtro estable que da ganancia a frecuencias
%bajas, si vemos la tf de fourier tenemos dicha ganancoa
%filtros con ceros, es lineal
zplane(B,A)
freqz(B,A)
y=filter(B,A,x)
plot(y)
impz(y);

%veo que siempre hay un transitorio, la respuesta al impulso del filtro,
%matematicamente ocurre porque la señal de entrada tiene unos polos y el
%filtro otros y el filtro tiene que responder y si el polo esta mas cerca
%de ciruclo unidad, se tiene la respuesta, si esta mas lejos , mas lejos
%aparece la prueba transitoria, filtro simetrico no genera 


%filtro notch , quiero que atenue una determinada frecuencia, el diseño es
%jugar un polo y ceros, pongo un cero amp uno en freq a eliminar y un polo dcerca del cero
%y se tiene que jugar con el conjugado para que sea real el filtro