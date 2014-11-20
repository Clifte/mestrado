clc; clear all; close all;
%% Parâmetros
%1-setosa
%2-versicolor
%3-virgínica

%modo 
%. 
%     Escolha 1 para classificar entre setosa e outras
%     Escolha 2 para classificar entre versicolor e outras
%     Escolha 3 para classificar entre virgínica e outras
%     Escolha 4 para classificar as 3 entre si

modo = 2;
path = '..\database\iris\bezdekIris.data';
 xLabelNames = ['bias'; 'sLen'; 'sWid'; 'pLen'; 'pWid'];
 nRep = 4;
%%
t0 = cputime;
%Carregando dados do disco
[x, yS] = carregaDados(modo,path);
[m n] = size(x);
[ym yn] = size(yS);

%Normalizando e adicionado o bias ao X.
mx = mean(x);
sx = std(x);
nx = (x - repmat(mx,m,1)) ./ repmat(sx,m,1);
nxS = [ -1 * ones(m,1) nx]; 


figure('name','Dados de entrada');
mostraResultado( nxS,yS,xLabelNames,50,'Dados de entrada ');
set(gca,'FontSize',15,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',15,'fontWeight','bold');


%Treinando a Rede
for j=1:nRep

    %Permuta os dados sem desagrupa-los
    indP = [randPerm(50) randPerm(50)+50 randPerm(50)+100];
    nx = nxS(indP,:);
    y = yS(indP,:);
    
    %Separando amostras para teste e treinamento
    P = 0.5;
    qtd = round(P * m / 3 );
    indexes = [1:qtd   (50 : (qtd+50))   (100 : (qtd + 100))];

    nxt = nx(indexes,:);
    nyt = y(indexes,:);

    nx(indexes,:) = []; 
    y(indexes,:) = [];

    [W err] = mlpTreina(nx , y, 0.01,500);
     %Avaliando o erro para os próprios dados de treinamento
    yc = mlpAvalia(nxt , W)';
    
    if(yn==3)
        acuracia =  [ 1 1 1] * (yc==nyt)'; %Esperado que sempre seja 3
        acuracia = sum(acuracia == 3) / length(yc);
        
         Ta(j,:) = acuracia;
    else
        acuracia = sum (yc == nyt)  / (length(yc));
        Ta(j,:) = acuracia;
    end
end


m100 = mean(Ta)
m50 = mean(Ta(1:nRep/2))
m25 = mean(Ta(1:nRep/4))

d100= std(Ta)
d50 = std(Ta(1:nRep/2))
d25 = std(Ta(1:nRep/4))


%Plotando o Erro
figure('name','Erro');

plot(  err(:,1:end-1)   , '-*','linewidth',2  );
set(gca,'FontSize',15,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',15,'fontWeight','bold');


figure('name','Região de Decisão e Resultado');
mostraRegiaoDecisao(W,-1,10, -2:0.1:3.5 )
mostraResultado( nxt,yc, xLabelNames,55,'Resultado ');

TTotal = cputime - t0


