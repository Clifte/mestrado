function [ x , y ] = carregaDados(modo,path)

    %Carregando dados
    x = csvread(path);


    [m n] = size(x);


    %Ajustando sa�da desejada

    
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