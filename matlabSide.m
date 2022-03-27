 
clc; close all; clear all
format short
sFile = 'PruebaEnsayo.csv'; % NOMBRE ARCHIVO DE SALIDA , PARA CADA EXPERIMENTO DIFERENTE CAMBIAR EL NOMBRE PERO NO QUITAR TERMINACION CSV
maxTime = 1; % DURACIÓN DEL EXPERIMENTO EN MINUTOS

delete(instrfindall);    
s1 = serial('COM5');  % TALVEZ CAMBIE DE COMPUTADORA A COMPUTADORA. REVISAR PUERTO DEL ARDUINO EN devmgmt (administrador de dispositivos)   
s1.BaudRate = 9600;      
fopen(s1); 
mData = [];
while (1)  
    sSerialData = fscanf(s1);  
    t = strsplit(sSerialData,'\t');  
    if( size(t,2) == 6)  
        mData = [mData; str2double(t)];
        fprintf('%.1f [s] - %.3f [ºC] - %.3f [ºC] - %.3f [ºC] - %.3f [ºC] - %.3f [ºC]\n', mData(end,1), mData(end,2), mData(end,3), mData(end,4), mData(end,5), mData(end,6) ); %IMPRIME EN CONSOLA EL TIEMPO Y LA TEMPRATURA DE CADA TERMOCUPLA
    end
    if(mData(end,1) >= maxTime*60*1000)
        break % SE DETENDRÁ CUANDO EL TIEMPO MÁXIMO SE ALCANCE
    end
end    

delete(instrfindall);     
mData = mData(1:end-1,:);
csvwrite(sFile,mData);    

%%
% figure(2)
% plot((mData(:,1)/1000)/60,mData(:,2))
% xlabel('Time [min]', 'Interpreter','latex','fontsize',20);
% ylabel('Temperature [${}^{o}$C]', 'Interpreter','latex','fontsize',20);
% title('Cooling System Performance (@ max. power, on 700mL H20)', 'Interpreter','latex','fontsize',20);
% grid on
