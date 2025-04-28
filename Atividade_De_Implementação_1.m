% Definição dos vetores de coordenadas X e Y
x_vals = [2, 2, 0, -3, -2, -1, 0, 0, 2];
y_vals = [0, 1, 3, 1, 0, -2, 0, -2, 2];

% Inicialização dos vetores
r_values = zeros(1, length(x_vals));
theta_values = zeros(1, length(y_vals));

% Cálculo do raio para cada ponto (x, y)
for idx = 1:length(x_vals)
    r_values(idx) = sqrt(x_vals(idx)^2 + y_vals(idx)^2);
end

% Cálculo do ângulo correspondente para cada ponto
for idx = 1:length(x_vals)
    if x_vals(idx) < 0
        if y_vals(idx) > 0
            theta_values(idx) = atand(y_vals(idx) / x_vals(idx)) + 180;
        elseif y_vals(idx) < 0
            theta_values(idx) = atand(y_vals(idx) / x_vals(idx)) - 180;
        else
            theta_values(idx) = 180;
        end
    elseif x_vals(idx) == 0
        if y_vals(idx) > 0
            theta_values(idx) = 90;
        elseif y_vals(idx) < 0
            theta_values(idx) = -90;
        else
            theta_values(idx) = 0;
        end
    else
        theta_values(idx) = atand(y_vals(idx) / x_vals(idx));
    end
end

% Exibição dos resultados
for idx = 1:length(x_vals)
    fprintf('Coordenadas: X = %d, Y = %d\nRaio: %.3f\nÂngulo: %.1f°\n\n', ...
            x_vals(idx), y_vals(idx), r_values(idx), theta_values(idx));
end