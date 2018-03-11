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

  p = [10,20, 40 , 80 , 160, 320, 640];
  
  error = [];
  for k =p 
      for j = 1:100
          c=0;
          rand = randperm(size(normData,1));
          xl = normData(rand(1:25),:);
          yl = labels(rand(1:25));
          trn = prdataset(xl,yl);
          xu = normData(rand(26:(25+k)),:);
          a1 = find(yl==1);
          a2 = find(yl==-1);
          xulabel = graphbased(xl,xu,a1,a2);
          xul = prdataset(xu, xulabel(26:end));	
          finaltrn = [trn; xul];
          tstx = normData(rand((25+k+1):end),:);
          tstlab = labels(rand((25+k+1):end));
          tst = prdataset(tstx, tstlab);

          w = ldc(finaltrn);
          e(j) = testc(tst,w);  
      end
      error(size(error,2)+1)= mean(e);
     
  end
  
plot(1:7, error)
xticks([1 2 3 4 5 6 7])
xticklabels({'10','20','40','80','160','320', '640'})
xlabel('#Unlabeled Data') % x-axis label
ylabel('Error Rate') % y-axis label

  