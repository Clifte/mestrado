
function res = ajustaGama(image,g)
    res = uint8(255*((double(image)/255).^g));
end
