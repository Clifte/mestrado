clc; clear all; close all;

%% Par�metros
%N�mero de amostras geradas
n = 100;
%N�mero de repeti�oes
nRepeticoes = 10;
%Opera��o
op =  'AND' ;

%%

[ x  y ] = geraBD(op, n );

%Adicionando bias
x = [ones(n,1) x];


for i=1:nRepeticoes
    [W err] = perceptron(x,y,0.01,100);
    ce(i) = err(end);
end

sprintf('M�dia e desvio padr�o do erro quadr�tico %0.3f, %0.3f',mean(ce),std(ce))

figure('name','An�lise do erro');
plot(err(:,1),'-*r','linewidth',2);hold;
plot(err(:,2),'-*b','linewidth',2);
legend('Erro global','Erro M�dio Quadr�tico');
set(gca,'FontSize',15,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',15,'fontWeight','bold');

figure('name','Dados de treinamento');
mostraResultado(x,y,['bias';' X1 ';' X2 '],50);
set(gca,'FontSize',15,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',15,'fontWeight','bold');

figure('name','Regi�o de Decis�o');
mostraRegiaoDecisao(W,1,15, -0.5:0.05:1.5);
mostraResultado(x,y,['bias';' X1 ';' X2 '],60);
set(gca,'FontSize',15,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',15,'fontWeight','bold');

