function [train]= gmm_unsupervised(labeled,unlabeled)
% labeled is 25x11 labeled data
% unlabeled is NX11 unlabeled data
% current function calls em algorithm with gaussian mixture model to
% predict the labels of the unlabeled data
% labeled data will be needed for calculating the means and covariance
% matrices of ecah class
[m,~]=size(labeled);
g=1;h=1;
for i=1:m
    if labeled(i,11)==1
        classg(g,1:10)=labeled(i,1:10);
        g=g+1;
    else
        classh(h,1:10)=labeled(i,1:10);
        h=h+1;
    end
end
% calculate mean and covariance of each class
% mean
mean_g=mean(classg);mean_h=mean(classh);
% covariance matrix for g
[g1,g2]=size(classg);
cov_g=zeros(g2,g2);
for i=1:g1
    cov_g=cov_g+(classg(i,:)-mean_g)'*((classg(i,:)-mean_g));
end
cov_g=cov_g/g1;
% covariance matrix for h
[h1,h2]=size(classh);
cov_h=zeros(h2,h2);
for i=1:h1
    cov_h=cov_h+(classh(i,:)-mean_h)'*((classh(i,:)-mean_h));
end
cov_h=cov_h/g1;
% prior probabilties
wg=g1/(g1+h1);wh=h1/(g1+h1);
% covariance matrices stacked together
V0=zeros(10,10,1);
V0(:,:,1)=cov_g;V0(:,:,2)=cov_h;
% callingV) em
[m,v,w]=gaussmix(unlabeled(:,1:10),[],[],[mean_g;mean_h],V0,[wg;wh]);
% [m,v,w]=gaussmix(unlabeled(:,1:10),[],[],2);
[lp,rp,kh,kp]=gaussmixp(unlabeled(:,1:10),m,v,w);
% labels to be appended=kh
% expecting clusters to be numbered 1 and 2. change those with 2 to -1
for i=1:length(kh)
    if kh(i)==2
        kh(i)=-1;
    end
end
train=[labeled;unlabeled(:,1:10),kh];

end