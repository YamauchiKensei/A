function alpha = generate_random_alphas(N, a, b, p)
    alpha = zeros(N, 1);
    num_a = round(N*(1-p));
    alpha(1:num_a) = a;
    alpha(num_a+1:end) = b;
    alpha = alpha(randperm(N));
end

