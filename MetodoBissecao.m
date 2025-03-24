% Método da Bissecção para encontrar a raiz de f(x) no intervalo [a, b]
function r = bisseccao(f, a, b, e, N)
    % f  - Função a ser analisada
    % a, b - Limites do intervalo
    % e - Tolerância de erro
    % N - Número máximo de iterações

    % Inicializar variáveis
    fa = f(a);
    fb = f(b);
    
    % Verificar se há mudança de sinal no intervalo
    if fa * fb > 0
        error('Erro: Não há mudança de sinal no intervalo fornecido. Algoritmo encerrado.');
    end

    % Inicializar contagem de iterações
    k = 1;
    r_antigo = a;  % Para calcular erro relativo
    erro_relativo = Inf;  % Inicializar como infinito

    fprintf('Iteração\t a\t\t f(a)\t\t b\t\t f(b)\t\t r\t\t f(r)\t\t Erro Relativo\t Intervalo\n');
    fprintf('-------------------------------------------------------------------------------------------------\n');

    while k <= N
        % Calcular ponto médio
        r = (a + b) / 2;
        fr = f(r);
        intervalo = abs(b - a);
        
        % Calcular erro relativo (primeira iteração não considerada)
        if k > 1
            erro_relativo = abs((r - r_antigo) / r);
        end

        % Exibir estado atual da iteração
        fprintf('%d\t\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\n', ...
            k, a, fa, b, fb, r, fr, erro_relativo, intervalo);

        % Caso: erro relativo seja menor que a tolerância ou intervalo seja menor que a tolerância de erro
        if erro_relativo < e || intervalo < e
            fprintf('Convergência atingida: Raiz aproximada r = %.6f após %d iterações.\n', r, k);
            return;
        end

        % Atualizar os limites do intervalo
        if fa * fr < 0
            b = r;
            fb = fr;
        else
            a = r;
            fa = fr;
        end
        
        % Atualizar r_antigo e incrementar a iteração
        r_antigo = r;
        k = k + 1;
    end

    % Caso o número máximo de iterações seja atingido sem convergência
    fprintf('Número máximo de iterações atingido. Raiz aproximada r = %.6f\n', r);
end
