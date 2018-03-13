function cov = covariance(x, mean)

    cov = zeros(size(x,2));

    for i = 1:size(x,1)
        cov = cov + (x(i,:)-mean)'*(x(i,:)-mean);

    end

    cov = cov/size(x,1);

end