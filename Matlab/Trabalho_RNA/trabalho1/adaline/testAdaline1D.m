clc; clear all; close all;

%Criando função adicionada de ruído

[x,y] = meshgrid(-1:0.4:1);
n = size(x);

n = n(1) * n(2);
x1 = reshape(x,1,n)  + ((rand(1,n)*2-1)*2);


%Função y(x) = 3x + 8
y = x1*3 + 8 + ((rand(1,n)*2-1)*2);


%Exibindo amostras
figure;
scatter(x1,y,'b','fill');
title('X vs Y');
xLabel('X');
yLabel('Y');
legend('Amostras');
set(gca,'FontSize',15,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',15,'fontWeight','bold');


[W err] = adaline(x1',y,0.01,15);

figure;
plot(err(:,2),'-*r','linewidth',2);
legend('Erro médio quadrático');
set(gca,'FontSize',15,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',15,'fontWeight','bold');



%Exibindo resultados
mostraArea(W);
scatter(x1,y,'b','fill');
title('X vs Y');
xLabel('X');
yLabel('Y');
legend('Aproximação','Amostras');
set(gca,'FontSize',15,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',15,'fontWeight','bold');


