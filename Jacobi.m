function [x, k, Erx, msg] = jacobi(A, b, tol, N, x0)
    n = length(b);
    x_old = x0;
    x = zeros(n, 1);
    C = zeros(n);
    d = zeros(n, 1);

    % Verifica se A é diagonal dominante
    for i = 1:n
        soma = sum(abs(A(i, :))) - abs(A(i, i));
        if abs(A(i, i)) <= soma
            msg = 'Erro: A matriz não é diagonal dominante. Método pode não convergir.';
            x = []; k = 0; Erx = inf;
            return;
        end
    end

    % Matriz C e vetor d
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

    fprintf('Iter\t\t');
    for i = 1:n
        fprintf('x%d\t\t', i);
    end
    fprintf('Erro(%%)\n');
    fprintf('---------------------------------------------------\n');

    while k < N && Erx > tol
        x = C * x_old + d;

        % Erro percentual com norma 2
        Erx = norm(x - x_old) / (norm(x + eps)) * 100;

        fprintf('%d\t\t', k + 1);
        fprintf('%.6f\t', x);
        fprintf('%.6f\n', Erx);

        x_old = x;
        k = k + 1;
    end

    if Erx <= tol
        msg = 'Convergência atingida com sucesso!';
    else
        msg = 'Erro: número máximo de iterações atingido sem convergência.';
    end
end


A = [10, 2, -1;
     -3, -6, 2;
     1, 1, 5];

b = [27; -61.5; -21.5];
x0 = [0; 0; 0];
tol = 0.05;
N = 100;

[x, k, Erx, msg] = jacobi(A, b, tol, N, x0);

disp('Solução final:');
disp(x);
disp(['Iterações: ', num2str(k)]);
disp(['Erro final: ', num2str(Erx), '%']);
disp(['Mensagem: ', msg]);
