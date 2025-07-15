function referencePair=principal(canT,tasa,longi)
 figure(1)
 plot(canT) %grafica señal en el tiempo
 title('Dominio Temporal');xlabel('tiempo [s]');
 ylabel('señal'); grid on
%Transformacion y normalizacion
[canF,muestras]=separaFourier(canT,tasa,longi);

figure(2)
plot(canF)
title('FFT normalizada');
xlabel('Frecuencias');ylabel('señal');
%División para muestras por segundo
figure(3)

 
for i=1:longi %Grafica los intervalos de tiempo
plot(muestras(:,i)');
text='segundo: '+string(i);
title(text)
end

%identificacion de maximos
figure(4)
signa=maximos(longi,muestras); %Obtiene picos y su posición
title('Huella (t,f) de la señal')
hold on;

if length(signa)==0%si no se identifico algo (ruido
    %establece el par de referencia como cero
    referencePair=[0,0]; 
else
points=size(signa);
for i=1:longi %Crea gráfica de puntos máximos
    plot(i,signa(1:points(1),2*(i-1)+1),'xk','MarkerSize',7); 
end
xlabel("Tiempo [s]",'FontSize',13);ylabel("Frecuencia [Hz]",'FontSize',13);
counter=1;
for k=1:points(2)-1 %
    for i=2:points(1)-1
        front=[signa(i,k),signa(i,k+1)];
        up=[signa(i,k),signa(i+1,k+1)];
        ab=[signa(i,k),signa(i-1,k+1)];
        if front(1)*front(2)~=0
            referencePair(counter,1:2)=front;
            counter=counter+1;
        end
        if up(1)*up(2)~=0
            referencePair(counter,1:2)=up;
            counter=counter+1;
        end
        if ab(1)*ab(2)~=0
            referencePair(counter,1:2)=ab;
            counter=counter+1;
        end
    end
end
end
end

