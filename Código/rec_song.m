clc, clear, close all
longi=10; %tiempo de grabación
tasa=44100;bits=16;chan=1; %Parámetros de grabación
Songm=audiorecorder(tasa,bits,chan);
%obtencion de audio
disp('Start speaking.') %mensaje al usuario
recordblocking(Songm,longi) %Graba por 'longi' segundos
disp('End of Recording.'); %mensaje al usuario
canT=getaudiodata(Songm)'; %transforma objeto de audio a señal
referencia=principal(canT,tasa,longi); %hace la conversion
%obtiene par de referencia de grabacion
 
%Informacion para comparacion
direc='C:\Users\luisg\Google Drive\MATLAB\FISMAT\PROYECTO\canciones';
% Directorio de canciones (Modifica el usuario):
%direc=input('Deposite la dirección donde se ubica las canciones:\n','s');
sonams=dir([direc,'\*.mp3' ]); %identifica todo archivo .mp3
nombres=struct2table(sonams); %transforma estructura en tabla
canciones=[]; 

for i=1:height(nombres) %extrae cada valor de la tabla tabla->character
canciones=[canciones,string(table2array(nombres(i,1)))];
end
 [x,y]=compara(length(canciones),canciones,referencia); %Compara con base
 %x=valor de coincidencia, y=numero de cancion
 fprintf('Canción: ')
 fprintf([audioinfo(canciones(y)).Title,'\n']) %imprime titulo
 fprintf('Artista: ')
 fprintf([audioinfo(canciones(y)).Artist,'\n']) %imprime artista