clear all
load('matlab.mat');

[num_filas, num_columnas, num_bandas] = size(T1);
T1_reshape = reshape(T1, num_filas * num_columnas, num_bandas);

num_clusters = [1 2 3 4 5 6];
d = 99999999999999
for num_c = num_clusters

    [idx, ~] = kmeans(T1_reshape, num_c);
    
    idx_image = reshape(idx, num_filas, num_columnas);
    binary_image = idx_image == mode(idx(target));
    
  

    diferencia = abs(double(target)-double(binary_image));
    error = sum(sum(diferencia))
    if error < d
        d = error;
        optima = binary_image;
    end    
end
imshow(optima);