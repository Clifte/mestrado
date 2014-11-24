function [chars L N ] = extraiChars(binary)


%% elemento estruturante
ee = [0 1 0; 1 1 1; 0 1 0];

%% erosao
for i = 1:5
    im_erode = imerode(binary,ee);
end

%% dilatacao
for j = 1:5
    im_dilate = imerode(im_erode,ee);
end

%%
[L N] =  bwlabel(binary,8);
chars = regionprops(L);
end