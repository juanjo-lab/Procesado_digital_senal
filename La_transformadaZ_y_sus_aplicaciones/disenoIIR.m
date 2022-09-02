% Diseno de filtros IIR ejemplos

% El filtro paso bajo a disenar tiene una frecuencias y rizados lineales

wp=0.19*pi; % Frecuencia maxima de la banda de paso
ws=0.21*pi; % Frecuencia minima de la banda de atenuacion (stop)
dp=0.1; % rizado (delta de la banda de paso)
ds=0.01; % rizado (delta de la banda de atenuacion)

% Los valores de frecuenciass en Matlab estan normalizados 1 es frecuencia pi
Wp=wp/pi;
Ws=ws/pi;

% Los valores de rizado se pasan a decibelios
Rp=-20*log10(1-dp);
Rs=-20*log10(ds); % - para que salga dB positivos

filtro=menu('Metodo de diseno del filtro IIR','Butterworth','Chebyshev I','Chebyshev II','Eliptico');

switch filtro
    case 1,
        % Diseno del filtro Butterworh (sale inestable)
        [N,Wn]=buttord(Wp,Ws,Rp,Rs); % orden y frecuencia de corte
        [B,A]=butter(N,Wn);

        figure;zplane(B,A);title('Polos con modulo mayor que 1 entonces filtro inestable');
        figure;impz(B,A);title('Respuesta al impulso inestable');
        figure;freqz(B,A);title('La region no definida de la respuesta en frecuencia indica inestabilidad');
        figure;grpdelay(B,A);title('Retardo de grupo');

        [N,Wn]=buttord(0.15,0.25,Rp,Rs); % orden y frecuencia de corte
        [B,A]=butter(N,Wn);

        figure;zplane(B,A);title('Plano z estable');
        figure;impz(B,A);title('Respuesta al impulso estable');
        figure;freqz(B,A);title('Se ha relajado la banda de paso de la respuesta en frecuencia');
        figure;grpdelay(B,A);title('Retardo de grupo similar para todas las frecuencias de la banda de paso');

    case 2,
        % Diseno del filtro Chebishev I
        [N,Wn]=cheb1ord(Wp,Ws,Rp,Rs); % orden y frecuencia de corte
        [B,A]=cheby1(N,Rp,Wn);

        figure;zplane(B,A);title('Plano z estable, orden medio, polos cerca del circulo unidad');
        figure;impz(B,A);title('Respuesta al impulso estable');
        figure;freqz(B,A);title('Respuesta en frecuencia. Rizado constante en banda de paso');
        figure;grpdelay(B,A);title('Retardo de grupo muy variable en la banda de paso');

    case 3,
        % Diseno del filtro Chebishev II
        [N,Wn]=cheb2ord(Wp,Ws,Rp,Rs); % orden y frecuencia de corte
        [B,A]=cheby2(N,Rs,Wn);

        figure;zplane(B,A);title('Plano z estable, orden medio, polos cerca del circulo unidad');
        figure;impz(B,A);title('Respuesta al impulso estable');
        figure;freqz(B,A);title('Respuesta en frecuencia. Rizado constante en banda de atenuacion');
        figure;grpdelay(B,A);title('Retardo de grupo muy variable en la banda de paso');

    case 4,
        % Diseno del filtro Eliptico
        [N,Wn]=ellipord(Wp,Ws,Rp,Rs); % orden y frecuencia de corte
        [B,A]=ellip(N,Rp,Rs,Wn);

        figure;zplane(B,A);title('Plano z estable, orden bajo, polos cerca del circulo unidad');
        figure;impz(B,A);title('Respuesta al impulso estable');
        figure;freqz(B,A);title('Respuesta en frecuencia. Rizado constante en todas las bandas');
        figure;grpdelay(B,A);title('Retardo de grupo muy variable en la banda de paso');

end;
