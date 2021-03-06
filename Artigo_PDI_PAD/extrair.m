function features = extrair(chars,img)
L = length(chars);
nBoxSize = 8;
features = zeros(L,7 + 2*nBoxSize);


for i=1:L
    fi = chars(i);
    bdbox = fi.BoundingBox;
    H = bdbox(1):(bdbox(1)+bdbox(3) -1);
    W = bdbox(2):(bdbox(2)+bdbox(4) -1);
    ch = imresize(img(int32(W),int32(H)),[ nBoxSize nBoxSize]);
    
   % imshow(ch)
    
   %area relativa
    features(i,1) = fi.Area / (bdbox(3) * bdbox(4));
    %aspecto
    features(i,2) = (bdbox(3) / bdbox(4));
    
    
    %calculando maximos das projeções horizontais e verticais
    ph = sum(ch);
    pv = sum(ch');
    
    %calculando maximos e localização das projecoes
    [pvv pvPk] = max(pv);
    [phv phPk ] = max(ph);
    
    %normalizando
    pvPk = pvPk / bdbox(4);
    pvv = pvv / bdbox(3);
    
    
    phPk = phPk / bdbox(3);
    phv = phv / bdbox(4);
    

    features(i,3) =pvPk ;
    features(i,4) =phPk ;
    features(i,5) =pvv ;
    features(i,6) =phv ;
    
    features(i,7:(nBoxSize+6)) = pv/nBoxSize;
    features(i,(nBoxSize+7):(2*nBoxSize+6)) = ph/nBoxSize;
     
     
    features(i,end) = floor(bdbox(2)/92);
end

end