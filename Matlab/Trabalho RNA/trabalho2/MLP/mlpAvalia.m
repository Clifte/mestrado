%{
Saída (0) é a entrada da rede
Saída (Size - 1) é a saída da rede

%}
function [yj saidas] = mlpAvalia(xii,net)    
  
    saidas = java.util.LinkedList;
    li = saidas.listIterator;
    li.add(xii);
    
    for j=0 : (net.size()-1)
        %Pegando saída
        xj = saidas.get(j);
        
        %Pegando pesos da camada J
        wl = net.get(j);
        yj  = tanh(xj' * wl);
        li.add(yj);
    end

end