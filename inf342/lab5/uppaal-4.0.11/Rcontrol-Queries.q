//This file was generated from (Academic) UPPAAL 4.0.11 (rev. 4492), February 2010

/*
mauvaise exclusion mutuelle 
*/
A[] not(exists (e1 : int[0,N-2]) (exists (e2 : int[0,N-2]) (Thread(e1).Processing_R  and Thread(e2).Processing_R and e1!= e2)))

/*
Pas de blocage ...
*/
A[] not deadlock
