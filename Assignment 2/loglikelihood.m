 M = dlmread('magic.txt');
  
  warning('off', 'all')
  
  for i = 1:10
      m = mean(M(:,i));
      sd = std(M(:,i));
      normData(:,i) = (M(:,i)-m)/sd;
  end
  
  for i = 1:size(M,1)
      if(M(i,11)==2)
          M(i,11) =-1;
      end
  end
  
    
  
  labels = M(:,11);
  a = prdataset(normData, labels);

  p = [0, 10,20, 40 , 80 , 160, 320, 640,1000];
  %p=10

          
  LL = [];
  error = [];
  for k =p 
      for j = 1:100
          
          if(k==0)
               rand = randperm(size(normData,1));
          xl = normData(rand(1:25),:);
          yl = labels(rand(1:25));
          trn = prdataset(xl,yl);
          tstx = normData(rand((25+k+1):end),:);
          tstlab = labels(rand((25+k+1):end));  
          tst = prdataset(tstx, tstlab);
          %count(k,j)= c;
          w = ldc(trn);
          loglike(j)= sum(sum(log(tst*w)));
             e(j) = testc(tst,w);
          else
          
          rand = randperm(size(normData,1));
          xl = normData(rand(1:25),:);
          yl = labels(rand(1:25));
          trn = prdataset(xl,yl);
          xu = normData(rand(26:(25+k)),:);
          a1 = find(yl == 1);
          a2 = find(yl == -1);
          mean1 = mean(xl(a1,:));
          mean2 = mean(xl(a2,:));
          prior1=size(a1,1)/(size(a1,1)+size(a2,1)); 
          prior2=size(a2,1)/(size(a1,1)+size(a2,1));
         cov1 = cov(xl(a1,:));
         cov2 = cov(xl(a2,:));
          cov1 = covariance(xl(a1,:), mean1);
          cov2 = covariance(xl(a2,:), mean2);
          V0=zeros(10,10,2);
          V0(:,:,1)=cov1;V0(:,:,2)=cov2;
         %[xulabel , c]= EM(mean1, mean2, cov1, cov2, xu, 0.5, 0.5);
          [m,v,w]=gaussmix(xu,[],[],[mean1 ;mean2],V0,[prior1; prior2]);
            %[m,v,w]=gaussmix(unlabeled(:,1:10),[],[],2);
          [lp,rp,xulabel,kp]=gaussmixp(xu,m,v,w);
           xulabel(find(xulabel == 2)) = -1;
          %xulabel = graphbased(xl,xu,a1,a2);
          %xul = prdataset(xu, xulabel(26:end));
          
          xul = prdataset(xu, xulabel);	
          finaltrn = [trn; xul];
          tstx = normData(rand((25+k+1):end),:);
          tstlab = labels(rand((25+k+1):end));  
          tst = prdataset(tstx, tstlab);
          %count(k,j)= c;
          w = ldc(finaltrn);
          
          loglike(j)= sum(sum(log(tst*w)));
           e(j) = testc(tst,w);
          
          end
      end
      LL(size(LL,2)+1)= mean(loglike);
     error(size(error,2)+1)= mean(e);
  end
  
%plot(p, LL)
% xticks([1 2 3 4 5 6 7 8 9])
% xticklabels({'0', '10','20','40','80','160','320', '640', '1000'})
 xlabel('#Unlabeled Data') % x-axis label
 ylabel('Log Likelihood') % y-axis label
% legend('EM', 'Graph Based')