
function mostraResultado( x,y, xlabelNames,s,titulo)
if(nargin<5)
    titulo=' ';
end

if(nargin<6)
    salvar=0;
end

[ym yn] = size(y);

map = [ 0 0 1
             1 0 0
             0 1  0
             0 1 1
            ]  

if (yn~=1)
    [v l] = max(y');
    ind = find( sum(y') > 1 );
    y = l;
    y(ind) = yn+1;
end
        

%Verificando número de caracteristicas

[Wsm Wsn] = size(x);
nCh = Wsn;
rnCh = ceil(sqrt(nchoosek(nCh,2)));


%plotando pontos
plIndex=1;
for ch1=1:nCh
          for ch2 = ch1 +1 : nCh
            h(plIndex) = subplot(rnCh,rnCh,plIndex);
            hold;

            %Plotando classes separadamente
            for c=1:(yn+1)
                ind = find( y == c );;
                scatter(x(ind,ch1),x(ind,ch2),s, map(c,:), 'fill');
                legenda(c,:) = sprintf('%d',c);
            end
            
            title([titulo xlabelNames(ch1,:)  ' vs '  xlabelNames(ch2,:)]);
            legend(legenda);
            xlabel(xlabelNames(ch1,:));
            ylabel(xlabelNames(ch2,:));
            
            hold;
            plIndex = plIndex + 1;  
          end
end


plIndex = plIndex -1;

if(salvar==1)

    for i = plIndex:-1:1
        %Pegando subplots

        hfig = figure;
        hax_new = copyobj( h(i), hfig);
        set(hax_new, 'Position', get(0, 'DefaultAxesPosition'));
        set(gca,'FontSize',15,'fontWeight','bold');
        set(findall(gcf,'type','text'),'FontSize',15,'fontWeight','bold');  

        print(gcf, '-depsc', get(get(h(i),'title'),'string'));
        close;
    end


end