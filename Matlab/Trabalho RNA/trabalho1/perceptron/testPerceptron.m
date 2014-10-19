clc; clear all; close all;

%% Parâmetros
%Número de amostras geradas
n = 100;
%Número de repetiçoes
nRepeticoes = 10;
%Operação
op =  'AND' ;

%%

[ x  y ] = geraBD(op, n );

%Adicionando bias
x = [ones(n,1) x];


for i=1:nRepeticoes
    [W err] = perceptron(x,y,0.01,100);
    ce(i) = err(end);
end

sprintf('Média e desvio padrão do erro quadrático %0.3f, %0.3f',mean(ce),std(ce))

figure('name','Análise do erro');
plot(err(:,1),'-*r','linewidth',2);hold;
plot(err(:,2),'-*b','linewidth',2);
legend('Erro global','Erro Médio Quadrático');
set(gca,'FontSize',15,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',15,'fontWeight','bold');

figure('name','Dados de treinamento');
mostraResultado(x,y,['bias';' X1 ';' X2 '],50);
set(gca,'FontSize',15,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',15,'fontWeight','bold');

figure('name','Região de Decisão');
mostraRegiaoDecisao(W,1,15, -0.5:0.05:1.5);
mostraResultado(x,y,['bias';' X1 ';' X2 '],60);
set(gca,'FontSize',15,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',15,'fontWeight','bold');

