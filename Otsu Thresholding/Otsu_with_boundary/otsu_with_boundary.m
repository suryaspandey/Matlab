
%http://angeljohnsy.blogspot.com/2011/06/otsus-thresholding-without-using-matlab.html
function mygraythresh

global H Index;


B=imread('pothole5.jpg');
imshow(B);
V=reshape(B,[],1);
%The histogram of the values from 0 to 255 is stored.
G=hist(V,0:255);
H=reshape(G,[],1);
Ind=0:255;

 Index=reshape(Ind,[],1);

 result=zeros(size([1 256]));
 % calculate weight and variance for foreground and the background for a value of ‘i’
for i=0:255

     [wbk,varbk]=calculate(1,i);

     [wfg,varfg]=calculate(i+1,255);
     %After calculating the weights and the variance, the final computation is stored in the array ‘result’.
     result(i+1)=(wbk*varbk)+(wfg*varfg);
 end


 %Find the minimum value in the array.                 
 [threshold_value,val]=min(result);
     tval=(val-1)/256;
     % convert the image to binary with the calculated threshold value.
     % 
     bin_im=im2bw(B,tval);

     figure,imshow(bin_im);
    % imwrite(bin_im, 'C:\Users\Surya\Desktop\types of distress\images\img_test1.jpg');%extra line added below
     


 function [weight,var]=calculate(m,n)


%Weight Calculation
     weight=sum(H(m:n))/sum(H);   

%Mean Calculation

     value=H(m:n).*Index(m:n);

     total=sum(value);

     mean=total/sum(H(m:n));

     if(isnan(mean)==1)

         mean=0;

     end

%Variance calculation.
%? w2 (t) = q1 (t)? 12 (t) + q2 (t)? 22 (t)
    value2=(Index(m:n)-mean).^2;

     numer=sum(value2.*H(m:n));

     var=numer/sum(H(m:n));

     if(isnan(var)==1)
         var=0;

     end
 end
boundary1(bin_im);
 end