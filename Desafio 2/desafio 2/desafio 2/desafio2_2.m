close all, clear all

piedras = imread('piedras.jpg');

load('segmentacion_2.mat');

% segmentacion obtenida
load('maskRGBImageObtenida.mat');
load('BWObtenida.mat');

maskObtenida = 1 - BWObtenida;

diferencia = abs(double(BW)-double(BWObtenida));
error2 = sum(sum(diferencia));
fprintf('Error2: %d \n',error2);

imshow(diferencia, []);
title('Diferencia entre las imagenes')


figure, imshow(maskObtenida), title('Mascara obtenida');
figure, imshow(BW), title('Mascara propuesta 2');
