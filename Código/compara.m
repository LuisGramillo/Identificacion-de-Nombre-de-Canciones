function [Mea,song_fit]=compara(n,canciones,referencia)

comparations=zeros(n,1); %crea vector de comparaciones
for i=1:n
    nombre=sprintf(['REFERENCE_',char(canciones(i))]);
    nombre=[nombre(1:end-4),'.mat'];
    load(nombre)
    comparations(i) =mean(mean(ismembertol(Datos,referencia,10^-4)));
    %primer mean() reduce los vectores a dos valores
    %segundo mean() reduce los dos valores a uno
end
[Mea,song_fit]=max(comparations); %obtiene cancion mas parecida
end
