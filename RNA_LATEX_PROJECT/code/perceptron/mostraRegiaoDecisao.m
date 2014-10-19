
function mostraRegiaoDecisao(W,bias,s ,intervalo)

if(nargin<4)
    intervalo = -1.5:0.05:1.5;
end

%Criando X
[x,y] = meshgrid(intervalo);

n = size(x);
n = n(1)*n(2);

x1 = reshape(x,1,n);
x2 = reshape(y,1,n);


x = [ ones(1,n) *bias ;  x1;  x2]';
%Mapa de cores
map = [ 0 0 1
             1 0 0
             0 1  0
             0 1 1
            ]  


%Verificando número de caracteristicas
[Wsm Wsn] = size(W);
nCh = Wsn;
rnCh = ceil(sqrt(nchoosek(nCh,2)));

if (Wsn==2)
    x = x(:,1:2);
end
    
    
%plotando pontos
plIndex=1;
for ch1=1:nCh
          for ch2 = ch1  +1: nCh
              
             if (Wsn > 2)
                 Wl = [W(1)   W(ch1)  W(ch2)]';
             else
                 Wl = [W(ch1)  W(ch2)]';
             end
             
             y =   x * Wl;
            
             [ym yn] = size(y);
            
             y = y > 0;

             if (yn~=1)
                 [v l] = max(y');
                 inv = (sum(y') > 1) * -100;
                 y = l + inv;
            end

            classes = unique(y);
   
            subplot(rnCh,rnCh,plIndex)
            hold;
            
            if (Wsn > 2)
                
                %Plotando classes separadamente
                for c=1:length(classes)
                    ind = find( y == classes(c) );
                    scatter(x(ind,2),x(ind,3),s, map(c,:),'d', 'fill');
                    legenda(c,:) = sprintf('%d',classes(c));
                end

            
            else
                
                 %Plotando classes separadamente
                for c=1:length(classes)
                    ind = find( y == classes(c) );
                    scatter(x(ind,1),x(ind,2),s, map(c,:),'d', 'fill');
                    legenda(c,:) = sprintf('%d',classes(c));
                end

            end
            
            hold;
            plIndex = plIndex + 1;  
          end
end
end

