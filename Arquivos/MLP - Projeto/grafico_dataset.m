function grafico_dataset(yi,dk)
set(gcf,'Position',[1 33 800 494]); 
axs=axes;
set(axs,'NextPlot','Add','Box','On','FontName','TimesNewRoman','FontSize',12,'FontWeight','Bold'); 
grafico=plot(yi,dk,'ro');
set(grafico,'LineWidth',2);
xtxt=xlabel('yi'); 
ytxt=ylabel('dk');
titulo=title('Conjunto de Treinamento: (yi, dk)');
legenda=legend([num2str(length(yi)) ' Exemplos de treinamento'],2);
set(xtxt,'FontName','TimesNewRoman','FontSize',12,'FontWeight','Bold');
set(ytxt,'FontName','TimesNewRoman','FontSize',12,'FontWeight','Bold');
set(legenda,'FontName','TimesNewRoman','FontSize',11,'FontWeight','Bold');
set(titulo,'FontName','Arial','FontSize',16,'FontWeight','Normal');
pause,close