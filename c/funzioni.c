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

void stampa(char **st, int numC) {
    int righe = (numC + 2) / 3; 

    for (int r = 0; r < righe; r++) {
        for (int c = 0; c < 3; c++) {
            int indice = r + c * righe;
            if (indice < numC) {
                printf("%-3d) %-25s", indice + 1, st[indice]);
            } else {
                printf("%-28s", ""); 
            }
        }
        printf("\n");
    }
}


void listaQuer() {
  printf("Query 1:capi chirurghi e pazienti ricoverati dopo data scelta\n.");
  printf("Query 2: Pazienti di un reparto scelto, che sono allergici e le date di ricovero ordinate.\n");
  printf("Query 3: Accompagnatori pazienti con gruppo sanguigno scelto e in stanze grandi (# letti > 3)\n");
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

  int scelta;
  char data[32];
  char anno[8];
  char mese[8];
  char giorno[8];
  char turututuro[4] ="-";

  printf("digitare un anno\n->");
 
  scanf("%d",&scelta);
  
  while(scelta < 2000 || scelta >2030){
      printf("digitare un anno [2000-2030]\n->");
      scanf("%d",&scelta);
  }
  snprintf(anno, sizeof(anno), "%d", scelta);
  while ((getchar()) != '\n' && getchar() != EOF);


  printf("digitare un mese\n->");
  scanf("%d",&scelta);
  
  while(scelta < 1 || scelta >12){
      printf("digitare un mese [1-12]\n->");
      scanf("%d",&scelta);
  }
  snprintf(mese, sizeof(mese), "%d", scelta);
  while ((getchar()) != '\n' && getchar() != EOF);
  printf("digitare un giorno[1-31]\n->");
  scanf("%d",&scelta);
    while(scelta < 1 || scelta >31){
      printf("digitare un anno [1-31]\n->");
      scanf("%d",&scelta);
  }
  snprintf(giorno, sizeof(anno), "%d", scelta);
  while ((getchar()) != '\n' && getchar() != EOF);
  strcpy(data, anno);
  strcat(data, turututuro);
  strcat(data, mese);
  strcat(data, turututuro),
  strcat(data, giorno);
  const char *paramValues[1];
  paramValues[0] = data;

  const char *query = "WITH Ricoveri_dopo AS ("
    "SELECT " 
        "p.c_f, "
        "p.nome AS nome_paziente "
    "FROM Pazienti p "
    "JOIN Ricoveri r ON p.c_f = r.cf_ricoverato "
    "WHERE r.data_ricovero >= $1 "
"),"

"Chirurgi_capo AS ( "
    "SELECT "
        "p.badge, " 
       "p.nome AS nome_chirurgo, "
        "c.cf_paziente "
    "FROM Personale_medico p "
    "JOIN Lista_operazioni lo ON p.badge = lo.badge "
    "JOIN Operazioni o ON o.id_operazione = lo.id_operazione "
    "JOIN Cartella_clinica c ON o.id_cartella = c.id_cartella  "
   "WHERE p.capo_reparto = TRUE "
")"

"SELECT " 
    "cc.nome_chirurgo, " 
    "cc.badge, "
    "rd.nome_paziente "
"FROM Chirurgi_capo cc " 
"JOIN Ricoveri_dopo rd ON rd.c_f = cc.cf_paziente; ";

  PGresult *res = PQexecParams(conn, query, 1, NULL, paramValues, NULL, NULL, 0);
    if (check(res,conn) == 1)
      return;
    printQuery(res);
    PQclear(res);
}



void Query2(PGconn* conn){
  char *stringa[] = {
      "Cardiologia","Oncologia","Pediatria","Ortopedia","Ostetricia","Neurologia","Gastroenterologia","Dermatologia","Urologia"
    };
  int n = sizeof(stringa) / sizeof(stringa[0]);
  char scelta[32];
  int valore;
  printf("Seleziona il reparto\n");
  stampa(stringa,n);
  printf("\n->");
  scanf("%d",&valore);
  while (getchar() != '\n' && getchar() != EOF);
  
  while(valore < 1 || valore > 9){
    printf("Seleziona il reparto(1 - 9)\n");
    stampa(stringa,n);
    printf("\n->");
    scanf("%d",&valore);
    while (getchar() != '\n' && getchar() != EOF);
  }

  if (valore == 1) 
    strcpy(scelta, "Cardiologia");
  else if (valore == 2) 
    strcpy(scelta, "Oncologia");
  else if (valore == 3) 
    strcpy(scelta, "Pediatria");
  else if (valore == 4) 
    strcpy(scelta, "Ortopedia");
  else if (valore == 5) 
    strcpy(scelta, "Ostetricia");
  else if (valore == 6) 
    strcpy(scelta, "Neurologia");
  else if (valore == 7) 
    strcpy(scelta, "Gastroenterologia");
  else if (valore == 8)
    strcpy(scelta,"Dermatologia");
  else if (valore == 9)
    strcpy(scelta,"Urologia");
  
  const char *paramValues[1];
  paramValues[0] = scelta;

  const char *query = "WITH Pazienti_selezionati AS ( "
    "SELECT "
        "p.c_f, "
        "p.nome, "
        "p.cognome "
    "FROM Pazienti p "
    "JOIN Cartella_clinica cl ON cl.cf_paziente = p.c_f "
	"JOIN Lista_farmaci lf ON cl.id_cartella = cl.id_cartella "
    "WHERE cl.allergie IS NOT NULL "
	"), "
"pazienti_reparti AS ( "
    "SELECT "
        "r.cf_ricoverato, "
        "r.data_ricovero "
    "FROM Ricoveri r "
    "JOIN Camere c ON r.id_camera = c.id_camera "
    "WHERE c.nome_reparto = $1 " 
    "ORDER BY r.data_ricovero DESC "
") "
"SELECT "
    "p.nome, "
    "p.cognome, "
	"r.data_ricovero "
"FROM Pazienti p "
"JOIN Pazienti_reparti r ON r.cf_ricoverato = p.c_f " 
"WHERE p.c_f IN ( "
	"SELECT " 
		"c_f "
		"FROM Pazienti_selezionati);";

  PGresult *res = PQexecParams(conn, query, 1, NULL, paramValues, NULL, NULL, 0);
    if (check(res,conn) == 1)
      return;
    printQuery(res);
    PQclear(res);
}

void Query3(PGconn* conn){

    char *stringa[] = {
      "A-","A-","B+","B-","AB+","AB-","0+","0-"
    };
  int n = sizeof(stringa) / sizeof(stringa[0]);
  char scelta[32];
  int valore;
  printf("Seleziona il Gruppo sanguigno\n");
  stampa(stringa,n);
  printf("\n->");
  scanf("%d",&valore);
  while (getchar() != '\n' && getchar() != EOF);
  
  while(valore < 1 || valore > 8){
    printf("Seleziona il Gruppo sanguigno(1 - 8)\n");
    stampa(stringa,n);
    printf("\n->");
    scanf("%d",&valore);
    while (getchar() != '\n' && getchar() != EOF);
  }

  if (valore == 1) 
    strcpy(scelta, "A+");
  else if (valore == 2) 
    strcpy(scelta, "A-");
  else if (valore == 3) 
    strcpy(scelta, "B+");
  else if (valore == 4) 
    strcpy(scelta, "B-");
  else if (valore == 5) 
    strcpy(scelta, "AB+");
  else if (valore == 6) 
    strcpy(scelta, "AB-");
  else if (valore == 7) 
    strcpy(scelta, "0+");
  else if (valore == 8)
    strcpy(scelta,"0-");
  
  const char *paramValues[1];
  paramValues[0] = scelta;
  const char *query = "WITH stanze_posti AS ( "
	"SELECT cf_ricoverato "
	"FROM Ricoveri, Camere "
	"WHERE Ricoveri.id_camera = Camere.id_camera AND Camere.massimo_letti >= 3 "
") "

"SELECT " 
"a.nome, "
"a.parentela, "
"p.c_f "
"FROM Accompagnatori a "
"JOIN Pazienti p ON a.cf_paziente = p.c_f "
"JOIN Cartella_clinica cl ON cl.cf_paziente = p.c_f "
"WHERE cl.gruppo_sanguigno = $1 AND p.c_f IN ( "
	"SELECT "
	"cf_ricoverato "
	"FROM stanze_posti);";

  PGresult *res = PQexecParams(conn, query, 1, NULL, paramValues, NULL, NULL, 0);
    if (check(res,conn) == 1)
      return;
    printQuery(res);
    PQclear(res);
} 

/*
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
*/


/*

void Query(PGconn* conn){
  const char query = "";
  PGresult *res = PQexec(conn, query);
  if (check(res,conn) == 1)
    return;
  printQuery(res);
  PQclear(res);
} 
*/