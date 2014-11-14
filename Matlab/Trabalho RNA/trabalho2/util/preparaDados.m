function [ xd yd xt yt ] = preparaDados( X, Y, pTeste)
    [m n] =size(X);

    %Embaralhando DataSet
    indicePermut = randperm(m);
    xp = X(indicePermut , :);
    yp = Y(indicePermut , :);

    %Particionando dados
    %Dados de teste
    tp = m * pTeste;
    xt = xp(1:tp,:);
    yt = yp(1:tp,:);

    %Dados de treinamento
    xd = xp((tp+1):end,:);
    yd = yp((tp+1):end,:);

end
