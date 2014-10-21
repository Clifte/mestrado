function [dh dv dD da] = haarDecomposition(image)
    N = length(image(1,:));
    %Primeira decomposição
    mask = haar2(N);
    %Calculando imagem Horizontal  dwt2(f,wname);
    resH = mask * double(image) * (mask');
    
    h = floor(N/2);
    
    dD = resH((h+1):N,(h+1):N);
    da = resH(1:h,1:h);
    dh = resH(1:h,(h+1):N);
    dv = resH((h+1):N,1:h);
end