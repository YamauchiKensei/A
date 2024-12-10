function W_out = create_ESN(ESN_par, x_data, par1, W_in, W_res, kb, pb)
    n = ESN_par(1);
    alpha = ESN_par(2);
    beta = ESN_par(3);
    Nt = ESN_par(4);
    Np = ESN_par(5);
    transit = ESN_par(6);
    dim = ESN_par(7);
    tp_dim = length(par1);

    % Training phase
    U = zeros(dim, tp_dim * (Nt - transit + 1));
    R = zeros(n, tp_dim * (Nt - transit + 1));
    m = randi([1, 500]);

    for ii = 1:tp_dim
        %disp(par1(ii));
        u_train = x_data(dim * (ii-1) + 1:dim * ii, m:(m + Nt));
        u1_train = [u_train; kb*(par1(ii) - pb)* ones(1, Nt + 1)];

        r1 = zeros(n, Nt + 1);
        r2 = zeros(n, Nt + 1);

        for i = 1:Nt
            r1(:, i + 1) = (1 - alpha) * r1(:, i) + alpha * tanh(W_res * r1(:, i) + W_in * u1_train(:, i));
            r2(:, i + 1) = r1(:, i + 1);
            r2(2:2:end, i + 1) = r1(2:2:end, i + 1).^2;
        end

        U(:, (Nt - transit + 1) * (ii-1) + 1:(Nt - transit + 1) * ii) = u1_train(1:dim, transit + 1:Nt + 1);
        R(:, (Nt - transit + 1) * (ii-1) + 1:(Nt - transit + 1) * ii) = r2(:, transit + 1:Nt + 1);
    end

    R_T = R';
    W_out = U * R_T / (R * R_T + beta * eye(n));
end

