
%%
function  [W err] = adaline(x,d,n,maxEpoca)
    nAmostras = length(x(:,1));
    nEnt = length(x(1,:));
    W = rand(1,nEnt + 1);

    err = [];
    
    for epc=1:maxEpoca
        cont = 0;
        em =[];
        
        for i=1:nAmostras
            xi = [1 x(i,:)];
            y = W * xi';

            %Calculando erro
            e = d(i) - y;
            em(i,:) = e;
            
            
            %Em caso de erro atualizar os pesos
            if(abs(e) >= 0.001) 
                cont = cont + 1;
                dW = xi*e*n;      
                W  = W + dW;
            end

        end
        em = mean (em.^2);
        
        cont = (cont/nAmostras * 100);
        err( epc, : ) = [cont em ];
        
        
        if cont==0
            break
        end
        
    end

end    
 %%
