function [canF,muestras]=separaFourier(canT,tasa,longi)
%Transformada rápida de Fourier.
canF=abs(fft(canT));

%Normalizacion
canF=canF(1:2500); %Reduce la muestra
canF=canF/max(canF); %Normaliza la muestra
muestras=zeros(2500,longi);
for i=1:longi %junta en matriz 'muestras'
    muestraT=canT(tasa*(i-1)+1:tasa*i);
    muesFn=abs(fft(muestraT));
    muesFn=muesFn(1:2500);
    muestras(1:2500,i)=muesFn;
end
end