function [theSol, theSolStd, theSolAp, theSolStdAp ] = nRc(zeroFull, oneFull, lambda)

for ii = 1:250
    
zeroMis = 0;
oneMis = 0;
zeroApmis = 0;
oneApmis = 0;

rand0 = randperm(size(zeroFull,1));
trn0 = zeroFull(rand0(1:1),:);
tst0 = zeroFull(rand0(2:end),:);


rand1 = randperm(size(oneFull,1));
trn1 = oneFull(rand1(1:1),:);
tst1 = oneFull(rand1(2:end),:);

N0 = length(trn0);
N1 = length(trn1);

% r0 = tst0(randi(size(tst0,1)),:);
% r1 = tst1(randi(size(tst1,1)),:);

r0 = trn0;
r1 = trn1;


D0 = pdist2(trn0, r0, 'squaredeuclidean');
D1 = pdist2(trn1, r1, 'squaredeuclidean');   
loss(1) = (sum(D0)/N0)+(sum(D1)/N1)+ lambda*sum(abs(r0-r1));
c = 0;
minloss = loss(1);
minr0 = r0;
minr1 = r1;



for k=2:10000
grad0 = -2*sum((trn0 - r0))/N0 + lambda*sign(r0-r1);
grad1 = -2*sum((trn1 - r1))/N1 - lambda*sign(r0-r1);

step0 = 1/(norm(grad0));
step1 = 1/(norm(grad1));

r0 = r0 - step0*grad0;
r1 = r1 - step1*grad1;

D0 = pdist2(trn0, r0, 'squaredeuclidean');
D1 = pdist2(trn1, r1, 'squaredeuclidean');
loss(k) = (sum(D0)/N0)+(sum(D1)/N1)+ lambda*sum(abs(r0-r1));

if(loss(k)<= minloss)
    minloss = loss(k);
    minr0 = r0;
    minr1 = r1;
    c = 0;
else
    c = c + 1;  
end

if(c>1000)
    break;
end

% step = 1/k;
end

if(pdist2(trn0, minr0, 'euclidean') > pdist2(trn0, minr1, 'euclidean'))
    zeroApmis = 1;
end


if(pdist2(trn1, minr1, 'euclidean') > pdist2(trn1, minr0, 'euclidean'))
    oneApmis = 1;
end



for p = 1:length(tst0)
    if(pdist2(tst0(p,:), minr0, 'euclidean') > pdist2(tst0(p,:), minr1, 'euclidean'))
        zeroMis = zeroMis + 1;
    end
end

for p = 1:length(tst1)
    if(pdist2(tst1(p,:), minr1, 'euclidean') >pdist2(tst1(p,:), minr0, 'euclidean'))
        oneMis = oneMis + 1;
    end
end

totalMis(ii) = 0.5*zeroMis/length(tst0) + 0.5*oneMis/length(tst1);
totalMisAp(ii) = 0.5*zeroApmis + 0.5*oneApmis;


end

theSol = mean(totalMis);
theSolStd = std(totalMis)/sqrt(ii);

theSolAp = mean(totalMisAp);
theSolStdAp = std(totalMisAp)/sqrt(ii);

end