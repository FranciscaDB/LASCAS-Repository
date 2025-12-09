% Cargar el archivo .mat
load('dato6u5.mat');

x = data;

% Escribir los datos en un archivo CSV
csvwrite('Gold_Ref_PLECs.csv', x);