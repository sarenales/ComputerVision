load('matlab.mat');

% OBTENCION FILTRO hyperspectral

T1_gris = sum(T1,3) / size(T1,3);

% aplicamos filtro gaussiano
sigma = 1;
T1_filtradas = imgaussfilt3(T1_gris, sigma);

% binarizacion
umbral = 0.2 * (mean(T1_filtradas(:) + max(T1_filtradas(:))));
T1_binarizada = T1_filtradas > umbral;

% deteccion bordes
B = edge(T1_binarizada, 'Canny');

% convertir tipo double para aplicar filtro gaussiano
bordes_numerico = double(B);

% dilatacion
d1 = strel('disk',1);
dilatados = imdilate(bordes_numerico,d1);

figure;
subplot(1,3,1);
imshow(dilatados);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OBTENCION DE BORDES piedras 
piedrasfiltradas = imread("piedrasfiltradas.jpg");

% aplicamos filtro lineal
sigma = 5;
filtro_lineal = fspecial('gaussian', [10 10], sigma);
piedrasfiltradas = imfilter(piedrasfiltradas, filtro_lineal);


% lmetodo = ["Sobel", "Prewitt", "Roberts", "Canny"];
% lumbral = [0.1 0.3 0.5 0.7 0.9];
% i=1
% figure
% for metodo = lmetodo
%    for umbral = lumbral
%       % binarizacion
%        imagen_binarizada = imbinarize(piedrasfiltradas, umbral);
% 
%        B = edge(imagen_binarizada, metodo);
%        bordes = imdilate(B, strel('disk',5));
%        bordes_final = imerode(bordes, strel('disk',3));
%        imagen_binarizada = imerode(imagen_binarizada, strel('disk',3));
%        subplot(size(lmetodo,2), size(lumbral,2),i), imshow(bordes_final), title([metodo, num2str(umbral)]);
%        i=i+1;
%    end
% end

i=1
for sigma = [0.1 0.2 0.3 0.4 0.45 0.5 0.55 0.6]
   % binarizacion
   imagen_binarizada = imbinarize(piedrasfiltradas, sigma);

   % deteccion bordes
   B = edge(imagen_binarizada, 'Canny');

   % dilatacion
   bordes = imdilate(B, strel('disk',5));
   bordes_final = imerode(bordes, strel('disk',3));
   subplot(2,4,i), imshow(imagen_binarizada), 
   title(['Canny: ' num2str(sigma)]);
   i=i+1;
end

imagen_binarizada = imbinarize(piedrasfiltradas, 0.3);
B = edge(imagen_binarizada, 'Canny');
bordes = imdilate(B, strel('disk',5));
bordes_final = imerode(bordes, strel('disk',3));
imshow(bordes_final);


