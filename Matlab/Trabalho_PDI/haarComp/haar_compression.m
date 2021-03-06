function[] = haar_compression(filename,eps,num)

    X = imread(filename);
    sz = size(X);

    subplot(1,2,1)
    imshow(X)

    red = X(:,:,1);
    green = X(:,:,2);
    blue = X(:,:,3);

    redC = compressHaar(red,eps,2^num);
    greenC = compressHaar(green,eps,2^num);
    blueC = compressHaar(blue,eps,2^num);

    compressedImage(:,:,1) = redC;
    compressedImage(:,:,2) = greenC;
    compressedImage(:,:,3) = blueC;

    subplot(1,2,2)
    imshow(compressedImage);
end

function[D] = compressHaar(P,eps,num)

    origSz = size(P);
    %Ajustando imagem ao tamanho do bloco
    e1 = mod(origSz(1),num);
    if e1~=0
        P(origSz(1)+ num - e1,1) = 0;
    end

    e2 = mod(origSz(2),num);
    if e2~=0
        P(1,origSz(2)+ num - e2) = 0;
    end

    sz = size(P);
   
    X = haarmatrix(num);
    Xt = X';

    zcount = 0;
    compZ = 0;

    S = []
    for m=1:num:(sz(1)-num+1)
        for n=1:num:(sz(2)-num+1)
            %Retirando bloco
            E = P(m:(m+num-1),n:(n+num-1));

            T = Xt*double(E)*X;

            T(abs(T(:,:)) < eps) = 0;
            
            compZ = compZ + sum(sum(T==0));

            R = X*T*Xt;

            S(m:(m+num-1),n:(n+num-1)) = R;

        end
    end
    
    
    S = uint8(S);
    origZ =  sum(sum(P==0));
    diff = sz - origSz;
    compZ = compZ -  ( sz(1)*sz(2) - origSz(1)*origSz(2));

    D = S(1:origSz(1),1:origSz(2));
    strcat('N�mero de zeros na imagem original:', num2str(origZ) )
    strcat('N�mero de zeros na imagem comprimida', num2str(compZ))
    strcat('Taxa de compress�o:',num2str(compZ*100/(origSz(1)*origSz(2))),'%')
end
     