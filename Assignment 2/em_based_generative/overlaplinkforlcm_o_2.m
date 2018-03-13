% this function takes every 3X3 patch,and every pixel in that pach is
% represented by a 2d vector.the first element being the central patch
% value and the second being its own pixel value

function [q_shortened,m,v,w,lp,rp,kh,kp,binarized_image] = overlaplinkforlcm_o_2(in,xsize,ysize,ox,oy)

[M,N]=size(in)
binarized_image=zeros(M,N);
% initialising the binary image
for i=1:M
    for j=1:N
        binarized_image(i,j)=255;
    end
end

% checking for overlapping 
if((mod(M-xsize,xsize-ox)==0)&&(mod(N-ysize,ysize-oy)==0))
    fprintf('Overlapping is possible');
%  declaring the matrix for holding all the possible pixel values
col=(M-xsize+1)*(N-ysize+1)*(8);
q=zeros(3,col);
pixelcount=0;
    for k=1:ysize-oy:N-ysize+1  
    for l=1:xsize-ox:M-xsize+1
        
        Z=imcrop(in,[ k l xsize-1 ysize-1]);
%         calculating michelsons contrast
          max_patch=max(Z(:));
          min_patch=min(Z(:));
          var1=double(max_patch-min_patch);
          var2=double(max_patch+min_patch);
          if (var2==0)
          michelsons_contrast=0;
          else
          michelsons_contrast=double(var1/var2);
          end
          modified_michelsons_contrast=double(255*(1-tanh(2*michelsons_contrast)));

        if(Z(2,2)==255)
%              pixelcount=pixelcount+1;
%              q(:,pixelcount)=255;
%             
%              q(2,pixelcount)=Z(i,j);
%              q(3,pixelcount)=modified_michelsons_contrast;
             continue;
        else
%       projecting each pixel of Z to a 3d vector(lcm representation)
       
         for i=1:3
             for j=1:3
                 if((i==2)&&(j==2))
                     continue;
                 else
                 pixelcount=pixelcount+1;
                 q(1,pixelcount)=Z(2,2);
                 q(2,pixelcount)=Z(i,j);
                 q(3,pixelcount)=modified_michelsons_contrast;
                 end
             end
         end
        end
    end
    end

else
    fprintf('Uniform Overlapping not possible.Please change the dimensions of the window or the overlapping parameters');
    
end

% shortening q
for i=1:col
    if((q(1,i)==0)&&(q(2,i)==0)&&(q(3,i)==0))
    last=i;
    break;
    else
        continue;
    end
end
q_shortened= q(1:3,1:last-1);
data_set=transpose(q_shortened);
[data_set_rows,data_set_columns]=size(q_shortened);
% M0=[20,20,20;230,230,230];
% V0=[50,50,50;100,100,100];
% W0=[0.5;0.5];
% WX=ones(col,1);

%  fitting the data to the gaussian mixture model using em algorithm
%  kh contains the label to which each observation vector belongs
%  [m,v,w]=gaussmix(data_set,[],[],2);
% [m,v,w]=gaussmix(data_set,[],[],[20,20,20;125,125,125;230,230,230],[50,50,50;75,75,75;100,100,100],[0.333;0.333;0.334],ones(data_set_columns,1));
[m,v,w]=gaussmix(data_set,[],[],[20,20,20;230,230,230],[50,50,50;100,100,100],[0.5;0.5],ones(data_set_columns,1));

 [lp,rp,kh,kp]=gaussmixp(data_set,m,v,w);
 
 fprintf('clustering done');
 
% what to do with cluster 3 now?
% d1=euclidean_distance_calculator(transpose(m(1,:)),transpose(m(2,:)));
% d2=euclidean_distance_calculator(transpose(m(2,:)),transpose(m(3,:)));
% 
% if(d1<d2)
%    for z=1:data_set_columns
%        if(kh(z,1)==2)
%            kh(z,1)=1;
%        end
%    end
% else
%     for z=1:data_set_columns
%        if(kh(z,1)==2)
%            kh(z,1)=3;
%        end
%     end
% end
    
%  now we need to extract each patch again and store the location of the
%  topmost patch locations and inside count the element of each patch and
%  compare the label as well.
s=0;
number_of_loops=0;
 for k=1:ysize-oy:N-ysize+1  
    for l=1:xsize-ox:M-xsize+1
        
        
         Z=imcrop(in,[ k l xsize-1 ysize-1]);
%         accessing each elemet of a patch

if(Z(2,2)==255)
     binarized_image(l+1,k+1)=255;
%                       binarized_image(l,k)=255;
%                       binarized_image(l+1,k)=255;
%                       binarized_image(l+2,k)=255;
%                       binarized_image(l,k+1)=255;
%                       binarized_image(l+2,k+1)=255;
%                       binarized_image(l,k+2)=255;
%                       binarized_image(l+1,k+2)=255;
%                       binarized_image(l+2,k+2)=255;
else   

        
          for i=s+1:s+8
              if(kh(i,1)==1)
                      binarized_image(l+1,k+1)=0;
%                       binarized_image(l,k)=255;
%                       binarized_image(l+1,k)=255;
%                       binarized_image(l+2,k)=255;
%                       binarized_image(l,k+1)=255;
%                       binarized_image(l+2,k+1)=255;
%                       binarized_image(l,k+2)=255;
%                       binarized_image(l+1,k+2)=255;
%                       binarized_image(l+2,k+2)=255;
                      
                      break;
                      
              else 
%                       binarized_image(l+1,k+1)=255;
%                       binarized_image(l,k)=255;
%                       binarized_image(l+1,k)=255;
%                       binarized_image(l+2,k)=255;
%                       binarized_image(l,k+1)=255;
%                       binarized_image(l+2,k+1)=255;
%                       binarized_image(l,k+2)=255;
%                       binarized_image(l+1,k+2)=255;
%                       binarized_image(l+2,k+2)=255;
continue;
                      
                      
                  
                      
              end
              
          end
          s=s+8;
          
%           if(s==data_set_columns)
%               break;
%           end
           number_of_loops=number_of_loops+1;  
end
          
    end
%           if(s==data_set_columns)
%               break;
%           end
%           
             
    end
 
%  figure
%  imshow(uint8(binarized_image));
%  imwrite(uint8(binarized_image),'D:\DIBCO\results\thresholding\2011\binarized(o with 2 clustering).bmp','bmp');
%  s
%  number_of_loops
%  k
%  l
 post_processing(uint8(binarized_image),20);
 end



