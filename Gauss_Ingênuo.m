function x = gaussIngenuo(A, b)
    [n, m] = size(A);
    
    % Verificação da matriz
    if n ~= m
        error('A matriz A deve ser quadrada');
    end
    if det(A) == 0
        error('A matriz A é singular (determinante zero).');
    end

    fprintf('\n=== INÍCIO DA ELIMINAÇÃO DE GAUSS ===\n');
    
    % Etapa de Eliminação
    for k = 1:n-1
        fprintf('\nEtapa k = %d:\n', k);
        
        for i = k+1:n
            fator = A(i, k) / A(k, k);
            fprintf(' Linha %d <- Linha %d - %.4f * Linha %d\n', i, i, fator, k);
            
            for j = k:n
                A(i, j) = A(i, j) - fator * A(k, j);
            end
            b(i) = b(i) - fator * b(k);
        end
        
        % Mostrar o sistema após cada etapa k
        disp('Matriz A:');
        disp(A);
        disp('Vetor b:');
        disp(b);
    end

    fprintf('\n=== FIM DA ELIMINAÇÃO | INÍCIO DA SUBSTITUIÇÃO RETROATIVA ===\n');
    
    % Substituição retroativa
    x = zeros(n, 1);
    x(n) = b(n) / A(n, n);
    fprintf('\nx(%d) = %.4f / %.4f = %.4f\n', n, b(n), A(n, n), x(n));
    
    for i = n-1:-1:1
        soma = b(i);
        fprintf('\nCalculando x(%d):\n', i);

        for j = i+1:n
            soma = soma - A(i, j) * x(j);
            fprintf(' Subtrai %.4f * %.4f -> soma = %.4f\n', A(i, j), x(j), soma);
        end
        
        x(i) = soma / A(i, i);
        fprintf(' x(%d) = %.4f / %.4f = %.4f\n', i, soma, A(i, i), x(i));
    end

    fprintf('\n=== FIM DA SUBSTITUIÇÃO RETROATIVA ===\n');
    disp('Solução final do sistema:');
    disp(x);
end

% Matriz A
A = [10, 2, -1;
     -3, -5, 2;
      1, 1, 6];

% Vetor B
b = [27; -61.5; -21.5];

x = gaussIngenuo(A, b);