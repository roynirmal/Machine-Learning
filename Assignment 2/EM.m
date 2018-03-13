function [label, c] = EM(mean1, mean2, cov1, cov2, x, prior1, prior2)

[newmean1, newmean2, newcov1, newcov2, newprior1, newprior2, post1, post2] = EMupdate(mean1, mean2, cov1, cov2, x, prior1, prior2);
c = 0;
while(pdist2(mean1, newmean1, 'squaredeuclidean') >=0.000005 && pdist2(mean2, newmean2, 'squaredeuclidean') >=0.000005)
    mean1 = newmean1;
    mean2 = newmean2;
   [newmean1, newmean2, newcov1, newcov2, newprior1, newprior2, post1, post2] = EMupdate(mean1, mean2, newcov1, newcov2, x, newprior1, newprior2);
    c= c+1;

end

for i = 1:size(x,1)
    if(post1(i)>post2(i))
        label(i) = 1;
    else
        label(i) = -1;
    end
end
end
