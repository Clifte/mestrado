 function grafico_sse(SSE,TBP)
 pause,close
 epocas=length(SSE);
 set(gcf,'Position',[1 33 800 494],'Color',[1 1 1]);
 grafico=semilogy(1:epocas,SSE,0,0,'w',0,0,'w',0,0,'w',0,0,'w');
 set(grafico,'LineWidth',2); grid on;
 legenda=legend('Eav - Erro médio quadrático',['Épocas de treinamento = ' num2str(epocas)],...
 ['Duraçäo do treinamento = ' num2str(TBP) ' min'],...
 ['Eav(mínimo) = ' num2str(min(SSE))],['Eav (final) = ' num2str(SSE(epocas))],1); 
 xla=xlabel('Épocas de treinamento'); yla=ylabel('Eav');
 titulo=title('Desempenho do MLP - Backpropagation');
 set(xla,'FontName','TimesNewRoman','FontSize',12,'FontWeight','Bold')
 set(yla,'FontName','TimesNewRoman','FontSize',12,'FontWeight','Bold')
 set(legenda,'FontName','TimesNewRoman','FontSize',11,'FontWeight','Bold')
 set(titulo,'FontName','Arial','FontSize',16,'FontWeight','Normal')
 