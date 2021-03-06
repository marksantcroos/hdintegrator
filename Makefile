PROGRAMS=integrands/failing \
	integrands/maybe_failing \
	integrands/hanging \
	integrands/maybe_hanging \
	integrands/N-sphere \
	integrands/burgers_plain \
	integrands/burgers_miser \
	integrands/burgers_vegas \
	integrands/turbulence3_hcubature \
	integrands/turbulence3_pcubature \
	integrands/turbulence3_hcubature_v \
	integrands/turbulence3_pcubature_v \
	integrands/turbulence4

all: $(PROGRAMS)

COMP = g++ -std=c++14 -O3 -march=native -W -Wall -Wextra -Wpedantic $< -o $@

integrands/failing: integrands/failing.cpp Makefile
	$(COMP)

integrands/maybe_failing: integrands/maybe_failing.cpp Makefile
	$(COMP)

integrands/hanging: integrands/hanging.cpp Makefile
	$(COMP)

integrands/maybe_hanging: integrands/maybe_hanging.cpp Makefile
	$(COMP)

integrands/N-sphere: integrands/N-sphere.cpp Makefile
	$(COMP) integrands/gsl/plain2.c -I integrands/gsl -lgsl -lgslcblas

integrands/burgers_plain: integrands/burgers.cpp integrands/gsl/plain2.c Makefile
	$(COMP) integrands/gsl/plain2.c -DMETHOD=1 -I integrands/gsl -lgsl -lgslcblas -lboost_program_options

integrands/burgers_miser: integrands/burgers.cpp integrands/gsl/miser2.c Makefile
	$(COMP) integrands/gsl/miser2.c -DMETHOD=2 -I integrands/gsl -lgsl -lgslcblas -lboost_program_options

integrands/burgers_vegas: integrands/burgers.cpp Makefile
	$(COMP) integrands/gsl/vegas2.c -DMETHOD=3 -I integrands/gsl -lgsl -lgslcblas -lboost_program_options

integrands/turbulence3_hcubature: integrands/turbulence3.cpp Makefile
	$(COMP) -lhcubature -lboost_program_options

integrands/turbulence3_pcubature: integrands/turbulence3.cpp Makefile
	$(COMP) -DPCUBATURE -lpcubature -lboost_program_options

integrands/turbulence3_hcubature_v: integrands/turbulence3.cpp Makefile
	$(COMP) -DVECTORIZE -lhcubature -lboost_program_options

integrands/turbulence3_pcubature_v: integrands/turbulence3.cpp Makefile
	$(COMP) -DVECTORIZE -DPCUBATURE -lpcubature -lboost_program_options

integrands/turbulence4: integrands/turbulence4.cpp Makefile
	$(COMP) -I $(HOME)/ohjelmat/cxx-prettyprint -lboost_program_options

c: clean
clean:
	rm -f $(PROGRAMS)
