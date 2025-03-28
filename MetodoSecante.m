function raiz = metodo_secante(f, x0, x1, tol, N)
    % f  -> Função alvo
    % x0 -> Primeiro ponto inicial
    % x1 -> Segundo ponto inicial
    % tol -> Tolerância do erro
    % N  -> Número máximo de iterações

    iter = 0;
    ea = inf; % Inicializa erro como infinito

    % Exibir cabeçalho
    fprintf('Iter\tXr\t\tf(Xr)\t\tEa(%%)\n');
    fprintf('-------------------------------------------------\n');

    % Exibir primeira iteração antes de calcular a próxima aproximação
    fprintf('%d\t%.6f\t%.6f\t--\n', iter, x0, f(x0));

    while iter < N
        % Evita divisão por zero
        if (f(x1) - f(x0)) == 0
            fprintf('Erro: Divisão por zero, método falhou.\n');
            raiz = NaN;
            return;
        end

        % Aplicação da fórmula da Secante
        x_new = x1 - (f(x1) * (x1 - x0)) / (f(x1) - f(x0));

        % Calcula erro relativo percentual
        if x_new ~= 0
            ea = abs((x_new - x1) / x_new) * 100;
        end

        iter = iter + 1;

        % Exibir os valores da iteração
        fprintf('%d\t%.6f\t%.6f\t%.6f\n', iter, x1, f(x1), ea);

        % Critério de parada
        if ea < tol
            fprintf('\nA raiz encontrada é: %.6f após %d iterações.\n', x_new, iter);
            raiz = x_new;
            return;
        end

        % Atualiza os valores para a próxima iteração
        x0 = x1;
        x1 = x_new;
    end

    % Caso o método não converja
    fprintf('\nMétodo falhou em %d iterações.\n', N);
    raiz = NaN;
end

f = @(x) x.^2 - 3*x + exp(x) - 2; % Função f(x)
x0 = -0.5;     % Primeiro ponto inicial
x1 = -0.75;     % Segundo ponto inicial
tol = 0.0001; % Tolerância do erro
N = 50;      % Número máximo de iterações

raiz = metodo_secante(f, x0, x1, tol, N);
