% desafio 4, escenografia => el arte de ocultar informacion
% guardar una marca de propiedad en los datos.
% ex: marcas de agua, imagen retratada



piedrasMarcadas = imread("piedrasMarcadas.png");
imshow(piedrasMarcadas);
piedras_gris = rgb2gray(piedrasMarcadas);


imshow(y);

[f,c]=size(piedras_gris);
i=1
figure
ln2 = [128.7 128.8 128.9 129]   % ir modificando la lista de pixeles hasta encontrar el óptimo
leps = [7 8 9 10 11 12]         % ir modificando la lista de posibles eps hasta encontrar el óptimo
for n2 = ln2
  for eps = leps
      y2 = dct2(piedras_gris)
      y2 = y2(f-n2+1:f,c-n2+1:c)/eps
      y2 = idct2(y2)
      subplot(size(ln2,2),size(leps,2),i), imshow(y2), title(['n2: ',num2str(n2),', eps: ',num2str(eps)])
      i=i+1
  end
end



