function dydt = model(~, y, alpha, omega, K, A)
    N = length(y) / 2; % ノード数を取得
    z = y(1:N) + 1i * y(N+1:end); % 実部と虚部を複素数に変換

    % 結合項の計算
    coupling = (K / N) * (A * z - z .* sum(A, 2)); % zの結合項を行列演算で計算

    % dz/dtの計算
    dzdt = (alpha + 1i * omega - abs(z).^2) .* z + coupling;

    % 実部と虚部に分けて返す
    dydt = [real(dzdt); imag(dzdt)];
end


