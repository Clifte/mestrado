%% Parametros
%1-setosa
%2-versicolor
%3-virginica

%modo 
%. 
%     Escolha 1 para classificar entre setosa e outras
%     Escolha 2 para classificar entre versicolor e outras
%     Escolha 3 para classificar entre virginica e outras
%     Escolha 4 para classificar as 3 entre si

function [ x , y ] = carregaDados(modo,path)

    %Carregando dados
    x = csvread(path);

    [m n] = size(x);

    %Ajustando saida desejada

    
    if(modo>=1 & modo<=3)
        y = zeros(m,1);
        y(:,1) = x(:,5)==modo;
    else
        y = zeros(m,3);
        y(:,1) = x(:,5)==1;
        y(:,2) = x(:,5)==2;
        y(:,3) = x(:,5)==3;
    end

    %apagando 5 coluna. 
    x(:,5) = [];
end
