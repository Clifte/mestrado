function [x y] = geraBD( tipo, n)
    %%
    %Gerando dados de treinamento aleatoriamente
    r1 = (rand(n,2)*2 - 1)/5;                     %Gerando valores na faixa de [-0.2;0.2]
    r2 = round(rand(n,2));                        %Gerando valores valores 0 ou 1
    r = r1 + r2;                                         
    x = r;

    if (strcmp(tipo,'AND'))
        y = round(x(:,1)) & round(x(:,2));

    end

    if (strcmp(tipo,'OR'))
        y = round(x(:,1))  | round(x(:,2));
    end

    if (strcmp(tipo,'NOT'))
      x = r(:,1);
      y = ~round(x(:,1));

    end

end