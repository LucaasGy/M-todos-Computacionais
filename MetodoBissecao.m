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

    % Calcular tamanho inicial do intervalo
    intervalo = abs(b - a);
    
    % Verificar se o intervalo inicial já atende à tolerância
    if intervalo < e
        r = (a + b) / 2;
        fprintf('Intervalo inicial já atende à tolerância. Raiz aproximada r = %.6f\n', r);
        return;
    end
    
    fprintf('Iteração\t a\t\t f(a)\t\t b\t\t f(b)\t\t r\t\t f(r)\t\t Intervalo\n');
    fprintf('-------------------------------------------------------------------------------------------------\n');
    
    % Inicializar contagem de iterações
    k = 1;
    
    while k <= N
        % Calcular ponto médio
        r = (a + b) / 2;
        fr = f(r);
        intervalo = abs(b - a);

        % Exibir estado atual da iteração
        fprintf('%d\t\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\n', ...
            k, a, fa, b, fb, r, fr, intervalo);

        % Verificar critério de parada
        if intervalo < e
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

        % Incrementar iteração
        k = k + 1;
    end
    
    % Caso o número máximo de iterações seja atingido sem convergência
    fprintf('Número máximo de iterações atingido. Raiz aproximada r = %.6f\n', r);
end

f = @(x) sin(x) - x.^2;
a = 0.5;  % Limite inferior
b = 1;  % Limite superior
N = 20;   % Máximo de iterações
e = 0.02   % Tolerância de erro

bisseccao(f, a, b, N);
