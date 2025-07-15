%Para solicitar directorio:
%direc=input('Deposite la dirección donde se ubica las canciones:\n','s');

direc='C:\Users\luisg\Google Drive\MATLAB\FISMAT\PROYECTO\canciones';
sonams=dir([direc,'\*.mp3' ]); %obtiene las canciones
nombres=struct2table(sonams); %transforma a tabla
canciones=[];%extrae cada valor de la tabla tabla->character
for i=1:height(nombres)
canciones=[canciones,string(table2array(nombres(i,1)))];
end


%Crea referencepair de cada cancion

for u=1:length(canciones) %irá por cada cancion encontrada
    temporal=char(canciones(u)); %nombre de la cancion
    temporal=['REFERENCE_',temporal(1:end-4),'.mat'];%formato de referencia
    if exist(temporal)~=2 %si ya existe (=2) ignora, ya no es necesario
    [song,tasa]=audioread([direc,'\',char(canciones(u))]); %lee cancion
    song=song(:,1)'; %selecciona un solo canal
    longis=fix(songinf.Duration);%redondea la duración a enteros


    %Divide en partes de 10s
    residuo=mod(223,10);
    entero=fix(223/10);
    Datos=zeros(1,2); %se almacenará identificador
    
    for j=1:entero %por cada 10 segundos de la cancion 'u'
    canT=song((10*(i-1)*tasa+1):(10*i*tasa)); %toma 44100*10 muestras 
    longi=10;
    %Transformacion y normalizacion
    [canF,muestras]=separaFourier(canT,tasa,longi);

    %SIMILAR principal.m | Elimina plots 
    signa=maximos(longi,muestras);
    
    points=size(signa);
    counter=1;
    for k=1:points(2)-1
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
    Datos=[Datos;referencePair]; %acumula los identificadore de cada 10s
    end %finaliza la cancion 'u'
    Datos(1,:)=[]; %elimina primer vector hecho ([0,0])
    nombre=sprintf(['REFERENCE_',char(canciones(u))]); %crea nombre
    nombre=[nombre(1:end-4),'.mat']; %el nombre lo cambia de .mp3 a .mat
    save(nombre,'Datos') %guarda el identificador
    else
        %si ya existia, no debe hacer nada
    end
end %finaliza las canciones

