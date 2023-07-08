%embedding of bit 1 at the peak point using histogram shifting

clc
clear all
%read different images
img=imread('barbara.jpg');           
img=imresize(img, [512 512]);
if ( size ( img,3 ) ~= 1)
    img=rgb2gray(img);
end
%creating histogram from array of 512*512
[pixelCounts, grayLevels] = imhist(img);
m=max(pixelCounts);

%finding peak(maximum) and zero(minimum) points
a=find(pixelCounts==m)-1;   %Pixel value with Max Freq
b=find(pixelCounts==0)-1;   %Pixel value(s) with 0 Freq
c=find(b>a);
b=b(c);  %Take the first amongst the zero freq pixels
embed=img;
[row, col]=size(embed);


%Shifting the histogram by 1 unit to create space for embedding within the range [a,b]
for i=1:row
    for j=1:col
        if and(embed(i,j)>=a,embed(i,j)<b)
            embed(i,j)=embed(i,j)+1;
        end;
    end;
end;

%Message to be encoded of equal bits as the max frequency
message=randi([0 1],1,m); 

%Shift pixels within frequecy range by -1 unit if message bit is 1
ptr=1;%pointing to the index of the message
a=a+1;
for i=1:row
    for j=1:col
         if embed(i,j)==a
             if message(ptr)==1
                 embed(i,j)=embed(i,j)-1; 
                 ptr=ptr+1;
             else
                 ptr=ptr+1;
             end;
         end;
    end;
end;

%Displaying the Images
figure,
subplot(1,2,1);
imshow(img);
title('Original Image');
subplot(1,2,2);
imshow(embed);
title('Embedded Image');

%Displaying the Histograms
figure,
subplot(2,1,1);
imhist(img);
title('Histogram of Original Image');
subplot(2,1,2);
imhist(embed);
title('Histgram of Embedded Image');
imwrite(embed,'stego.png');

%Displaying the difference between Original and Embedded Image
X = gpuArray(img);
Y = gpuArray(embed);
Z = imabsdiff(X,Y);
figure
imshow(Z,[])
%the grayscale values of all pixels will be either inc or dec by 1 so the
%resultant mean square error(MSE) is at most equal to one 
%psnr=10log10(255*255/MSE)
PSNR= 10*log10(255^2/1);
fprintf('The PSNR = %.2f',PSNR);
