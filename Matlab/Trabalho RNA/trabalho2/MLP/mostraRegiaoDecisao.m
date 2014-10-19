%%
% W - Coluna neurônios de saída
%        Linha características


%%
function mostraRegiaoDecisao(W,s ,intervalo)

if(nargin<4)
    intervalo = -1.5:0.05:1.5;
end

%Criando X
[x,y] = meshgrid(intervalo);

n = size(x);
n = n(1)*n(2);

x1 = reshape(x,1,n);
x2 = reshape(y,1,n);

x = [ x1;  x2]';

%Mapa de cores
map = [ 0 0 1
             1 0 0
             0 1  0
             0 1 1
            ] ;

%Verificando número de caracteristicas
[Wsm Wsn] = size(W);
nCh = Wsm;
rnCh = ceil(sqrt(nchoosek(nCh,2)));

%plotando pontos
plIndex=1;
for ch1=1:nCh
          for ch2 = ch1  +1: nCh
              
            %Extraindo característica selecionada
            Wl = [W(ch1,:)  ;  W(ch2,:)];

            y =   x * Wl;
            [v saida ] = max(y');
            
            %Abrindo para plotagem
            subplot(rnCh,rnCh,plIndex)
            hold('on');
   
            %Plotando classes separadamente
            for c=1:4
                ind = find( saida == c );
                scatter(x(ind,1),x(ind,2),s, map(c,:),'d', 'fill');
                legenda(c,:) = sprintf('%d',c);
            end

            hold('off');
            plIndex = plIndex + 1;  
          end
end
end

