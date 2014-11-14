 function grafico_treino(yi,yimax,dk,yk,epoca,epochexb,sse)
 global grafico legenda
 yi=yi.*yimax;   
 le=['Eav(' num2str(epoca) ') = ' num2str(sse)];
 if epoca==1 
      set(gcf,'Position',[1 33 800 494]); 
      axs=axes;
      set(axs,'NextPlot','Add','Box','On','FontName','TimesNewRoman','FontSize',12,'FontWeight','Bold') 
      grafico=plot(yi,dk,'bo',yi,yk,'k',0,0,'w');
      set(grafico,'LineWidth',2)  
      xla=xlabel('yi'); 
      yla=ylabel('dk, yk');  
      tit=title('Treinamento: MLP - Backpropagation');
      legenda=legend('Conjunto de treinamento','Saída da rede MLP',le,2);
      set(xla,'FontName','TimesNewRoman','FontSize',12,'FontWeight','Bold')
      set(yla,'FontName','TimesNewRoman','FontSize',12,'FontWeight','Bold')
      set(legenda,'FontName','TimesNewRoman','FontSize',11,'FontWeight','Bold')
      set(tit,'FontName','Arial','FontSize',16,'FontWeight','Normal')
    
elseif rem(epoca,epochexb)==0
      delete(grafico); delete(legenda);
      grafico=plot(yi,dk,'bo',yi,yk,'k',0,0,'w');
      legenda=legend('Conjunto de treinamento','Saída da rede MLP',le,2);
      set(grafico,'LineWidth',2); 
      set(legenda,'FontName','TimesNewRoman','FontSize',11,'FontWeight','Bold')
 end
 drawnow;