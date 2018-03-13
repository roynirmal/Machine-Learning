%takes an image or a patch of an image as an input and computes its
%histogram as an array.it finds out the peak value and the index of the
%count where the peak lies.Then it finds the index for which the histogram
%has a value that is equal to 0.4(handwritten) or 0.6(machine printed)times
%the peak value.that indec is returned as thresh

function [thresh] = histnormforbinarization(in)
[M N]=size(in);
thresh=0;
[counts,binlocation]=imhist(in);
figure
imhist(in)
% for i=1:256
%     hist(i)=0;
% end
%  for i=1:M
%     for j=1:N
%         hist(in(i,j)+1)= hist(in(i,j)+1)+1;
%     end
%  end
% % for i=1:256
% %     hist(i)=hist(i)/(M*N);
% % end

peak_value=max(counts);
uint32(peak_value);
uint32(peak_value*0.4);
for i=1:256
   if(counts(i)==peak_value)
       start=i;
   end
end
start
for i=1:256
   if(uint32(peak_value*0.4)>counts(i));
       difference(i)=uint32((peak_value*0.4)-counts(i));
   else
       difference(i)=counts(i)-uint32(peak_value*0.4);
   end
end
   difference;    
a=min(difference);
a;

for i=1:256
   if(a==difference(i))
       thresh=i;
   end
end
thresh;
end
