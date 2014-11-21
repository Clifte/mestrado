function res = avaliaSOM(w,labels,x)
  [m n] = size(x);

  res = zeros(1,m);
  
  for i = 1:m
       
        % Obter o primeiro padr�o.
        xii = x(i, :);
        
        % Calculando ativa��o da rede para o padr�o xii
        diffs = bsxfun(@minus, xii, w);
        distXii = sqrt(sum(diffs.^2, 2));
        
        % Verifica��o do �ndice do neur�nio vencedor.
        [v vencedor] = min(distXii);
        res(i) = labels(vencedor);
  end

end