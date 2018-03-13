function count1 = overlaplink(in,xsize,ysize,ox,oy)
[M N]=size(in);
count1=0;
count0=0;
if((mod(M-xsize,xsize-ox)==0)&&(mod(N-ysize,ysize-oy)==0))
    fprintf('Overlapping is possible');
%     i=1;
for k=1:ysize-oy:N-ysize+1  
    for l=1:xsize-ox:M-xsize+1
        Z=imcrop(in,[ k l xsize-1 ysize-1]);
%         name=num2str(i);
%         i=i+1;
%         imwrite(Z, strcat('C:/Users/PC/abcd/',strcat(name,'.bmp')),'bmp');
        result=background(Z);
        if(result==1)
            count1=count1+1;
        else
            count0=count0+1;
        end
    end
end
else
    fprintf('Uniform Overlapping not possible.Please change the dimensions of the window or the overlapping parameters');
    
end
end