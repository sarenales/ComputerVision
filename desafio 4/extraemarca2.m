function marca=extraemarca2(I,n2,eps)

[f,c]=size(I);
It=dct2(I);

mt=It(f-n2+1:f,c-n2+1:c)*(1/eps);
marca=idct2(mt);