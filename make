.SUFFIXES: .erl .beam

#OUT = ./beam

.erl.beam:
    #erlc -W $< ; mv $@ ${OUT}
    erlc -W $< 
    ERL = erl -boot start_clean
    MODS = math test1

all: compile
compile: ${MODS:%=%.beam}
@echo "make clean -clean up"
# application:
#     ${ERL} -s application start ARG1 ARG2

clean:
    rm -rf *.beam erl_crash.dump
