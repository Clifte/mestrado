function exportEPS(nome)
figHandles = get(0,'Children');

for figh=figHandles'
    allAxes = findall(figh,'type','axes');
    for axH=allAxes'
        tmpH = figure;
        
        hax_new = copyobj( axH,tmpH);
        set(hax_new, 'Position', get(0, 'DefaultAxesPosition'));
        
        
        set(hax_new,'FontSize',15,'fontWeight','bold');
        set(findall(tmpH,'type','text'),'FontSize',15,'fontWeight','bold');
        name = get(get(hax_new,'title'),'string');
        
        name = [num2str(figh) '_' name '_' nome];
        print(tmpH, '-depsc', name);
        close;
    end
end
       
end