function [net] = criaRede(xn,yn,hidenLayers)
    %Construindo rede

    %Criando pesos de entrada
    Wlista = java.util.LinkedList;
    li = Wlista.listIterator;

    %numero de neurônios de entrada
    n = hidenLayers(1);
    wl = rand(xn,n);
    li.add(wl);


    %Adicionando neurônios da camada Oculta
    for i=2 : (length(hidenLayers))
        wl = rand(hidenLayers(i-1),hidenLayers(i));
        li.add(wl);
    end

    wl = rand(hidenLayers(end),yn);
    li.add(wl);
    
    net = Wlista;
end