close all
path0 = 'imagenes_experimentales/imagenes_experimentales/Cable-perfect/im0.png';
path1 = 'imagenes_experimentales/imagenes_experimentales/Cable-perfect/im1.png';
path1E = 'imagenes_experimentales/imagenes_experimentales/Cable-perfect/im1E.png';
path1L = 'imagenes_experimentales/imagenes_experimentales/Cable-perfect/im1L.png';

pathverdad0 = 'imagenes_experimentales/imagenes_experimentales/Cable-perfect/disp0-n.pgm';
pathverdad1 = 'imagenes_experimentales/imagenes_experimentales/Cable-perfect/disp1-n.pgm';

im0 = imread(path0);
im1 = imread(path1);
im1E = imread(path1E);
im1L = imread(path1L);
verdad0 = imread(pathverdad0);
verdad1 = imread(pathverdad1);

% estos valores se encuentran en calib.txt 24 248
vmin = 88;
vmax = 184;
disp_range = [vmin vmax];
disparity_map01 = disparitySGM(rgb2gray(im0), rgb2gray(im1), 'DisparityRange',disp_range);
disparity_map0E = disparitySGM(rgb2gray(im0), rgb2gray(im1E), 'DisparityRange',disp_range);
disparity_map0L = disparitySGM(rgb2gray(im0), rgb2gray(im1L), 'DisparityRange',disp_range);
figure;
subplot(1,3,1);
imshow(disparity_map01, disp_range); title('Disparidad calculada (im0 im1)');
subplot(1,3,2);
imshow(disparity_map0E, disp_range); title('Disparidad calculada (im0 im1E)');
subplot(1,3,3);
imshow(disparity_map0L, disp_range); title('Disparidad calculada (im0 im1L)');
figure;
subplot(1,2,1);
imshow(verdad0, [0 64]); title('Verdad del terreno im0');
subplot(1,2,2);
imshow(verdad1, [0 64]); title('Verdad del terreno im1');

% calculo del error
error0 = abs(double(verdad0) - double(disparity_map01));
error1 = abs(double(verdad1) - double(disparity_map01));
error0(isnan(error0)) =0;
error1(isnan(error1)) =0;

mean(error0(:))
mean(error1(:))
sum(error0(:))
sum(error1(:))