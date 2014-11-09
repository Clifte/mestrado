EXECUTABLES = testei

CC=g++
CFLAGS=-c -w


all: $(EXECUTABLES)


clean:
	rm -f $(EXECUTABLES) *.o
	


#Compilando executavel exemplo
example:example.o
	$(CC) *.o -o build/example
	
example.o: matLib.o
	$(CC) $(CFLAGS) examples.cpp -I../src/


#Compilando arquivo de teste
testei:testei.o
	$(CC) *.o -o build/teste
	
testei.o: matLib.o
	$(CC) $(CFLAGS) test_i.cpp -I../src/	



#Lib que deve ser compilada	
matLib.o:
	$(CC) $(CFLAGS) ../src/*.cpp 

	
