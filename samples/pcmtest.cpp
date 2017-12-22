#include <stdio.h>
#include "cpucounters.h"	// Intell PCM monitoring tool

//compile:
//g++ -std=c++11 -m32 -L/home/stardica/Dropbox/CDA7919DoctoralResearch/IntelPCM/Release_Static/ -static -lpthread -lIntelPCM test.cpp -o test


int main(void){

	PCM * m = PCM::getInstance();
	
	//reset the PMU
	m->resetPMU();

	long long start, end;
	

	PCM::ErrorCode returnResult = m->program();
	
	if (returnResult != PCM::Success){
	std::cerr << "Intel's PCM couldn't start" << std::endl;
	std::cerr << "Error code: " << returnResult << std::endl;
	std::cerr << "NOTE: log in with sudo su to change nmi_watchdog and run modprobe msr before executing pcmtest" << std::endl;

	exit(1);
	}
   
	SystemCounterState before_sstate = getSystemCounterState();
   
	start = RDTSC();
	std::cout << "hello" << std::endl;
	end = RDTSC();
   
	SystemCounterState after_sstate = getSystemCounterState();

	std::cout << "Num Cores:" << m->getNumCores() << std::endl;
	std::cout << "Num Sockets:" << m->getNumSockets() << std::endl;
	std::cout << "Threads Per Core:" << m->getThreadsPerCore() << std::endl;
	std::cout << "SMT Enabled:" << m->getSMT() << std::endl;
	std::cout << "Cycles:" << end - start << std::endl;
	std::cout << "Cycles2:" << getCycles(before_sstate) << std::endl;
	std::cout << "Cycles3:" << getCycles(before_sstate, after_sstate) << std::endl;


	std::cout << "Num MemCtrl:" << m->getMCPerSocket() << std::endl;
	std::cout << "Instructions per clock:" << getIPC(before_sstate,after_sstate) << std::endl;
	std::cout << "Bytes read:" << getBytesReadFromMC(before_sstate,after_sstate) << std::endl;
	
	std::cout << "L2Hit Ratio:" << getL2CacheHitRatio(before_sstate,after_sstate) << std::endl;

	std::cerr << "Intel PCM run successfully" << std::endl;

	return 1;
}

