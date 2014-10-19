function res = ajustaDecomposicao(resH,N)
res =  zeros(N,N);

while N ~= 1
    N = N/2;
    lS = (N/2):(N);
    nIm = imresize(resH(lS , :), [N N]);
    res(lS,1:N) = nIm(:,:);
    figure
    imshow(uint8(nIm))
end