function [x, k, Erx, msg] = gauss_seidel(A, b, tol, N, x0)
    n = length(b);
    x = x0;
    x_old = x0;
    Erx = inf;
    k = 0;

    % ---------- Verificação do critério de Sassenfeld ----------
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
        msg = 'Erro: Critério de Sassenfeld não satisfeito. Método pode não convergir.';
        x = []; k = 0; Erx = inf;
        return;
    end

    % ---------- Iterações de Gauss-Seidel ----------
    fprintf('Iteração\t x1\t\t x2\t\t x3\t\t Erro(%%)\n');
    fprintf('---------------------------------------------------------\n');

    while k < N && Erx > tol
        for i = 1:n
            soma1 = 0;
            for j = 1:i-1
                soma1 = soma1 + A(i,j) * x(j);
            end
            soma2 = 0;
            for j = i+1:n
                soma2 = soma2 + A(i,j) * x_old(j);
            end
            x(i) = (b(i) - soma1 - soma2) / A(i,i);
        end

        Er = abs((x - x_old) ./ x);
        Er(isnan(Er)) = 0; % tratar divisões por zero
        Erx = max(Er) * 100;

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

[x, k, Erx, msg] = gauss_seidel(A, b, tol, N, x0);

disp('Solução final:');
disp(x);
disp(['Iterações: ', num2str(k)]);
disp(['Erro final: ', num2str(Erx), '%']);
disp(['Mensagem: ', msg]);