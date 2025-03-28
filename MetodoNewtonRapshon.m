function raiz = newton_raphson(f, df, x0, tol, N)
  % f  -> Função original
  % df -> Derivada de f(x)
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
    if df(xr) == 0
      printf("Erro: Derivada é zero, método falhou.\n");
      raiz = NaN;
      return;
    end
    
    x_new = xr - ( f(xr) / df(xr) ); % Fórmula de Newton-Raphson
    iter = iter + 1;
    
    % Calcula erro relativo percentual
    if x_new != 0
      ea = abs((x_new - xr) / x_new) * 100;
    end
    
    % Exibe os valores na tela
    printf("%d\t%.6f\t%.6f\t%.6f\n", iter, x_new, f(x_new), ea);
    
    % Critério de parada
    if ea < tol
      printf("\nA raiz encontrada é: %.6f após %d iterações.\n", x_new, iter);
      raiz = x_new;
      return;
    end
    
    % Atualiza o valor para a próxima iteração
    xr = x_new;
  end
  
  printf("\nMétodo falhou em %d iterações.\n", N);
  raiz = NaN;
end

f = @(x) x.^2 - 3*x + exp(x) - 2;   % Função f(x)
df = @(x) 2*x - 3 + exp(x);         % Derivada de f(x)
x0 = -0.5;     % Ponto inicial
tol = 0.0001; % Tolerância
N = 50;      % Número máximo de iterações

raiz = newton_raphson(f, df, x0, tol, N);
