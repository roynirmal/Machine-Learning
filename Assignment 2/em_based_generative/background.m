function [out]= background(in)
% [row col]= size(in);
% sum=0;
% for i=1:row
%     for j=1:col
%         sum=sum+in(i,j);
%     end
% end
% mean=sum/(row*col);
% sq_deviation=0;
% for i=1:row
%     for j=1:col
%         sq_deviation=sq_deviation+(in(i,j)-mean)^2;
%     end
% end
% variance=sq_deviation/((row*col)-1);
std=uint8(std2(in));
if (std<6)
  out=1;
else
    out=0;
end

end
    