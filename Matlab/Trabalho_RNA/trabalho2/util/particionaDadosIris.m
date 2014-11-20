%Particiona os dados de acordo com o valor de p[0-1]


function [xt yt xd yd] = particionaDadosIris(x,y,p)    

%Separando amostras para teste e treinamento
    P = p;
    qtd = round(P * 50 );
    indexes = [1:qtd   (50 : (qtd+50))   (100 : (qtd + 100))];

    xt = x(indexes,:);
    yt = y(indexes,:);
    
    x(indexes,:) = [];
    y(indexes,:) = [];
    
    xd =x;
    yd =y;
end