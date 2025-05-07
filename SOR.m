function [x, k, Erx] = sor(A, b, x0, tol, N, w)
    % Método de Sobre-Relaxação Sucessiva (SOR)
    % Entradas:
    % A - matriz dos coeficientes
    % b - vetor independente
    % x0 - chute inicial
    % tol - tolerância (em porcentagem)
    % N - número máximo de iterações
    % w - fator de relaxação (0 < w <= 2)

    n = length(b);
    x = x0;
    x_old = x0;
    k = 0;
    Erx = inf;

    % Critério de Sassenfeld
    beta = zeros(n,1);
    for i = 1:n
        soma = 0;
        for j = 1:i-1
            soma = soma + abs(A(i,j)) * beta(j);
        end
        for j = i+1:n
            soma = soma + abs(A(i,j));
        end
        beta(i) = soma / abs(A(i,i));
    end

    if max(beta) >= 1
        fprintf('Critério de Sassenfeld NÃO satisfeito (máximo beta = %.4f)\n', max(beta));
    else
        fprintf('Critério de Sassenfeld satisfeito (máximo beta = %.4f)\n', max(beta));
    end

    fprintf('\nIteração\t x1\t\t x2\t\t x3\t\t Erro(%%)\n');

    % Método SOR
    while k < N && Erx > tol
        x_old = x;
        for i = 1:n
            soma1 = A(i,1:i-1) * x(1:i-1);
            soma2 = A(i,i+1:n) * x_old(i+1:n);
            x_gs = (b(i) - soma1 - soma2) / A(i,i); % valor de Gauss-Seidel
            x(i) = w * x_gs + (1 - w) * x_old(i);   % valor com ponderação SOR
        end

        Er = abs((x - x_old) ./ x);
        Er(isnan(Er)) = 0;
        Erx = max(Er) * 100;

        fprintf('%d\t\t %.6f\t %.6f\t %.6f\t %.6f\n', k+1, x(1), x(2), x(3), Erx);

        if Erx < tol
            break;
        end
        k = k + 1;
    end
end

A = [10 3 -2; 2 8 -1; 1 1 5];
b = [57; 20; -4];
x0 = [0; 0; 0];
tol = 0.0005;
N = 100;
w = 1.1;  % fator de relaxação

[x, k, Erx] = sor(A, b, x0, tol, N, w);