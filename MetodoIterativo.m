function raiz = iteracao_linear(f, g, x0, tol, N)
  % f  -> Função original
  % g  -> Função de iteração
  % x0 -> Ponto inicial
  % tol -> Tolerância do erro
  % N  -> Número máximo de iterações

  iter = 0;
  xr = x0;
  ea = inf; % Inicializa erro absoluto como infinito
  
  % Exibir cabeçalho
  printf("Iter\tXr\t\tf(Xr)\t\tEa(%%)\n");
  printf("-------------------------------------------------\n");
  
  % Exibir a primeira iteração (x0)
  printf("%d\t%.6f\t%.6f\t-\n", iter, xr, f(xr));
  
  while iter < N
    x_ant = xr;
    xr = g(x_ant); % Calcula próximo valor da raiz
    iter = iter + 1;
    
    % Calcula erro relativo percentual
    if xr != 0
      ea = abs((xr - x_ant) / xr) * 100;
    end
    
    % Exibe os valores na tela
    printf("%d\t%.6f\t%.6f\t%.6f\n", iter, xr, f(xr), ea);
    
    % Critério de parada
    if ea < tol
      printf("\nA raiz encontrada é: %.6f após %d iterações.\n", xr, iter);
      raiz = xr;
      return;
    end
  end
  
  printf("\nMétodo falhou em %d iterações.\n", N);
  raiz = NaN;
end

f = @(x) x.^2 - 3*x + exp(x) - 2; % Função f(x)
g = @(x) (x.^2 + exp(x) - 2) / 3; % Função de iteração g(x)
x0 = -0.5; % Ponto inicial
tol = 0.0001; % Tolerância
N = 50; % Número máximo de iterações

raiz = iteracao_linear(f, g, x0, tol, N);
