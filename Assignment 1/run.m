    M = dlmread('optdigitsubset.txt');

    zero = M(1:554, :);
    one = M(555:1125, :);

lambda = [0, 0.1, 1, 10, 100, 1000];
c=1;

for i = lambda
    [theSol(c), theSolStd(c), theSolAp(c), theSolStdAp(c)] = nRc(zero, one, i);
    c=c+1;
end


errorbar(1:6, theSol, theSolStd/2)
hold on
errorbar(1:6, theSolAp, theSolStdAp/2)
xticks([1 2 3 4 5 6])
xticklabels({'0','0.1','1','10','100','1000'})
xlabel('Lambda') % x-axis label
ylabel('Error Rate') % y-axis label
legend('True Error', 'Apparent Error')