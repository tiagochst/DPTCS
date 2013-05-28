/*   ATTENTION : edition de liens avec -lpthread
        gcc -o Exo0 -Wall Exo0.c -lpthread
*/

#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>

#define MAXTHREADS 100

/*------------------------------------------------------- 
                               main
------------------------------------------------------- */
int main(int argc, char *argv[]) {
  int i;
  int NbThreads;
  void Un_Thread (void);

  pthread_t thr_main, threads[MAXTHREADS];

  if (argc != 2) { 
       printf (" Usage : %s nbre-de -threads\n", argv[0]);
       exit(1);
    } 
  
  NbThreads = atoi(argv[1]);
  thr_main = pthread_self();
  
  /* creation des threads  */
  for ( i = 0; i < NbThreads ; i++) { 
    /* I.1 1*/
    pthread_create((threads+i),NULL,(void*)Un_Thread,NULL );
    
    printf("------ Thr (0x)%x (main) cree: (0x)%x (i = %d)\n", 
	   (int)thr_main, (int)threads[i], i);
  } 
  for ( i = 0; i < NbThreads ; i++) { 
    pthread_join(threads[i],NULL); 
  } 
  
  printf("------main Fin de main (0x)%x\n", (int)thr_main);
  return (0);
}

/*-----------------------------------------------------------------
                            Un_Thread
  Fonction executee par les threads.
  -----------------------------------------------------------------*/
void Un_Thread (void) {
  pthread_t mon_tid;
  int i;
 
  mon_tid = pthread_self();
  printf("Thread (0x)%x : CREE\n", (int)mon_tid);
 
  srandom(time(NULL));
  sleep (random()%3);
 
  printf("Thread (0x)%x : DEBUT\n", (int)mon_tid);  
    for ( i = 0; i < 5 ; i++)
    {
      sleep (random()%4);
      printf("Thread (0x)%x :  iteration %d \n", (int)mon_tid , i);
    }

  printf("Thread (0x)%x : FIN\n", (int)mon_tid);

  pthread_exit(NULL);
}


