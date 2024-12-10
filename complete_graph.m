function G = complete_graph(n)
    A = ones(n) - eye(n);
    G = graph(A);
end

