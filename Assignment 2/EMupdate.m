function [newmean1, newmean2, newcov1, newcov2, newprior1, newprior2, post1, post2] = EMupdate(mean1, mean2, cov1, cov2, x, prior1, prior2)

N = size(x,1);

for i = 1:N

if(det(cov1)<= 10^-12)
c1 = 1/((((2*3.14)^5)*( det(cov1)^0.5))+0.1); 
else
    c1 = 1/(((2*3.14)^5)*( det(cov1)^0.5));
end

if(det(cov2)<=10^-12)
    c2 = 1/((((2*3.14)^5)*( det(cov2)^0.5))+0.1); 
else
c2 = 1/(((2*3.14)^5)*(det(cov2)^0.5));
end

ex1 = exp(-(x(i,:) - mean1)*pinv(cov1)*(x(i,:)-mean1)'*0.5);
ex2 = exp(-(x(i,:) - mean2)*pinv(cov2)*(x(i,:)-mean2)'*0.5);

ccd1 = c1*ex1;
ccd2 = c2*ex2;

px = ccd1*prior1 + ccd2*prior2;

post1(i) = real((ccd1*prior1)/px);
post2(i) = 1 - post1(i);

end

newmean1 = zeros(1,10);
newmean2 = zeros(1,10);
newcov1 = zeros(10);
newcov2 = zeros(10);

for j = 1:N

newmean1 = newmean1 + post1(i)*x(i,:);
newmean2 = newmean2 + post2(i)*x(i,:);

newcov1 = newcov1 + (post1(i)*(x(i,:)-newmean1)'*(x(i,:)-newmean1));
newcov2 = newcov2 + (post2(i)*(x(i,:)-newmean2)'*(x(i,:)-newmean2));
end

newmean1 = real(newmean1/sum(post1));
newmean2 = real(newmean2/sum(post2));
newcov1 = real(newcov1/sum(post1));
newcov2 = real(newcov2/sum(post2));


newprior1 = sum(post1)/N;
newprior2 = 1 - newprior1;
    
end

