v = VideoReader('IMG_2544.MOV');
opticFlow = opticalFlowLK;

outputVideo = VideoWriter('output_video3.avi');
open(outputVideo);
while hasFrame(v)
    frameRGB=readFrame(v);
    frame = im2gray(frameRGB);
    subplot(1,3,1)
    imshow(frame)
    flow = estimateFlow(opticFlow,frame);
    foreground = flow.Magnitude;
    subplot(1,3,2)
    imshow(foreground)
    subplot(1,3,3)
    imshow(frameRGB); hold on
    plot(flow,DecimationFactor=[10 10],ScaleFactor=20);
    hold off
    drawnow
    writeVideo(outputVideo, getframe(gcf));
end
close(outputVideo);