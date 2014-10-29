function [Wh Wm]=treinaELM(xd,yd,n)
[nSamples nChar] = size(xd);


Wh = rand(nChar,n);

oh = xd*Wh;


%oh = tanh(oh);
oh = sigmf(oh,[1 0]);

Wm = pinv(oh)*yd;
end