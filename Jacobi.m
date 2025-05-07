function [x, k, Erx, msg] = jacobi(A, b, tol, N, x0)
    n = length(b);
    x_old = x0;
    x = x0;
    C = zeros(n);
    d = zeros(n, 1);
    
    % Verifica se a matriz é diagonal dominante
    for i = 1:n
        soma = sum(abs(A(i, :))) - abs(A(i, i));
        if abs(A(i, i)) <= soma
            msg = 'Erro: A matriz não é diagonal dominante. Método pode não convergir.';
            x = []; k = 0; Erx = inf;
            return;
        end
    end

    % Construção das matrizes C e d
    for i = 1:n
        for j = 1:n
            if i ~= j
                C(i, j) = -A(i, j) / A(i, i);
            end
        end
        d(i) = b(i) / A(i, i);
    end

    Erx = inf;
    k = 0;

    fprintf('Iter\t\t x1\t\t x2\t\t x3\t\t Erro(%%)\n');
    fprintf('-----------------------------------------------------------\n');

    while k < N && Erx > tol
        x = C * x_old + d;

        Er = abs((x - x_old) ./ x);
        Er(isnan(Er)) = 0;  % evitar divisão por zero
        Erx = max(Er) * 100;

        % Exibe os resultados da iteração
        fprintf('%d\t\t %.6f\t %.6f\t %.6f\t %.6f\n', k+1, x(1), x(2), x(3), Erx);

        if Erx < tol
            msg = 'Convergência atingida com sucesso!';
            return;
        end

        x_old = x;
        k = k + 1;
    end

    if k == N
        msg = 'Erro: número máximo de iterações atingido sem convergência.';
    else
        msg = 'Convergência atingida com sucesso!';
    end
end

A = [10, 3, -2;
     2, 8, -1;
     1, 1, 5];

b = [57; 20; -4];
x0 = [0; 0; 0];
tol = 0.0005;
N = 100;

[x, k, Erx, msg] = jacobi(A, b, tol, N, x0);

disp('Solução final:');
disp(x);
disp(['Iterações: ', num2str(k)]);
disp(['Erro final: ', num2str(Erx), '%']);
disp(['Mensagem: ', msg]);
