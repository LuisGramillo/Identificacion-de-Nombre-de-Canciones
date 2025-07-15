function signa=maximos(longi,muestras)
anch=200;alt=100;
cols_sub=3;
for i=1:longi
    muesF=muestras(1:2500,i); %maneja por cada instante de tiempo
    %Encuentra picos y posición de este
    [maxi,frec]=findpeaks(muesF,'MinPeakDistance',anch,'MinPeakProminence',alt);
    signa(1:length(maxi),2*(i-1)+1:2*i)=[frec,maxi];
end
end
