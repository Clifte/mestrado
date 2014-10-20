%% 
% Backpropagation



function net = mlpCorrige(net,n,xii,yii,saidas);

   %Calculado erro para a camada de saida
    ol = saidas.get(saidas.size()-1);
    E = ol' - yii;
    dk = sech(ol')  .* sech(ol') .* E;
    
    
    wl = net.get(net.size()-1);
    ol = saidas.get(saidas.size()-2);
    
    [wm wn] = size(wl);
    
    dk = repmat(dk,[ wm 1])   ;
    ol = repmat(ol,[ 1 wn ]) ;
   
    
    %Corrigindo erro da camada
    wl = wl - ( n * dk) .* ol ;
    
    dhAnt = dk;
    for n=(net.size()-2):0
        wl = net.get(n);
        ol = saidas.get(n);
        
        [wm wn] = size(wl);
        
        s = sum( (wl*dk)' );
        
        dk = sech(ol')  .* sech(ol')  * s';
        %wl = wl - ( n * dk) .* ol ;
        dhAnt = dk;
    end
end

