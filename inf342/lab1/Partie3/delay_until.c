#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

#define NB_TASKS 2

/*************** main ********************/
int main(int argc, char* argv[]){
  pthread_t Les_Threads[NB_TASKS];
  int delai[NB_TASKS], i = 0;
  void Une_Tache (void *arg);

  if (argc != 3) {
    printf("Utilisation : %s delai_1 delai_2 !\n", argv[0]);
    return 1;
  }

  /* creation des threads */
  for (i = 0; i < NB_TASKS ; i++){ 
    /* Get delay from user input */
    delai[i] = atoi(argv[i+1]);
    pthread_create(Les_Threads+i, NULL,(void *) Une_Tache, (void *)  (delai+i));
  }   
   
  /* attendre la fin des threads precedemment crees */
  for (i = 0 ; i < NB_TASKS ; i++){
    pthread_join(Les_Threads[i],NULL);
    printf("main (tid %d) fin de tid %d\n", (int)pthread_self(), (int)Les_Threads[i]);
  }
  
  return 0;
}

/*************** Une_Tache ********************/
void Une_Tache (void *arg) {
  int *Ptr;
  int compteur, delai;
  pthread_cond_t var_cond;
  pthread_mutex_t verrou;
  struct timespec time;

  Ptr = (int *)arg;
  delai = *Ptr;

  /* initialiser le verrou et la var. cond. */
  /* A FAIRE */
  pthread_cond_init(&var_cond, NULL);
  pthread_mutex_init(&verrou, NULL);

  compteur = 0;
  while (compteur < 10){
    pthread_mutex_lock(&verrou);
    clock_gettime (CLOCK_REALTIME, &time);
    time.tv_sec += delai ;
    compteur = compteur + 1;
    printf("tid %d : date (s.ns) : %d.%d, compteur %d, delai %d\n", 
	   (int)pthread_self(), (int)time.tv_sec, (int)time.tv_nsec, compteur, delai);
    pthread_cond_timedwait (&var_cond, &verrou, &time);
      pthread_mutex_unlock(&verrou);
  }

}
