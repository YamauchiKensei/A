function W_reservoirr = W_ress(k, n, eig_rho)
    % ER network n*n and its radius is eig_rho
    prob = k / (n - 1);
    W = zeros(n, n);
    
    for i = 1:n
        for j = 1:n
            if (i ~= j) && (rand() < prob)
                W(i, j) = rand();
            end
        end
    end
    
    rad = max(abs(eig(W)));
    W_reservoirr = W * (eig_rho / rad);
end
