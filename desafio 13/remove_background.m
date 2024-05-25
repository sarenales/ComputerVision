v = VideoReader('IMG_2544.MOV');
background = double(readFrame(v));
a = 0.05;
b = 10;

outputVideo = VideoWriter('output_video2.avi');
open(outputVideo);
while hasFrame(v)
    frame = readFrame(v);
    subplot(1,3,1)
    imshow(frame)
    
    foreground = double((double(frame) - background) > b);
    subplot(1,3,2)
    imshow(foreground)
    
    % modelo adaptativo 
    background = a*background + 0.1*double(frame);
    %background = a*double(frame) + (1-a)*double(background);
    subplot(1,3,3)
    imshow(uint8(background))
    drawnow
    writeVideo(outputVideo, getframe(gcf));
end
close(outputVideo);