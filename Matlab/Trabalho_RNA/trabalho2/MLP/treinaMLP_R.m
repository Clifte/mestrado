%%
%Número de de neurônios da camada de entrada é definida pela quantidade de
%elementos da primeira hidenLayer
%%
function [Wo Wh] =treinaMLP_R(x,y,bias,nh,eta,erro,maxEpoca,f1,f2)

if nargin < 8
    f1 = 'tangh';
end

if nargin < 9
   f2 = f1;
end

global mlpRegressao;
%Xm = Número de amostras
%Xn = Número de características
[xm xn] = size(x);
[ym yn] = size(y);

%Adicionando mais um para o bias
Wo = rand(nh+1,yn);
Wh = rand(xn+1, nh);
errM = zeros(1,yn);


for epc=1:maxEpoca
    errM = zeros(1,yn);
    
    
    grWkj=0; 
    grWji=0;  
    
    for i=1:xm
        xii = [bias  x(i,:)] ;
        yii = y(i,:);


        %Calculando saída da camada oculta
        yhc = xii * Wh;
        [ yhc , dYhc] = function_ativ(yhc,f1);
       
        %Adicionando Bias
        yhc = [bias  yhc];
                
        %Calculando total saída da rede
        yc = yhc * Wo;
        [ yc , dYc] = function_ativ(yc,f2);

        
        %Calculando o erro
        e = yii - yc;
        errM = errM + (e.^2);

        %atualizando pesos da saída
        gYc = dYc .* e;
        dWo = eta * (gYc)' * yhc;

        gYhc = dYhc' .* (Wo(2:end,:) * gYc');
        dWh = eta * gYhc * xii;
        
        
        
        grWkj = grWkj - e.* yc; 
        grWji  = grWji - ( yhc  .*  (e .*Wo(2:end,:) ) )'*xii;
      
      
    end
    
    
    
    
    
    
    
    if(mlpRegressao == true)
         subplot(1,2,1);
         plot(x,y,'.r');
         hold on;
         plot(x, mlpAvalia(x , -1 , Wo , Wh,f1,f2),'.b');
         drawnow;
         hold off;
    end
    errM = errM / xm;
    errMarr(epc,:) = errM;
    
    if(errM<erro)
        break
    else
        subplot(1,2,2);
        semilogy(errMarr);
        xlabel('Época');
        ylabel('log(e)');
        title('Erro médio quadrático');
        drawnow;
    end
end

end