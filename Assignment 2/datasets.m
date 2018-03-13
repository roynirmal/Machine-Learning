    a = gendatb([2000 2000]);

    lab = a.nlab;
    lab(find(lab == 2)) = -1;
    for j = 1:100
    rand = randperm(size(a,1));
    xl = a.data(rand(1:25),:);
    yl = lab(rand(1:25));
    trn = prdataset(xl,yl);
    a1 = find(yl == 1);
    a2 = find(yl == -1);

    xu = a.data(rand(26:1000),:);
    xtst = a.data(rand(1001:end),:);
    xtstlab = lab(rand(1001:end),:);
    tst = prdataset(xtst, xtstlab);
    xulabelg = graphbased(xl,xu,a1,a2);
    xulg = prdataset(xu, xulabelg(26:end));	
    mean1 = mean(xl(a1,:));
    mean2 = mean(xl(a2,:));
    prior1=size(a1,1)/(size(a1,1)+size(a2,1)); 
    prior2=size(a2,1)/(size(a1,1)+size(a2,1));
    %cov1 = cov(xl(a1,:));
    %cov2 = cov(xl(a2,:));
    cov1 = covariance(xl(a1,:), mean1);
    cov2 = covariance(xl(a2,:), mean2);
    V0=zeros(2,2,2);
    V0(:,:,1)=cov1;V0(:,:,2)=cov2;

    [m,v,w]=gaussmix(xu,[],[],[mean1 ;mean2],V0,[prior1; prior2]);
    % [m,v,w]=gaussmix(unlabeled(:,1:10),[],[],2);
    [lp,rp,xulabelE,kp]=gaussmixp(xu,m,v,w);
    xulabelE(find(xulabelE == 2)) = -1;
    %xul = prdataset(xu, xulabel);
    xulE = prdataset(xu, xulabelE);
    trnE = [trn; xulE];
    trng = [trn; xulg];
    w1 = ldc(trng);
    w2 = ldc(trn);
    w3 = ldc(trnE);
    e1(j) = testc(tst,w1);
    e2(j) = testc(tst,w2);
    e3(j) = testc(tst,w3);
    %display(j)

    end
    error1 = mean(e1);
    error2  = mean(e2);
    error3  = mean(e3);