function [x, invA] = gaussJordanComInversa(A, b)
    n = length(b);

    % Construção da matriz aumentada [A | I | b]
    Ab = [A eye(n) b];

    fprintf("=== VALORES INICIAIS ===\n");
    disp(Ab);

    fprintf("\n=== ELIMINAÇÃO DE GAUSS COM PIVOTAMENTO PARCIAL ===\n");

    % Eliminação de Gauss (abaixo da diagonal)
    for k = 1:n-1
        % Pivotamento parcial
        maior = abs(Ab(k, k));
        idx = k;
        for i = k+1:n
            if abs(Ab(i, k)) > maior
                maior = abs(Ab(i, k));
                idx = i;
            end
        end

        if idx ~= k
            fprintf("Pivotamento: trocando linha %d com linha %d\n", k, idx);
            temp = Ab(k, 1:2*n+1);
            Ab(k, 1:2*n+1) = Ab(idx, 1:2*n+1);
            Ab(idx, 1:2*n+1) = temp;
        end

        for i = k+1:n
            m = Ab(i, k) / Ab(k, k);
            for j = k:2*n+1
                Ab(i, j) = Ab(i, j) - m * Ab(k, j);
            end
        end
        fprintf("Após eliminação abaixo da diagonal (k = %d):\n", k);
        disp(Ab);
    end

    fprintf("\n=== ELIMINAÇÃO DE GAUSS-JORDAN (NORMALIZAÇÃO E ZERANDO FORA DA DIAGONAL) ===\n");

    % Eliminação completa (Gauss-Jordan)
    for k = 1:n
        % Normalização da linha k
        pivo = Ab(k, k);
        for j = 1:2*n+1
            Ab(k, j) = Ab(k, j) / pivo;
        end
        fprintf("Após normalização da linha %d:\n", k);
        disp(Ab);

        % Eliminação dos outros elementos da coluna k
        for i = 1:n
            if i ~= k
                fator = Ab(i, k);
                for j = 1:2*n+1
                    Ab(i, j) = Ab(i, j) - fator * Ab(k, j);
                end
            end
        end
        fprintf("Após eliminação completa da coluna %d:\n", k);
        disp(Ab);
    end

    % Extração dos resultados
    % Solução x (última coluna)
    x = zeros(n, 1);
    for i = 1:n
        x(i) = Ab(i, 2*n+1);
    end

    % Matriz inversa (colunas n+1 até 2n)
    invA = zeros(n);
    for i = 1:n
        for j = 1:n
            invA(i, j) = Ab(i, n+j);
        end
    end

    % Exibição dos resultados finais
    fprintf("\n=== RESULTADO FINAL ===\n");
    fprintf("Solução do sistema (x):\n");
    disp(x);

    fprintf("Matriz inversa de A:\n");
    disp(invA);
end

% Matriz A e o vetor b
A = [-0.04  0.04  0.12;
      0.56 -1.56  0.32;
     -0.24  1.24 -0.28];

b = [3; 1; 0];

[x, invA] = gaussJordanComInversa(A, b);