close all, clear all

piedras = imread('piedras.jpg');

% segmentacion obtenida
load('maskRGBImageObtenida.mat');
load('BWObtenida.mat');
maskObtenida = 1 - BWObtenida;
figure, imshow(maskObtenida), title('Mascara obtenida');

nombre_base = 'segmentacion_';

for i=1:3
    nombre_archivo = [nombre_base, num2str(i), '.mat'];
    load(nombre_archivo);
    diferencia = abs(double(BW)-double(BWObtenida));
    error = sum(sum(diferencia));
    fprintf('Error %d: %d \n',i, error);
    titulo = sprintf('Iteración %d ', i);
    figure, imshow(BW), title([titulo, 'mascara propuesta']);

    figure, imshow(diferencia, []),title([titulo,'diferencia entre las imagenes']);
end




