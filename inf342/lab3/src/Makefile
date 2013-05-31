RM=/bin/rm -f

TEACHER=true
MONOCORE=false

GNAT_ROOT_DIR=/usr/local/packages/gnat
GNAT_BIN_DIR=$(GNAT_ROOT_DIR)/bin
export PATH=$(GNAT_BIN_DIR):/usr/local/bin:/usr/bin:/bin

.SUFFIXES: .p.ads .p.adb .ads .adb

GNATPREP=gnatprep
GNATMAKE=gnatmake

GNATFLAGS=-g


%.ads:%.p.ads
	$(GNATPREP) -DMONOCORE=$(MONOCORE) -DTEACHER=$(TEACHER) $< $@

%.adb:%.p.adb
	$(GNATPREP) -DMONOCORE=$(MONOCORE) -DTEACHER=$(TEACHER) $< $@

SOURCES=\
aperiodic_servers.adb \
aperiodic_servers.ads \
aperiodic_tasks.adb \
aperiodic_tasks.ads \
events.adb \
events.ads \
runapsvr.adb \
io.adb \
io.ads \
periodic_tasks.adb \
periodic_tasks.ads \
background_servers.ads \
background_servers.adb \
deferred_servers.adb \
deferred_servers.ads \
polling_servers.adb \
polling_servers.ads \
sporadic_servers.adb \
sporadic_servers.ads \
scenarii.adb \
scenarii.ads \
tasks.adb \
tasks.ads

PROGS=\
runapsvr

all : $(PROGS)

sources: ${SOURCES}

runapsvr : $(SOURCES)
	$(GNATMAKE) $(GNATFLAGS) runapsvr

clean :
	$(RM) $(PROGS) b~* *~ *.o *.ali

veryclean : clean
	$(RM) $(SOURCES)

force :

src.tar.gz : force
	make veryclean
	make TEACHER=false $(SOURCES)
	tar zcf src.tar.gz `cat MANIFEST`


