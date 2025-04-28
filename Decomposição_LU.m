% === MATRIZ A E VETORES ===
A = [2  1 -3;
     -1  3  2;
      3  1 -3];

b2 = [3; 1; 2];

n = size(A, 1); % Tamanho da matriz
L = eye(n);     % Inicializa L como identidade
U = A;          % U começa como cópia de A

fprintf('=== Início da Decomposição LU ===\n');

% Fase de decomposição LU
for j = 1:n-1
    pivo = U(j, j);
    fprintf('\nColuna %d | Pivô = %.4f\n', j, pivo);

    for i = j+1:n
        fator = U(i, j) / pivo;
        fprintf(' Fator L(%d,%d) = %.4f\n', i, j, fator);

        U(i, j:n) = U(i, j:n) - fator * U(j, j:n);
        L(i, j) = fator;

        fprintf(' Linha %d de U atualizada: %s\n', i, mat2str(U(i, :), 4));
    end
end

% Exibe as matrizes L e U
fprintf('\n=== Matriz L ===\n');
disp(L);
fprintf('=== Matriz U ===\n');
disp(U);

% === RESOLVENDO Ly = b2 ===
fprintf('\n=== Resolvendo Ly = b2 ===\n');
y = zeros(n, 1);
for i = 1:n
    y(i) = b2(i) - L(i, 1:i-1) * y(1:i-1);
    fprintf(' y(%d) = %.4f\n', i, y(i));
end

% === RESOLVENDO Ux = y ===
fprintf('\n=== Resolvendo Ux = y ===\n');
x = zeros(n, 1);
for i = n:-1:1
    x(i) = (y(i) - U(i, i+1:n) * x(i+1:n)) / U(i, i);
    fprintf(' x(%d) = %.4f\n', i, x(i));
end

% Exibição da solução final
fprintf('\n=== Solução Final x ===\n');
disp(x);