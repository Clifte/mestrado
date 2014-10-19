clc; clear all; close all;
%% Par�metros
%1-setosa
%2-versicolor
%3-virg�nica

%modo 
%. 
%     Escolha 1 para classificar entre setosa e outras
%     Escolha 2 para classificar entre versicolor e outras
%     Escolha 3 para classificar entre virg�nica e outras
%     Escolha 4 para classificar as 3 entre si

modo = 4;
path = '..\database\iris\bezdekIris.data';
 xLabelNames = ['bias'; 'sLen'; 'sWid'; 'pLen'; 'pWid'];
    
%%
t0 = cputime;
%Carregando dados do disco
[x, y] = carregaDados(modo,path);
[m n] = size(x);


%Normalizando e adicionado o bias ao X.
mx = mean(x);
sx = std(x);
nx = (x - repmat(mx,m,1)) ./ repmat(sx,m,1);
nx = [ -1 * ones(m,1) nx]; 


figure('name','Dados de entrada');
mostraResultado( nx,y,xLabelNames,50,'Dados de entrada ');
set(gca,'FontSize',15,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',15,'fontWeight','bold');


%Separando amostras para teste
P = 0.2;
qtd = round(P * m / 3 );
indexes = [1:qtd   (50 : (qtd+50))   (100 : (qtd + 100))];


nxt = nx(indexes,:);
nyt = y(indexes,:);

nx(indexes,:) = []; 
y(indexes,:) = [];

%Treinando a Rede
[W err] = mlpTreina(nx , y, 0.01,2000);


%Plotando o Erro
figure('name','Erro');
plot(err(:,1:3))


%Avaliando o erro para os pr�prios dados de treinamento
y = mlpAvalia(nxt , W)';

figure('name','Regi�o de Decis�o e Resultado');
mostraRegiaoDecisao(W,-1,10,-3:0.1:3)
mostraResultado( nxt,y,xLabelNames,55,'Resultado ');

acuracia = sum (y == nyt)  / (length(y))

TTotal = cputime - t0

