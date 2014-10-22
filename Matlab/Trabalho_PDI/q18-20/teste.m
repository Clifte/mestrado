
close all;
clear;
clc;

%Carregando imagens
imagesPath =[]
imagesPath(1,:) = ('../bd/device9-5.gif');
imagesPath(2,:) = ('../bd/spring-11.gif');


%Definindo elementos estruturantes
es = []
es(:,:,1) = [ 0 1 0;1 1 1; 0 1 0]; % cruz
es(:,:,2) = [ 1 0 0;0 1 0;0 0 1];  % direita
es(:,:,3) = [ 0 0 1;0 1 0; 1 0 0]; % esquerda

for e=1:length(es)
    figure

    for im=1:length(imagesPath(:,1))
        ces = es(:,:,e);
        cim = mat2gray(imread(string(imagesPath(im,:))));
        
        subplot(2,3, 3*(im-1)+1)
        imshow(cim);
        
        subplot(2,3, 3*(im-1) +2)
        dim=cim;
        for c=1:5
            dim = imdilate(dim,ces);
        end
        imshow(dim);
        
        
        
        
        subplot(2,3, 3*(im-1) +3)
        eim=cim;
        for c=1:5
            eim = imerode(eim,ces);
        end
        imshow(eim);
    end
end