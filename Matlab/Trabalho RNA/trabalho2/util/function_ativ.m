function [ y , dy] = function_ativ(x,func)

    switch func
        case 'step'
            y = x > 0;
            dy = 1;
        case 'tangh'
            y = (1 - exp( - x )) ./ (1 + exp( - x ));
            dy = 0.5 .* (1 - y.^2);           
        case 'logistica'
            y = 1 ./ (1 + exp( - x ));
            dy = y .* (1 - y);
        case 'linear'
            y = x;
            dy = 1;
end

