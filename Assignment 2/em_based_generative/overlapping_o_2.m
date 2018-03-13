function [runtime] = overlapping(A)
B=rgb2gray(A);
% B=A;
% figure
% imshow(B);
[M N]=size(B);
T=floor(0.98*M*N);
size=0;
med=B;
decision=0;
while decision<T
 size=size+5; 
%  if (size==30)
%      break;
%  end
 med=medfilt2(med,[size size]);
 decision=overlaplink(med,3,3,2,2);
end
% figure
% imshow(med);
% d=size*size;
% med=ordfilt2(med,d,ones(size,size));
% imwrite(med,'D:\DIBCO\results\thresholding\2013\background(0).bmp','bmp');

%background estimate is med
%to find foreground estimate
for i=1:M
    for j=1:N
        if(med(i,j)>B(i,j))
            tentative_foreground(i,j)=med(i,j)-B(i,j);
        elseif(B(i,j)>med(i,j))
             tentative_foreground(i,j)=B(i,j)-med(i,j);
        else
            tentative_foreground(i,j)=0;
        end
    end
end
% figure
% imshow(tentative_foreground);
% imwrite(tentative_foreground,'D:\DIBCO\results\thresholding\2013\tentative_foreground(0).bmp','bmp');
% figure
% imhist(tentative_foreground);
Th=histnormforbinarization(tentative_foreground);

for i=1:M
    for j=1:N
        if(tentative_foreground(i,j)>Th)
            foreground(i,j)=B(i,j);
        else
            foreground(i,j)=255;
        end
    end
end
% only global threshold(original method)
% figure
% imshow(foreground);
% imwrite(uint8(foreground),'D:\DIBCO\results\thresholding\2013\foreground(0).bmp','bmp');

[data,m,v,w,lp,rp,kh,kp,binarized_image]=overlaplinkforlcm_o_2(foreground,3,3,2,2);

runtime=toc;
end