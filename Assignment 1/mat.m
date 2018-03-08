M = dlmread('optdigitsubset.txt');

zero = M(1:554, :);
one = M(555:1125, :);

N0 = length(zero);
N1 = length(one);

% zero= [4;3];
% one = [-1;1];
% 
lambda = 1000;
%step = 0.001;
% 
% r0 = 2;
% r1 = 3;
% 
% N0 = 2;
% N1 = 2;

r0 = zero(randi(size(zero,1)),:);
r1 = one(randi(size(one,1)),:);

D0 = pdist2(zero, r0, 'squaredeuclidean');
D1 = pdist2(one, r1, 'squaredeuclidean');   
loss(1) = (sum(D0)/N0)+(sum(D1)/N1)+ lambda*sum(abs(r0-r1));
c = 0;
minloss = loss(1);
minr0 = r0;
minr1 = r1;



for k=2:1000
grad0 = -2*sum((zero - r0))/N0 + lambda*sign(r0-r1);
grad1 = -2*sum((one - r1))/N1 - lambda*sign(r0-r1);

step0 = 1/(norm(grad0));
step1 = 1/(norm(grad1));

r0 = r0 - step0*grad0;
r1 = r1 - step1*grad1;

D0 = pdist2(zero, r0, 'squaredeuclidean');
D1 = pdist2(one, r1, 'squaredeuclidean');
loss(k) = (sum(D0)/N0)+(sum(D1)/N1)+ lambda*sum(abs(r0-r1));

if(loss(k)<= minloss)
    minloss = loss(k);
    minr0 = r0;
    minr1 = r1;
    c = 0;
else
    c = c + 1;
end

% if(c>100)
%     break;
% end

% step = 1/k;

end

plot(1:1000, loss)
xlabel('Iterations') % x-axis label
ylabel('Loss') % y-axis label
% subplot(1,2,1),imshow(reshape(uint8(minr0),[8 8])')
% 
% subplot(1,2,2), imshow(reshape(uint8(minr1),[8 8])')

