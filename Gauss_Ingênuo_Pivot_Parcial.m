function x = gaussPivotParcial(A, b)
    [n, m] = size(A);

    % Verificação se A é uma matriz quadrada
    if n ~= m
        error('A matriz A deve ser quadrada.');
    end

    % Verificação de singularidade
    if det(A) == 0
        error('A matriz A é singular (determinante zero).');
    end

    % Construção da matriz aumentada
    Ab = [A b];

    fprintf('\n=== INÍCIO DA ELIMINAÇÃO DE GAUSS COM PIVOTAMENTO PARCIAL ===\n');

    % Fase de Eliminação com Pivotamento
    for k = 1:n-1
        fprintf('\nEtapa k = %d:\n', k);

        % Pivotamento parcial
        ipr = k;
        maior = abs(Ab(k, k));
        for i = k+1:n
            if abs(Ab(i, k)) > maior
                maior = abs(Ab(i, k));
                ipr = i;
            end
        end

        % Trocar linha k com linha ipr, se necessário
        if ipr ~= k
            fprintf(' Pivotamento: trocando linha %d com linha %d\n', k, ipr);
            for j = 1:n+1
                temp = Ab(k, j);
                Ab(k, j) = Ab(ipr, j);
                Ab(ipr, j) = temp;
            end
        end

        % Eliminação
        for i = k+1:n
            fator = Ab(i, k) / Ab(k, k);
            fprintf(' Linha %d <- Linha %d - %.4f * Linha %d\n', i, i, fator, k);
            for j = k:n+1
                Ab(i, j) = Ab(i, j) - fator * Ab(k, j);
            end
        end

        % Mostrar matriz aumentada após cada etapa
        disp('Matriz aumentada [A | b] após esta etapa:');
        disp(Ab);
    end

    fprintf('\n=== FIM DA ELIMINAÇÃO | INÍCIO DA SUBSTITUIÇÃO RETROATIVA ===\n');

    % Substituição retroativa
    x = zeros(n, 1);

    for i = n:-1:1
        soma = Ab(i, end);
        fprintf('\nCalculando x(%d):\n', i);

        % Mostrar os termos da equação
        termos = sprintf('x(%d) = (%.4f', i, soma);

        for j = i+1:n
            mult = Ab(i, j) * x(j);
            soma = soma - mult;
            fprintf(' Subtrai %.4f * %.4f = %.4f\n', Ab(i, j), x(j), mult);
            termos = [termos, sprintf(' - %.4f*%.4f', Ab(i, j), x(j))];
        end

        x(i) = soma / Ab(i, i);
        termos = [termos, sprintf(') / %.4f = %.4f\n', Ab(i, i), x(i))];
        fprintf('%s', termos);
    end

    fprintf('\n=== FIM DA SUBSTITUIÇÃO RETROATIVA ===\n');
    disp('Solução final do sistema:');
    disp(x);
end

% Matriz A
A = [2, -6, -1;
    -3, -1, 7;
    -8, 1, -2];

% Vetor B
b = [-38; -34; -20];

x = gaussPivotParcial(A, b);