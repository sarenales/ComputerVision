
lena_gray = imread('lena_gray.jpg');

% trabajamos sobre lena_gray
% parametros a jugar nhidden nepocas

[nfila ncol]=size(lena_gray);
lena_gray=double(lena_gray);

% principales parametros experimentales
nhidden=180;
nepocas=3000;
nbloc=16;
nprinc_comp=500;

%extraer los bloques de nblocxnbloc
k=0;
for i=1:nbloc:nfila
    for j=1:nbloc:ncol
        k=k+1;
        x=lena_gray(i:i+nbloc-1,j:j+nbloc-1);
        xtrain{k}=x;
        xpca(k,:)=x(:);
    end
end

%prepara autoencoder
autoenc = trainAutoencoder(xtrain,nhidden,'MaxEpochs',nepocas);

%crea imagen con ruido
ruido= rand(size(lena_gray))*64;
x=lena_gray; y=ruido;
calidad=snr(x,y);
lena_noise=lena_gray+ruido; 
figure; imshow(lena_noise,gray);

% limpia usando el autoencoder
lena_limpia=zeros(size(lena_gray));


for i=1:nbloc:nfila
    i
    for j=1:nbloc:ncol
        x=lena_noise(i:i+nbloc-1,j:j+nbloc-1);
        c=encode(autoenc,x);
        y=decode(autoenc,c);
        lena_limpia(i:i+nbloc-1,j:j+nbloc-1)=y{1};
    end
end

figure; imshow(lena_limpia,gray)

%limpiando con pca
% prepara el pca
meanpca=mean(xpca,1);
xpcac=xpca-meanpca;
[c,s,l]=pca(xpcac);

lena_limpia=zeros(size(lena_gray));
c=c(:,1:nprinc_comp);
for i=1:nbloc:nfila
    i
    for j=1:nbloc:ncol
        x=lena_noise(i:i+nbloc-1,j:j+nbloc-1);
        x=x(:)';
        x=x-meanpca;
        cx=x*c; % trasformacion pca
        xlimpio=c*cx';
        xlimpio=xlimpio'+meanpca;
        lena_limpia(i:i+nbloc-1,j:j+nbloc-1)=reshape(xlimpio,nbloc,nbloc);
    end
end

figure; imshow(lena_limpia,gray);
