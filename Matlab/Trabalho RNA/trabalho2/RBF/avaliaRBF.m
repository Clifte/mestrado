function yc = avaliaRBF(x,Mc,Sigma,W)
    [nRBFs nClasses] = size(W);


    [ nAmostras nCaract] = size(x);
    
    
    phi=zeros(nAmostras, nRBFs);

    for i=1:nRBFs
            phi(:,i) = mvnpdf(x,Mc(i,:),Sigma);
    end

    yc = phi * W;
end