function dydt = model(~, y, alpha, omega, K, A)
    N = length(y) / 2; % yの長さを2で割ってノード数を取得
    z = y(1:N) + 1i * y(N+1:end); % 実部と虚部を複素数に変換

    dzdt = zeros(N, 1) + 1i * zeros(N, 1);
    for j = 1:N
        dzdt(j) = (alpha(j) + 1i * omega - abs(z(j))^2) * z(j);
        for k = 1:N
            dzdt(j) = dzdt(j) + (K / N) * A(j, k) * (z(k) - z(j));
        end
    end

    % dzdtを実部と虚部に分けて返す
    dydt = [real(dzdt); imag(dzdt)];
end

