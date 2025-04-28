function raiz_babilonica()
    % Definição dos valores de entrada
    valores_a = [0, 2, 10, -4];
    epsilon = 1e-4; % Critério de parada

    % Loop para testar cada valor do vetor
    for a = valores_a
        [raiz, iteracoes] = metodo_babilonico(a, epsilon);

        % Exibir resultado
        fprintf('Raiz aproximada de %d: %s\n', a, num2str(raiz));

        % Plotar gráfico de convergência
        figure;
        plot(1:length(iteracoes), iteracoes, '-o', 'LineWidth', 1.5);
        title(sprintf('Convergência para a = %d', a));
        xlabel('Iteração');
        ylabel('Aproximação de x');
        grid on;
    end
end

function [x, historico] = metodo_babilonico(a, epsilon)
    if a < 0
        x = sqrt(abs(a)) * 1i; % Retorna número imaginário
        historico = x;
        return;
    elseif a == 0
        x = 0; % Caso especial para raiz de zero
        historico = x;
        return;
    end

    x = a; % Chute inicial
    historico = x; % Guardar valores para análise de convergência

    while true
        x_novo = (x + a / x) / 2;
        erro = abs((x_novo - x) / x_novo);
        historico(end + 1) = x_novo; % Armazena a nova aproximação

        if erro <= epsilon
            break;
        end

        x = x_novo;
    end
end