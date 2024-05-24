function Imarcada=marcar(I,marca,n1,n2,eps)
[f,c]=size(I);
It=dct2(I); 
marcat=dct2(marca);
Imarcadat=zeros(size(It));
Imarcadat(1:n1,1:n1)=It(1:n1,1:n1);
Imarcadat(f-n2+1:f,c-n2+1:c)=marcat(1:n2,1:n2)*eps;
Imarcada=idct2(Imarcadat);