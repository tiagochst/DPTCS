OBJS = tsp.o relaxation.o 


tsp : $(OBJS)
	gcc -lm -O3 -o tsp $(OBJS) 

tsp.o: tsp.c tsp.h
	gcc -lm -O3 -c tsp.c

relaxation.o: relaxation.c tsp.h  
	gcc -lm -O3 -c relaxation.c
