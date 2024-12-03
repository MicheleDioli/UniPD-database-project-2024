#include "funzioni.h"
#define PG_HOST "localhost"
#define PG_USER "postgres"
#define PG_DB "project"
#define PG_PASS "aa"
#define PG_PORT 5432

int main() {
  struct termios old_termios;
  char conninfo[1024];
  char x = '0';
  char input[10];
  
  void (*query[])(PGconn *) = {Query1,Query2,Query3};

  char y = 0;

  printf("PER INSERIRE DATI CONNESSIONE POSTGRES DIGITARE [Y/y], altrimenti modificare define nel main\n->");

  scanf("%c",&y);

  while ((getchar()) != '\n' && getchar() != EOF);
  
  if(y == 'y' || y == 'Y'){

    char user[256];
    char password[256];
    char n_data[265];
    char host[256];
    int porta;
    
    printf("Inserire user Postgres\n");
    scanf("%s", user);
    while ((getchar()) != '\n' && getchar() != EOF);

    disable_echo_mode(&old_termios);
    printf("Inserire password Postgres\n");
    scanf("%s", password);
    while ((getchar()) != '\n' && getchar() != EOF);
    enable_echo_mode(&old_termios);
    
    printf("Inserire nome database Postgres\n");
    scanf("%s", n_data);
    while ((getchar()) != '\n' && getchar() != EOF);
    
    printf("Inserire nome host Postgres\n");
    scanf("%s",host);
    while ((getchar()) != '\n' && getchar() != EOF);
    
    printf("Inserire porta Postgres\n");
    scanf("%d", &porta);
     
    sprintf(conninfo, "user=%s password=%s dbname=%s host=%s port=%d", user,password,n_data,host,porta);
     while ((getchar()) != '\n' && getchar() != EOF);
     
  }
  
  else
    sprintf(conninfo, "user=%s password=%s dbname=%s host=%s port=%d", PG_USER,PG_PASS, PG_DB, PG_HOST, PG_PORT);

  PGconn *conn = PQconnectdb(conninfo); // connessione a Postgress

  //while ((getchar()) != '\n' && getchar() != EOF);
  
  if (checkConnesione(conn) == 0) // controllo connesione
    printf("Connessione avvenuta\n");
  else
    return 1;
  
  printf("Benvenuti nel gestionale della palestra\n\n");
  stampaElenco();

  while (x == '0') {

    printf("\nScegli un'operazione 1-6(h per info, q per uscire):");
    fgets(input, sizeof(input), stdin);
    printf("\n");
    // scanf("%s",innput);

    if (input[0] == 'H' || input[0] == 'h') { // carattere per info
      stampaElenco();
    }

    else if (input[0] == 'Q' || input[0] == 'q') { // carattere uscita
      x = '1';

    }

    else {
      int quiri = atoi(input); // concatena l'input e lo casta ad int, risolve
                               // problema per le doppie cifre

      if (quiri >= 1 && quiri <= 6) {
        quiri -= 1;
        query[quiri](conn); // chiamata all array di funzioni con la scelta inserita
      }

      else
        printf("Query selezionata non valida\n");
    }
  }

  PQfinish(conn);
  printf("Disconnessione riuscita\n");
}
