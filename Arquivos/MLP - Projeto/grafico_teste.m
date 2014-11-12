function grafico_teste(yi,yimax,dk,yk,TBP1)
  yi=yi.*yimax;
  ek=abs(dk-yk);
  Emax=max(ek);
  Eav=sum(ek.^2)./(2*length(ek));
  set(gcf,'Position',[1 33 800 494]); 
  axs=axes;
  set(axs,'NextPlot','Add','Box','On','FontName','TimesNewRoman','FontSize',12,'FontWeight','Bold'); 
  a=plot(yi,dk,'r.',yi,yk,'k',0,0,'w',0,0,'w',0,0,'w');set(a,'LineWidth',2)  
   legenda=legend('Conjunto de teste, (yi, dk)', 'Sa�da da rede MLP, (yi, yk)',...
   ['Erro absoluto m�ximo: ' num2str(Emax)],['Erro m�dio quadr�tico: ' num2str(Eav)],...
   ['Dura��o do Teste: ' num2str(TBP1) ' s'],2);
   xla=xlabel('yi'); 
   yla=ylabel('(dk, yk)');
   titulo=title('Generaliza��o: yk=F(yi,Wji,Wkj)');
   set(xla,'FontName','TimesNewRoman','FontSize',12,'FontWeight','Bold')
   set(yla,'FontName','TimesNewRoman','FontSize',12,'FontWeight','Bold')
   set(legenda,'FontName','TimesNewRoman','FontSize',11,'FontWeight','Bold')
   set(titulo,'FontName','Arial','FontSize',16,'FontWeight','Normal')