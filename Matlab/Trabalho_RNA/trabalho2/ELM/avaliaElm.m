function yc = avaliaElm(x,Wh,Wm)
[nSamples nChar] = size(x);

x = [ones(nSamples,1) x];

oh = x * Wh;
oh = tanh(oh);
%oh = sigmf(oh,[1 0]);

oh = [ones(nSamples,1) oh];
yc = oh * Wm;

end