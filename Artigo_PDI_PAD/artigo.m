%% limpeza
clc;
clear;
close all;
%%
global AREA_TOP_THRESH;
global AREA_BOT_THRESH;
global BOUND_MAX_PERI_THRESH;

AREA_TOP_THRESH = 2000;
AREA_BOT_THRESH = 100;
BOUND_MAX_PERI_THRESH = 400;
%% leitura da imagem
img = imread('digitos.png');
img = imread('digitosCap2.jpg');
img = imread('digitosCap3.jpg');

%% limiar adaptativo
binary = adaptivethreshold(img,11,0.03,0);
binary = ~binary;
%% 
imshow(img);
hold on;
[chars L N ] = extraiChars(binary);
chars = filtraCaracteres(chars);

features = extrair(chars,binary);

%Ordenando por labels
[v i] =sort(features(:,end));
features = features(i,:);
csvwrite('features.csv',features);


figure;
plot(features)
legend('areaRelativa','aspecto','picoPVertical','picoPHorizontal','maxPVertical','maxPHorizontal','label')

%% Preparando para classificação
acMedia=0;
for t=1:50
    
T = length(features(:,1));
part = 0.75 * T;
indices = randperm(T);

teste = features;
training = teste(indices(1:part),:); 
teste(indices(1:part),:) = [];


y = knnclassify(teste(:,1:(end-1)), training(:,1:(end-1)), training(:,end));

acurracia = sum(y==teste(:,end))/length(y);

acMedia = acMedia + acurracia;
end

acMedia/50





