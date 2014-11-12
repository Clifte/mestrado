function [Wh Wm]=treinaELM(xd,yd,n)
[nSamples nChar] = size(xd);


Wh = rand(nChar + 1,n);

%Adicionando bias
xd = [ones(nSamples,1) xd];

oh = xd * Wh;
oh = tanh(oh);
%oh = sigmf(oh,[1 0]);

%adicionando bias � camada de sa�da
oh = [ones(nSamples,1) oh];
Wm = pinv(oh) * yd;
end