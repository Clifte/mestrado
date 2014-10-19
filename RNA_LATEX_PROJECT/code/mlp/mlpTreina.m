
%%Treina uma rede neural MLP com apenas uma camanda
%Retorna os pesos e o Erro de cada época
function  [Ws err] = mlpTreina(x,d,n,maxEpoca)

    [nAmostras nEnt] = size(x) ;
    
    Ws = rand( length(d(1,:))  , nEnt);

    err = [];
    
    
    for epc=1:maxEpoca  
        
        cont = 0;
        em = [];
        
        ordem = randperm(nAmostras);
        
        for j=1:nAmostras
            i = ordem(j);
            
            xi =  x(i,:);
            y = Ws * xi';

            em(j,:) = (d(i,:) - y');
            
            y = y > 0.5;
            
            e = d(i,:) - y';
            
            if( sum(e) ~=0 ) 
                cont = cont + 1;
            end

            dW = e' * xi * n;      
            Ws = Ws + dW;
        end
        
        em = mean (em.^2);

        cont = (cont/nAmostras)*100;
        %err = [err cont];
        err(epc,:) = [em cont];
        
    if cont==0
        break
    end

    end

end    
 %%
