#include"funzioni.h"

void disable_echo_mode(struct termios *old_termios) {
    struct termios new_termios;
    tcgetattr(STDIN_FILENO, old_termios); 
    new_termios = *old_termios;
    new_termios.c_lflag &= ~ECHO;         
    tcsetattr(STDIN_FILENO, TCSANOW, &new_termios); 
}

void enable_echo_mode(const struct termios *old_termios) {
    tcsetattr(STDIN_FILENO, TCSANOW, old_termios); 
}


void stampaCorsi(){
  
  char *prodotti[] = {
    "Boxe","Crossfit","Fitness","Pilates","Sollevamento Pesi","Spinning","Yoga","Zumba"
  };
  
  int numProdotti = sizeof(prodotti) / sizeof(prodotti[0]);
  int righe = (numProdotti +  2) / 3; 
  for(int r = 0; r < righe; r++) {
    for(int c = 0; c < 3; c++) {
      int indice = r + c * righe;
      if(indice < numProdotti) {
	printf("%-3d) %-25s", indice + 1, prodotti[indice]);
      } else {
	printf("%-28s", "");
      }
    }
    printf("\n");
  }
}

void listaQuer() {
  printf("Query 1: Media e massimo stipendio per gruppo di dipendenti\n");
  printf("Query 2: Personal trainer e abbonati per corso scelto\n");
  printf("Query 3: Statistiche sui partecipanti ai corsi settimanali\n");
  printf("Query 4: endite e percentuale totale per ciascun dipendente\n");
  printf("Query 5: Vendite e dettagli per dipendenti con più di n vendite\n");
  printf("Query 6: Trova prodotti più costosi acquistati almeno n volte.\n");
}

void stampaElenco() {
  printf("\nLISTA DELLE OPERAZIONI\n");
  listaQuer();
}

void printQuery(PGresult *res) {
  const int tuple = PQntuples(res);
  const int campi = PQnfields(res);
  char v[tuple + 1][campi][256];

  for (int i = 0; i < campi; ++i) {
    strncpy(v[0][i], PQfname(res, i), 256);
  }

  if (tuple == 0) {
    printf("\nRecord not found.\n"); 
    return;
  }
  for (int i = 0; i < tuple; ++i) {
    for (int j = 0; j < campi; ++j) {
      if (strcmp(PQgetvalue(res, i, j), "t") == 0 || 
          strcmp(PQgetvalue(res, i, j), "f") == 0) { 
        if (strcmp(PQgetvalue(res, i, j), "t") == 0) { 
          strncpy(v[i + 1][j], "si", 256); 
        } else {
          strncpy(v[i + 1][j], "no", 256); 
        }
      } else {
        strncpy(v[i + 1][j], PQgetvalue(res, i, j), 256);
      }
    }
  }

  int maxChar[campi]; 
  for (int i = 0; i < campi; ++i) {
    maxChar[i] = 0;
  }

  for (int i = 0; i < campi; ++i) {
    for (int j = 0; j < tuple + 1; ++j) {
      int size = strlen(v[j][i]);
      if (size > maxChar[i]) {
        maxChar[i] = size;
      }
    }
  }

  for (int i = 0; i < campi; ++i) {
    printf("%-*s|", maxChar[i] + 1, v[0][i]); 
  }
  printf("\n");

  for (int i = 0; i < campi; ++i) {
    for (int j = 0; j < maxChar[i] + 1; ++j)
      printf("."); 
                   
    printf("|");   
  }
  printf("\n");
  for (int i = 0; i < tuple; ++i) {
    for (int j = 0; j < campi; ++j) {
      printf("%-*s|", maxChar[j] + 1, v[i + 1][j]);
    }
    printf("\n");
  }
}

int checkConnesione(PGconn *c) {
  if (PQstatus(c) != CONNECTION_OK) {
    fprintf(stderr, "Connessione non avvenuta...: %s\n", PQerrorMessage(c));
    PQfinish(c);
    return 1;
  }
  return 0;
}

int check(PGresult *P, PGconn *c) {
  if (PQresultStatus(P) != PGRES_TUPLES_OK) {
    fprintf(stderr, "Query fallita: %s\n", PQerrorMessage(c));
    PQclear(P);
    return 1;
  }
  return 0;
}

void Query1(PGconn *conn){

  int valore;
  char scelta[32];
  printf("Inserire numero per selezionare prodotto 1-4\n1 )Accessori     2 )Attrezzo Calisthenics      3 )Attrezzo Fitness\n4 )Integratore");
  printf("\n->");
  scanf("%d",&valore);
  while(valore < 1 || valore > 4){
    printf("Scleta non valida\n");
    printf("Inserire numero per selezionare prodotto 1-4\n->");
    scanf("%d",&valore);
  }
  
    if (valore == 1) 
    strcpy(scelta, "Accessori");
  else if (valore == 2) 
    strcpy(scelta, "Attrezzo Calisthenics");
  else if (valore == 3) 
    strcpy(scelta, "Attrezzo Fitness");
  else if (valore == 4) 
    strcpy(scelta, "Integratore");

    int min_vendite;
    printf("Inserire il numero minimo di volte comprato\n-> ");
    scanf("%d", &min_vendite);
    while ((getchar()) != '\n' && getchar() != EOF);
    char min_vendite_str[10];
    snprintf(min_vendite_str, sizeof(min_vendite_str), "%d", min_vendite);

const char *paramValues[2];
  paramValues[0] = scelta;
  paramValues[1] = min_vendite_str;			
    
  const char *query =
"WITH VenditePerProdotto AS ("
        "    SELECT s.id_prodotto, s.nome_prodotto, s.prezzo, COUNT(v.id_vendita) AS numero_vendite "
        "    FROM Shop s "
        "    JOIN Vendite v ON s.id_prodotto = v.id_prodotto "
        "    WHERE s.tipo_prodotto = $1 "
        "    GROUP BY s.id_prodotto, s.nome_prodotto, s.prezzo "
        "    HAVING COUNT(v.id_vendita) >= $2 "
        "), "
        "ProdottiCostosi AS ("
        "    SELECT nome_prodotto, prezzo, numero_vendite "
        "    FROM VenditePerProdotto "
        "    WHERE prezzo = ("
        "        SELECT MAX(prezzo) "
        "        FROM VenditePerProdotto "
        "    )"
        ") "
        "SELECT nome_prodotto, prezzo, numero_vendite "
        "FROM ProdottiCostosi "
    "ORDER BY prezzo DESC;";
  
 PGresult *res = PQexecParams(conn, query, 2, NULL, paramValues, NULL, NULL, 0);
  
  if (check(res,conn) == 1)
    return;
  printQuery(res);
  PQclear(res);
}
