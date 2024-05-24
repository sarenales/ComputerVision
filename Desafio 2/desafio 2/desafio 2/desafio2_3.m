close all, clear all

piedras = imread('piedras.jpg');

load('segmentacion_3.mat');

% segmentacion obtenida
load('maskRGBImageObtenida.mat');
load('BWObtenida.mat');

maskObtenida = 1 - BWObtenida;

diferencia = abs(double(BW)-double(BWObtenida));
error3 = sum(sum(diferencia));
fprintf('Error3: %d \n',error3);
% obtenemos un error menor que con los otros dos

imshow(diferencia, []);
title('Diferencia entre las imagenes')


figure, imshow(maskObtenida), title('Mascara obtenida');
figure, imshow(BW), title('Mascara propuesta 3');