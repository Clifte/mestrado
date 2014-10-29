%% Parâmetros
%1-setosa
%2-versicolor
%3-virgínica

%modo 
%. 
%     Escolha [1-N] para uma classe entre outras
%     Escolha N+1 para todas entre si
%%
function [ x , y ] = carregaDados(modo,path,N)

    %Carregando dados
    x = csvread(path);

    [m n] = size(x);


    %Ajustando saída desejada
    if(modo>=1 & modo<=(N))
        y = zeros(m,1);
        y(:,1) = x(:,end)==modo;
    else
        y = zeros(m,N);
	for i=1:N
	   y(:,i) = x(:,end)==i;
	end
    end

    %apagando última coluna com as labels
    x(:,end) = [];
end
