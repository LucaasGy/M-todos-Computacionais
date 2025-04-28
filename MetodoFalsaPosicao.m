% Método da Falsa Posição para encontrar a raiz de f(x) no intervalo [a, b]
function r = falsa_posicao(f, a, b, e, N)
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
    Tinter = abs(b - a);
    
    % Verificar se o intervalo inicial já atende à tolerância
    if Tinter < e
        % Evitar divisão por zero
        if fb - fa == 0
            error('Erro: Divisão por zero ao calcular nova raiz.');
        end
        
        r = (a * fb - b * fa) / (fb - fa);
        fprintf('Intervalo inicial já atende à tolerância. Raiz aproximada r = %.6f\n', r);
        return;
    end
    
    % Verificar se a raiz está nos extremos
    if abs(fa) < e
        fprintf('Raiz encontrada no extremo: r = %.6f\n', a);
        r = a;
        return;
    elseif abs(fb) < e
        fprintf('Raiz encontrada no extremo: r = %.6f\n', b);
        r = b;
        return;
    end
    
    fprintf('Iteração\t a\t\t f(a)\t\t b\t\t f(b)\t\t r\t\t f(r)\t\t Intervalo\n');
    fprintf('-------------------------------------------------------------------------------------------------\n');
    
    % Inicializar contagem de iterações
    k = 1;
    
    while k <= N
        % Evitar divisão por zero
        if fb - fa == 0
            error('Erro: Divisão por zero ao calcular nova raiz.');
        end
    
        % Calcular ponto de Falsa Posição
        r = (a * fb - b * fa) / (fb - fa);
        fr = f(r);
        
        % Exibir estado atual da iteração
        fprintf('%d\t\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\n', ...
            k, a, fa, b, fb, r, fr, Tinter);
        
        % Verificar critério de parada
        if abs(fr) < e || Tinter < e
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
        
        % Atualizar tamanho do intervalo
        Tinter = abs(b - a);
        
        % Incrementar iteração
        k = k + 1;
    end
    
    % Caso o número máximo de iterações seja atingido sem convergência
    fprintf('Número máximo de iterações atingido. Última aproximação r = %.6f\n', r);
end

f = @(x) x.^3 - 9*x + 3;
a = 0;  % Limite inferior
b = 1;  % Limite superior
e = 0.001;  % Tolerância de erro
N = 20;  % Máximo de iterações

falsa_posicao(f, a, b, e, N);