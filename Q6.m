clc; clear; close all;

x = 0.5;                      
valor_real = exp(x);          
termo = 1;                    
soma = termo;                 
n = 0;  
criterio_erro = 0.05; 
erro_aprox = inf;                     

while abs(erro_aprox) > criterio_erro
    n = n + 1;
    termo = (x^n) / factorial(n); 
    soma = soma + termo;           
    
    erro_real = ((valor_real - soma) / valor_real) * 100; 
    if n > 1
        erro_aprox = abs((termo / soma) * 100);
    end
end

fprintf('Número de termos utilizados: %d\n', n + 1);
fprintf('Aproximação obtida: %.6f\n', soma);
fprintf('Valor real: %.6f\n', valor_real);
fprintf('Erro verdadeiro: %.6f%%\n', abs(erro_real));
fprintf('Erro relativo percentual aproximado: %.6f%%\n', erro_aprox);
