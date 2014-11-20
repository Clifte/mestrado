
function mostraResultado( x,y, xlabelNames,s)

[ym yn] = size(y);

map = [ 0 0 1
             1 0 0
             0 1  0
             0 1 1
            ]  

if (yn~=1)
    [v l] = max(y');
    inv = (sum(y') > 1) * -100;
    y = l + inv;
end
        
classes = unique(y);

%Verificando número de caracteristicas

[Wsm Wsn] = size(x);
nCh = Wsn;
rnCh = ceil(sqrt(nchoosek(nCh,2)));


%plotando pontos
plIndex=1;
for ch1=1:nCh
          for ch2 = ch1 +1 : nCh
            subplot(rnCh,rnCh,plIndex)
            hold;

            %Plotando classes separadamente
            for c=1:length(classes)
                ind = find( y == classes(c) );
                scatter(x(ind,ch1),x(ind,ch2),s, map(c,:), 'fill');
                legenda(c,:) = sprintf('%d',classes(c));
            end
            
            title([xlabelNames(ch1,:)  ' vs '  xlabelNames(ch2,:)]);
            legend(legenda);
            xlabel(xlabelNames(ch1,:));
            ylabel(xlabelNames(ch2,:));
            
            hold;
            plIndex = plIndex + 1;  
          end
    end
    
end
