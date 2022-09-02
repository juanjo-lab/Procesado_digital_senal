% Diseno de filtros FIR en MATLAB

% Metodo DFT

wp=0.19*pi;
ws=0.21*pi;
dp=0.01;
ds=0;
Aw=ws-wp; % Ancho de banda de transicion

% Numero de muestras para 44 dB con ventana de Hanning
M=310; % Muestra maxima en el tiempo desde n=0
%M=round(6.6*pi/Aw);
%M = ceil(M/2)*2;

N=M+1; % Num de muestras totales mas la de n=0

n=0:M; % Vector de tiempos
wk=2*pi*n/N; % Pulsacion digital muestreada
fk=2*n/N; % Muestreo en frecuencia normalizada pi=1;

alfa=M/2; % punto de simetria 

ip=find(fk(1:alfa+1)<(wp/pi)); % indices de la banda de paso
it=find((fk(1:alfa+1)>=(wp/pi)) & (fk(1:alfa+1)<=(ws/pi))); % indices de la banda de transicion
is=max(it)+1:alfa+1; % indices de la banda de atenuacion

H=zeros(1,alfa+1);
H(ip)=1+(dp*((-1).^ip)); % rizado de la banda de paso
H(it)=0.5; % banda de transicion
H(is)=(ds*((-1).^is)); % rizado de la banda de atenuacion

H=H.*exp(-j*wk(1:alfa+1)*alfa); % fase lineal
H=[H conj(H(alfa+1:-1:2))]; % frecuencias negativas o de pi a 2pi

hn=ifft(H); % obtencion de la respuesta al impulso

figure;stem(fk,abs(H));axis([0 2 -.1 1.1]);title('Muestreo forzado en frecuencia');
figure;freqz(hn);title('Respuesta en frecuencia conseguida con el diseno basado en DFT');
figure;zplane(hn,1);title('Ceros de la transformada z');
figure;stem(0:M,hn);title('Respuesta al impulso');


