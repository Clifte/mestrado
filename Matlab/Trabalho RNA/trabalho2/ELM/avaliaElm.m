function yc = avaliaElm(x,Wh,Wm)

oh = x * Wh;
%oh = tanh(oh);
oh = sigmf(oh,[1 0]);
yc = oh*Wm;

end