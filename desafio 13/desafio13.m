path = 'IMG_2544.MOV';

opticFlow1 = opticalFlowLK;
opticFlow2 = opticalFlowLK('NoiseThreshold',0.01);
opticFlow3 = opticalFlowHS;
opticFlow4 = opticalFlowFarneback;
opticFlow5 = opticalFlowLKDoG;

v = VideoReader(path);

outputVideo = VideoWriter('output_video1.avi');
open(outputVideo);

while hasFrame(v)
    frame = im2gray(readFrame(v));
    subplot(2,3,1)

    imshow(frame)
    flow1 = estimateFlow(opticFlow1,frame);
    foreground1 = flow1.Magnitude;
    subplot(2,3,2)

    imshow(foreground1), title('Lukas Kanade');
    flow2 = estimateFlow(opticFlow2,frame);
    foreground2 = flow2.Magnitude;
    subplot(2,3,3)

    imshow(foreground2), title('Lukas Kanade > 0.01');
    flow3 = estimateFlow(opticFlow3,frame);
    foreground3 = flow3.Magnitude;
    subplot(2,3,4)

    imshow(foreground3), 
    title('Horn-Schunck');
    flow4 = estimateFlow(opticFlow4,frame);
    foreground4 = flow4.Magnitude;
    subplot(2,3,5)

    imshow(foreground4), title('Farneback');
    flow5 = estimateFlow(opticFlow5,frame);
    foreground5 = flow5.Magnitude;
    subplot(2,3,6)
    
    imshow(foreground5), title('LK DoG');
    drawnow
    

    writeVideo(outputVideo, getframe(gcf));
end
close(outputVideo);