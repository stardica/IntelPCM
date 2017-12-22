#compiler and linker
CC_FLAGS_64 = -g3 -O3 -Wall -Werror
CC_FLAGS_32 = -g3 -O3 -Wall -Werror -m32
CC = g++ -std=c++0x
LINKER_FLAGS_64 = -lIntelPCM64 -lpthread -static
LINKER_FLAGS_32 = -lIntelPCM64 -lpthread -static

INTELPCM_INC = /home/stardica/Dropbox/CDA7919DoctoralResearch/IntelPCM/
INTELPCM_LIB = /home/stardica/Dropbox/CDA7919DoctoralResearch/IntelPCM/

#DEsim
LIB_NAME_64 = "libIntelPCM64.a"
LIB_NAME_32 = "libIntelPCM32.a"

all: intelpcm64 intelpcm32 pcmtest

pcmtest:
	$(CC) $(CC_FLAGS_64) ./samples/pcmtest.cpp -o ./samples/pcmtest -I$(INTELPCM_INC) -L$(INTELPCM_LIB) $(LINKER_FLAGS_64)


intelpcm64: utils64.o pci64.o msr64.o cpucounters64.o client_bw64.o
		ar -r $(LIB_NAME_64) utils64.o pci64.o msr64.o cpucounters64.o client_bw64.o
		@echo "Built $@ successfully"
		
intelpcm32: utils32.o pci32.o msr32.o cpucounters32.o client_bw32.o
		ar -r $(LIB_NAME_32) utils32.o pci32.o msr32.o cpucounters32.o client_bw32.o
		@echo "Built $@ successfully"


#64 bit versions
utils64.o:
	$(CC) $(CC_FLAGS_64) utils.cpp -c -o utils64.o

pci64.o:
	$(CC) $(CC_FLAGS_64) pci.cpp -c -o pci64.o

msr64.o:
	$(CC) $(CC_FLAGS_64) msr.cpp -c -o msr64.o
	
cpucounters64.o:
	$(CC) $(CC_FLAGS_64) cpucounters.cpp -c -o cpucounters64.o
	
client_bw64.o:
	$(CC) $(CC_FLAGS_64) client_bw.cpp -c -o client_bw64.o
	
	
#32 bit versions
utils32.o:
	$(CC) $(CC_FLAGS_32) utils.cpp -c -o utils32.o

pci32.o:
	$(CC) $(CC_FLAGS_32) pci.cpp -c -o pci32.o

msr32.o:
	$(CC) $(CC_FLAGS_32) msr.cpp -c -o msr32.o
	
cpucounters32.o:
	$(CC) $(CC_FLAGS_32) cpucounters.cpp -c -o cpucounters32.o
	
client_bw32.o:
	$(CC) $(CC_FLAGS_32) client_bw.cpp -c -o client_bw32.o

	
clean:
	rm -f *.a *.o ./samples/pcmtest
