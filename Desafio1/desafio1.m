clc, clear all,close all

archivos = dir('images\micrograph*.jpg');
labels = dir('labels\micrograph*.png');
resultados = cell(length(archivos), 2);
carpeta_grietas = 'grietas';

for i = 1:length(archivos)
    nombre_archivo = archivos(i).name;
    ruta_imagenes = fullfile('images', nombre_archivo);
    x = imread(ruta_imagenes);
    x = rgb2gray(x);
    x = x(1:702,:,1:1);
    
    nombre_label = labels(i).name;
    ruta_label = fullfile('labels', nombre_label);
    l = imread(ruta_label);
    l=l(1:702,:,1:1);

    TP = zeros(255, 1);
    FP = zeros(255, 1);
    funcion_objetivo = zeros(255, 1);

    umbral_optimo = -1;
    for theta = 1:255
        TP(theta) = bwarea((x<theta).*(l==4));
        FP(theta) = bwarea((x<theta).*(l<4));
        funcion_objetivo(theta) = TP(theta) - FP(theta);
    
        if funcion_objetivo(theta) > umbral_optimo
            umbral_optimo = theta;
        end
    end

    %imagen_binarizada_optima = x < umbral_optimo;
    %figure; imshow(imagen_binarizada_optima);
    

    resultados{i, 1} = nombre_archivo;
    tiene_fractura = umbral_optimo > 1;

    if tiene_fractura
        resultados{i, 2} = ['Fractura detectada con umbral óptimo en ' num2str(umbral_optimo)];
        imagen_binarizada_optima = x < umbral_optimo;
        imagen_binarizada_optima_gris = uint8(imagen_binarizada_optima) * 255;
        nombre_archivo_binarizada = ['binarizada_', nombre_archivo];
        ruta_archivo_binarizada = fullfile(carpeta_grietas, [nombre_archivo_binarizada]);
        imwrite(imagen_binarizada_optima_gris, ruta_archivo_binarizada);

    else
        resultados{i, 2} = 'No hay fractura detectada';
    end
end

resultados_path = 'resultados.xlsx';
writecell(resultados, resultados_path);
