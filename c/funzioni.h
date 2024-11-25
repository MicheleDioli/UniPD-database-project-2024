#include "libpq/include/libpq-fe.h"

void listaQuer();
void stampaElenco();
void printQuery(PGresult *);

int checkConnesione(PGconn *);
int check(PGresult *, PGconn *);

void Query1(PGconn *);
void Query2(PGconn *);
void Query3(PGconn *);
void Query4(PGconn *);
void Query5(PGconn *);
void Query6(PGconn *);
