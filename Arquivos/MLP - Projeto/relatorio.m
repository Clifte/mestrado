function relatorio(N,xteste,ETA,WMED,Ni,Nh,Ns,SSE,TBP,EMAX,EAV,TBP1)
epoca=length(SSE);   
disp('__________________________________________________________________________')
disp('REDE MLP -  ALGORITMO BACKPROPAGATION')
disp('RELAT�RIO DE PROJETO');
disp('__________________________________________________________________________')
disp('1. PAR�METROS DO PROJETO');
disp(['   Exemplos de Treinamento: ' num2str(N)]);
disp(['   Exemplos de Teste: ' num2str(length(xteste))]);
disp(['   Taxa de aprendizado: ' num2str(ETA)]);
disp(['   Pesos, valor m�dio inicial: ' num2str(WMED)]);

disp('2. CONFIGURAC�O DA REDE NEURAL'); 
disp('   N�mero de Neur�nios por Camada');
disp(['   Entrada:      ' num2str(Ni)]);
disp(['   Escondida: ' num2str(Nh)]);
disp(['   Sa�da:          ' num2str(Ns)']);         

disp('3. TREINAMENTO');
disp(['   N�mero de �pocas: ' num2str(epoca)]);
disp(['   Erro m�dio quadr�tico: ' num2str(SSE(epoca))]);
disp(['   Dura��o do Treinamento: ' num2str(TBP) ' min']);

disp('4. TESTE');
disp(['   Erro absoluto m�ximo: ' num2str(EMAX)]);
disp(['   Erro m�dio quadr�tico: ' num2str(EAV)]);   
disp(['   Dura��o do Teste: ' num2str(TBP1) ' s']);