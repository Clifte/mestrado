function [mediaDesvio] = indexFeatures(features)
[m n] = size(features);

%caracteristica
%media/Desvio
%digito

mediaDesvio = zeros (n-1,2,10);

for j=1:(n-1)
    for i=0:9
        f = features(features(:,end)==i,j);
        mediaDesvio(j,1,i+1) = mean(f);
        mediaDesvio(j,2,i+1) = std(f);
    end
end

%Plotando projeções
figure;
hold on;
for i=1:10
    vm = mediaDesvio(7:14,1,i) + i - 1;
    vd = mediaDesvio(7:14,1,i);
    stairs(vm);
end
title('Projeção Vertical');

figure;
hold on;
for i=1:10
    vm = mediaDesvio(15:22,1,i) + i - 1;
    vd = mediaDesvio(15:22,1,i);
    stairs(vm);
end
title('Projeção Horizontal');
end