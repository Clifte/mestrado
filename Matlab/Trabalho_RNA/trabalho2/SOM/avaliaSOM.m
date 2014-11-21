function res = avaliaSOM(w,labels,x)
  [m n] = size(x);

  res = zeros(1,m);
  
  for i = 1:m
       
        % Obter o primeiro padrão.
        xii = x(i, :);
        
        % Calculando ativação da rede para o padrão xii
        diffs = bsxfun(@minus, xii, w);
        distXii = sqrt(sum(diffs.^2, 2));
        
        % Verificação do índice do neurônio vencedor.
        [v vencedor] = min(distXii);
        res(i) = labels(vencedor);
  end

end