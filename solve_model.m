function z = solve_model(t_steps, ntrans, dim, t, p, numNode, a, b, z_initial, omega, K, A)

    z = zeros(t_steps - ntrans, dim * length(p));

    %statess = zeros(length(t), length(epsilon) * dim);

    for ii = 1:length(p)
        alpha = generate_random_alphas(numNode, a, b, p(ii));
        [t, sol] = ode45(@(t, y) model(t, y, alpha, omega, K, A), t, z_initial);
        z(:, (ii-1)*dim + 1:ii*dim) = sol(ntrans + 1:end, :);
    end
end

