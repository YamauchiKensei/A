function W_inputt = W_inn(n, dim, W_in_a)
    W_inputt = zeros(n, dim + 1);
    
    for i = 1:n
        W_inputt(i, floor((i - 1) * dim / n) + 1) = (2 * rand() - 1) * W_in_a;
    end
    
    W_inputt(:, dim + 1) = (2 * rand(n, 1) - 1) * W_in_a;
end