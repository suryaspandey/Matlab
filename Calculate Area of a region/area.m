% clear all
% close all
% clc
%k parameter can be changed to adjust intensity of image
 ei=25;
 st=35;
 
%k=10
k=ei*st;
I = imread('sc120.jpg');% sp40,56,1,2,5,3, sc91,120, spt36,57,61

%h=filter matrx 
h = ones(ei,st) / k; % filter matrix of size (ei*st of ones)/k

I1 = imfilter(I,h,'symmetric');
figure
subplot(2,2,1),imshow(I), title('Original image');
subplot(2,2,2), imshow(I1), title('Filtered Image');
IG=rgb2gray(I1);
%Converting to BW
I11 = imadjust(IG,stretchlim(IG),[]); %increases contrast of image


level = graythresh(I11);% computes a global threshold (level) that can be used to convert an intensity image to a 
                       % binary image with im2bw. level is a normalized intensity value that lies in the range [0, 1]
BWJ = im2bw(I11,level); % converts the truecolor image I11 to a binary image
dim = size(BWJ);% array or vector dimension of BWJ
IN=ones(dim(1),dim(2));% no of ones in X and Y
BW=xor(BWJ,IN);  %inverting
subplot(2,2,3), imshow(BW), title('Black and White');

%Finding of initial point
row = round(dim(1)/2);% Determine the row and column coordinates of a pixel on the border of the object you want to trace
col = min(find(BW(row,:)));
%Tracing
boundary = bwtraceboundary(BW,[row, col],'W');
subplot(2,2,4),imshow(I), title('Traced');
hold on;
%Display traced boundary
plot(boundary(:,2),boundary(:,1),'b','LineWidth',2);
hold off
 
nn=size(boundary);% 1*2 row matrix.. 
KM=zeros(dim(1),dim(2));%% returns an array of 0
%ka matrix.. having dim of .. .. setting those values to 1 from original image.. boundary =1 rest 0
 ii=0;
 %Create new matrix with boundary points. there fore we can get rid of
 %other distortions outside boundaries
 % remove background
 while ii<nn(1)
     ii=ii+1;
    KM(boundary(ii,1),boundary(ii,2))=1;% boundary = 1 for KM: KM is all 0, it is setting certain KM values to 1
    % where it detects a point in boundary.. boundaries value to 1 in KM
end
 figure
 %%%subplot(2,2,1),plot(boundary(:,2),boundary(:,1),'black','LineWidth',2); % plot boundary with black
 subplot(2,2,1),imshow(KM)% plot outer  boundaries
%Fill inner boundaries
KM2 = imfill(KM,'holes');
subplot(2,2,2),imshow(KM2)
%%%KM1=xor(KM2,IN);
 %subplot(2,2,4),imshow(KM1)

figure
imshow(I)
hold on
plot(boundary(:,2),boundary(:,1),'green','LineWidth',2);
 hold on

bwarea(BW)
% Plot pixel area
position =  [100 50];
value = [bwarea(BW)];
%value_Cm = value*  0.026458333;
RGB = insertText(I, position, value, 'AnchorPoint', 'LeftBottom');
figure, imshow(RGB), title('Area in Pixels');