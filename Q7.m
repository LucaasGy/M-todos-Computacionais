clc; clear; close all;

% Definição da função f(x) e sua derivada simbólica
syms x;
f = -0.1*x^4 - 0.15*x^3 - 0.5*x^2 - 0.25*x + 1.2;

% Derivada exata de f(x)
df = diff(f, x);

% Ponto de avaliação
xi = 0.5;

% Derivada verdadeira
df_true = double(subs(df, x, xi));

% Inicialização dos valores
h_values = logspace(0, -16, 17); % Passos h de 1 até 10^(-16)
df_approx = zeros(size(h_values));
error_true = zeros(size(h_values));

% Cálculo da derivada aproximada e erro
for i = 1:length(h_values)
    h = h_values(i);
    df_approx(i) = (double(subs(f, x, xi + h)) - double(subs(f, x, xi - h))) / (2 * h);
    error_true(i) = abs(df_approx(i) - df_true);
end

fprintf('Tamanho do passo | Diferença Finita | Erro Verdadeiro\n');
fprintf('-----------------------------------------------------\n');
for i = 1:length(h_values)
    fprintf('%1.1e \t\t %1.6f \t\t %1.6e\n', h_values(i), df_approx(i), error_true(i));
end

% Gráfico do erro em função do tamanho passo h
figure;
loglog(h_values, error_true, 'o-', 'LineWidth', 2);
xlabel('Tamanho do passo h');
ylabel('Erro verdadeiro');
title('Erro da diferença centrada');
grid on;
