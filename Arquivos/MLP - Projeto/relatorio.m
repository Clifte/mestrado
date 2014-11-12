function relatorio(N,xteste,ETA,WMED,Ni,Nh,Ns,SSE,TBP,EMAX,EAV,TBP1)
epoca=length(SSE);   
disp('__________________________________________________________________________')
disp('REDE MLP -  ALGORITMO BACKPROPAGATION')
disp('RELATÓRIO DE PROJETO');
disp('__________________________________________________________________________')
disp('1. PARÄMETROS DO PROJETO');
disp(['   Exemplos de Treinamento: ' num2str(N)]);
disp(['   Exemplos de Teste: ' num2str(length(xteste))]);
disp(['   Taxa de aprendizado: ' num2str(ETA)]);
disp(['   Pesos, valor médio inicial: ' num2str(WMED)]);

disp('2. CONFIGURACÄO DA REDE NEURAL'); 
disp('   Número de Neurönios por Camada');
disp(['   Entrada:      ' num2str(Ni)]);
disp(['   Escondida: ' num2str(Nh)]);
disp(['   Saída:          ' num2str(Ns)']);         

disp('3. TREINAMENTO');
disp(['   Número de épocas: ' num2str(epoca)]);
disp(['   Erro médio quadrático: ' num2str(SSE(epoca))]);
disp(['   Duraçäo do Treinamento: ' num2str(TBP) ' min']);

disp('4. TESTE');
disp(['   Erro absoluto máximo: ' num2str(EMAX)]);
disp(['   Erro médio quadrático: ' num2str(EAV)]);   
disp(['   Duraçäo do Teste: ' num2str(TBP1) ' s']);