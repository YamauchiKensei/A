function pred_data = prediction(pred_time, alpha, n, par, z_init, W_out, W_res, W_in, kb, pb, numNode)
    % Initialize u_train
    u_train = zeros(numNode * 2, pred_time); % numNode * 2 行のゼロ行列を用意
    for i = 1:numNode
        u_train(2*i - 1, :) = z_init(i) * ones(1, pred_time); % 実部
        u_train(2*i, :) = z_init(i + numNode) * ones(1, pred_time); % 虚部
    end

    % Add additional dimension for prediction input
    u_predict = [u_train; kb * (par - pb) * ones(1, pred_time)];

    % Initialize reservoir states
    r3 = zeros(n, pred_time);
    r4 = zeros(n, 1);

    % Reservoir computation loop
    for i = 1:pred_time - 1
        % Update r3 with reservoir dynamics
        r3(:, i + 1) = (1 - alpha) * r3(:, i) + alpha * tanh(W_res * r3(:, i) + W_in * u_predict(:, i));
        r4(:) = r3(:, i + 1);

        % Modify reservoir output for every second state
        r4(2:2:end) = r3(2:2:end, i + 1).^2;

        % Update prediction values after a warm-up period
        if i >= 500
            u_predict(1:numNode * 2, i + 1) = W_out * r4;
        end
    end

    % Extract prediction data
    pred_data = u_predict(1:2*numNode, 1001:end);
end

