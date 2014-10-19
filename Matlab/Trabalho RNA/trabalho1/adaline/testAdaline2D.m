clc; clear all; close all;

%Criando função adicionada de ruído

[x,y] = meshgrid(-1:0.2:1);

n = size(x);
n = n(1) * n(2);

x1 = reshape(x,1,n) + ((rand(1,n)*2-1)*2);

x2 = reshape(y,1,n) + ((rand(1,n)*2-1)*2);

  
% r1 = (rand(50,2)*2 - 1)/5;
% r2 = ceil(rand(50,2)*2 - 1);
% r = r1 + r2;
% x = [x;r]


%função
y = x1*3 + x2*4 + 2 + ((rand(1,n)*2-1)*2);

% w=trainPerceptron(x,y,0.01);
[W err] = adaline([x1',x2'],y,0.01,10000);

figure;
plot(err);



%%plotpc(W(2:3),W(1));
mostraArea(W);
scatter3(x1,x2,y,'b','fill');
%scatter(x(:,1),x(:,2),50,'b','fill');


