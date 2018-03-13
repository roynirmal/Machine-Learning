function[ y ] = graphbased(datal, datau, a1, a2)

data = [datal; datau];


dist =exp(-squareform(pdist(data(:,:))).^2);

thresh = mean(dist(:)) - std(dist(:));
[m, n] = size(data);
for i = 1:size(dist,1)
    for j = 1:size(dist,1)
        if(dist(i,j)>=thresh)
            A(i,j) =1;
            A(j,i) =1;
        else
            A(i,j) = 0;
            A(i,j) = 0;
            dist(i,j) = 0;
            dist(j,i) = 0;
        end
    end
end

Dtemp = sum(A');
D = diag(Dtemp);
L = D - dist;

cvx_begin quiet
variable y(m)

minimise(y'*L*y/2)
subject to
y(a1) == 1;
y(a2) == -1;
-1<=y<=1;

cvx_end

for k = 1:m
    if y(k)>=0
        y(k)=1;
    else
        y(k)=-1;
    end
end

end
