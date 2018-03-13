% hoping to make a function which i can use widely in the future.
% INPUTS
% in=a binary image
% limit=the limit for eliminating certain connected components whose
% numbers fall below limit,those points will become background in the
% original image
% bwlabel offers 4 as well as 8 connectivity.feel free to use whichver you
% feel is more applicable

function post_processed=post_processing(input,limit)

% input=imread('D:\DIBCO\results\thresholding\DIBCO DATASET 2013\PR03\binarized.bmp');
in=logical(input);
limit=20;
[M,N]=size(logical(in));
[L,num]=bwlabel(~(in),8);
% num
% figure
% imshow(L);
number_of_components=max(L(:));
post_processed=input;

% now i am about to search for each labelled region and count the number of
% pixels belongng to that region(its area).so a counter is needed inside
% the loop
for k=1:number_of_components
    population_count=0;
    for i=1:M
        for j=1:N
            if(L(i,j)==k)
                 population_count=population_count+1;
            end
        end
    end
%     population_count
    if(population_count<=limit)
        
        for i=1:M
            for j=1:N
                if(L(i,j)==k)
                    post_processed(i,j)=255;     
                end
            end
        end
    end
    
end
% figure
% imshow(uint8(post_processed));

% [L,num2]=bwlabel(logical(post_processed),8);
% num2;
% imwrite(uint8(post_processed),'D:\DIBCO\results\thresholding\2011\post_processed(o with 2 clustering).bmp','bmp');
end