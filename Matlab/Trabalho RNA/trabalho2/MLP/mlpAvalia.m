%{
Sa�da (0) � a entrada da rede
Sa�da (Size - 1) � a sa�da da rede

%}
function [yj saidas] = mlpAvalia(xii,net)    
  
    saidas = java.util.LinkedList;
    li = saidas.listIterator;
    li.add(xii);
    
    for j=0 : (net.size()-1)
        %Pegando sa�da
        xj = saidas.get(j);
        
        %Pegando pesos da camada J
        wl = net.get(j);
        yj  = tanh(xj' * wl);
        li.add(yj);
    end

end