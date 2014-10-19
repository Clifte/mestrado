
%%Treina uma rede neural MLP com apenas uma camanda
%Retorna os pesos e o Erro de cada época
function  [Ws err] = perceptron(x,d,n,maxEpoca)

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
            
            y = y > 0;
            
            e = d(i,:) - y';
            
            if( sum(e) ~=0 ) 
                cont = cont + 1;
            end

            dW = e' * xi * n;      
            Ws = Ws + dW;
        end
        
        em = mean (em.^2);

        cont = (cont/nAmostras);
        %err = [err cont];
        err(epc,:) = [cont em ];
        
    if cont==0
        break
    end

    end

end    
 %%
