#include "libpq/include/libpq-fe.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <termios.h>
#include <unistd.h>

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

void disable_echo_mode(struct termios*);

void enable_echo_mode(const struct termios*);