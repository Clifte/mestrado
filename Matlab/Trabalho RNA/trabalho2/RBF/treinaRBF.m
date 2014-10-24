function [W Mc, Sigma]=treinaRBF( xd,yd,s,nRBFs)
    [ nAmostras nCaract] = size(xd);

    %Sigma = cov(xd);
    Sigma = eye(4)*s;
    
    if nargin<3
        Mc = xd;
        nRBFs = nAmostras;
    else
        [idx Mc] = kmeans(xd,nRBFs,'EmptyAction','singleton');
        %Gera Mc
    end

    phi=zeros(nAmostras, nRBFs);

    for i=1:nRBFs
            phi(:,i) = mvnpdf(xd(:,:),Mc(i,:),Sigma);
    end
      
    %Calculando Pesos utilizando OLAM
    in = pinv(phi);
    W = in * yd;
end


