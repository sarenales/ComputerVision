
% input
playa = imread("playa.png");
region_extraida = imread("region_extraida.png");

% lo que hay que obtener
mascara = imread("mascara.png");

playa_gris = rgb2gray(playa);
region_extraida_gris = rgb2gray(region_extraida);

% filtrado con banco de filtros de Gabor
orientaciones = [0, 45, 90, 135];
wavelength = [2 4 8 16];
g = gabor(20, orientaciones);
xf = imgaborfilt(playa_gris, g);

% normalizar las bandas resultates del filtro de Gabor
for i=1:size(xf,3)
    xx=xf(:,:,i); xx=xx/max(xx(:));
    xfn(:,:,i)=xx; 
    %imshow(xx);
    %pause
end

% Binarizar la región extraída
d = 999999999
umbral = [0.001, 0.002, 0.003, 0.1, 0.5, 1]; % Ajusta el umbral según sea necesario
for u = umbral
    region_binaria = imbinarize(region_extraida_gris, u);
    diferencia = abs(double(mascara)-double(region_binaria));
    error = sum(sum(diferencia))
    if error < d
        d = error;
        optima = region_binaria;
    end
end
imshow(optima);