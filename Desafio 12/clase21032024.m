im0= imread("im0.png");
imshow(im0);

im1= imread("im1.png");
imshow(im1);

imshow(stereoAnaglyph(im0, im1));