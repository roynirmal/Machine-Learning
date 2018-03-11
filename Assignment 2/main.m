  M = dlmread('magic.txt');
  
  warning('off', 'all')
  
  for i = 1:10
      m = mean(M(:,i));
      sd = std(M(:,i));
      normData(:,i) = (M(:,i)-m)/sd;
  end
  
  labels = M(:,11);
  a = prdataset(normData, labels);

  p = [10,20, 40 , 80 , 160, 320, 640];
 % p=640
%   [w, v] = pcam(normData,2);
%   normData = normData*w;
  
  countfinal = [];
  error = [];
  for k =p 
      for j = 1:200
          c=0;
          rand = randperm(size(normData,1));
          xl = normData(rand(1:25),:);
          yl = labels(rand(1:25));
          trn = prdataset(xl,yl);
          xu = normData(rand(26:(25+k)),:);
          wtemp1 = svc(trn);
          wtemp2 = nmc(trn);
          wtemp3 = loglc(trn);
          wtemp4 = ldc(trn);
          wtemp5 = qdc(trn);
         % xulabel = emclust(prdataset(xu), ldc, 2, 'soft');
          xulabel1 = xu*wtemp1*labeld;
          xulabel2 = xu*wtemp2*labeld;
          xulabel3 = xu*wtemp3*labeld;
          xulabel4 = xu*wtemp4*labeld;
          xulabel5 = xu*wtemp5*labeld;
          xulabelt = [xulabel1 xulabel2 xulabel3 xulabel4 xulabel5];
          for ind = 1:size(xulabelt,1)
              %xulabel(ind)= mode(xulabelt(ind,:));
              [M, F] = mode(xulabelt(ind,:));
              if(F==5 )
                  c=c+1;
                  xufinal(c,:) = xu(ind,:);
                  xulabel(c) = M;
                 
                 
              end
          end
          count(j) = c;
%           xultmp = prdataset(xu, xulabel');
%           xulabelfinal = emclust(xultmp, nmc);
          xul = prdataset(xufinal, xulabel');	
          finaltrn = [trn; xul];
          tstx = normData(rand((25+k+1):end),:);
          tstlab = labels(rand((25+k+1):end));
          tst = prdataset(tstx, tstlab);

          w = ldc(finaltrn);
          e(j) = testc(tst,w);  
      end
      error(size(error,2)+1)= mean(e);
      countfinal(size(countfinal,2)+1) = mean(count);
  end
  
  plot(1:7, error)
xticks([1 2 3 4 5 6 7])
xticklabels({'10','20','40','80','160','320', '640'})
xlabel('#Unlabeled Data') % x-axis label
ylabel('Error Rate') % y-axis label
%legend('True Error', 'Apparent Error')