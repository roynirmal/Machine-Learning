  M = dlmread('magic.txt');
  
  for i = 1:10
      m = mean(M(:,i));
      sd = std(M(:,i));
      normData(:,i) = (M(:,i)-m)/sd;
  end
  
  labels = M(:,11);
  a = prdataset(normData, labels);

  p = [0,10,20, 40 , 80 , 160, 320, 640];
  
  error = [];
  for k =p  
      for j = 1:100
          rand = randperm(size(normData,1));
          xl = normData(rand(1:25),:);
          yl = labels(rand(1:25));
          trn = prdataset(xl,yl);
          xu = normData(rand(26:(25+k)),:);
          tstx = normData(rand((25+k+1):end),:);
          tstlab = labels(rand((25+k+1):end));
          tst = prdataset(tstx, tstlab);
          
          w = ldc(trn);
          e(j) = testc(tst,w);
      end
      error(size(error,2)+1)= mean(e);
  end
  