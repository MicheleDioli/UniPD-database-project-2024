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
  printf("Query 1: Chirurghi che hanno operato con diverse attrezzature\n.");
  printf("Query 2: Media letti occupati reparto scelto, e media ospedale\n");
  printf("Query 3: Capo reparto e reparto con piè ricoverati\n");
  printf("Query 4: Prime n operazioni dell anno scelto\n");
  printf("Query 5: Somminostrazioni farmaco scelto\n");
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
    fprintf(stderr, "Query fallita...: %s\n", PQerrorMessage(c));
    PQclear(P);
    return 1;
  }
  return 0;
}

void Query1(PGconn* conn){
  const char *query ="SELECT "
    "so.livello_attrezzatura, "
    "COUNT(DISTINCT lo.badge) AS n_chirurgi "
"FROM Sale_operatorie AS so "
         "JOIN Operazioni AS o ON o.sala = so.id_sala "
         "JOIN Lista_operazioni AS lo ON lo.id_operazione = o.id_operazione "
"GROUP BY so.livello_attrezzatura; ";
  PGresult *res = PQexec(conn, query);
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

  const char *query = "WITH media AS( "
    "SELECT Camere.id_camera, COUNT(*) AS pa "
    "FROM Ricoveri, Camere "
    "WHERE Ricoveri.id_camera = Camere.id_camera "
    "GROUP BY Camere.id_camera "
"), "
     "media2 AS( "
         "SELECT Camere.id_camera, COUNT(*) AS pb "
         "FROM Ricoveri, Camere "
         "WHERE Ricoveri.id_camera = Camere.id_camera AND Camere.nome_reparto = $1 "
         "GROUP BY Camere.id_camera "
     ") "
"SELECT ROUND(AVG(pa),2) AS media_stanze, ROUND(AVG(pb),2) AS media_reparto "
"FROM media, media2; ";

  PGresult *res = PQexecParams(conn, query, 1, NULL, paramValues, NULL, NULL, 0);
    if (check(res,conn) == 1)
      return;
    printQuery(res);
    PQclear(res);
}

void Query3(PGconn* conn){
  const char *query = "SELECT "
    "pm.nome, "
    "pm.cognome, "
    "pm.badge, "
    "pm.reparto, "
    "COUNT(DISTINCT ca.id_camera) AS numero_camere_occupate "
"FROM Personale_medico AS pm "
         "JOIN Camere AS ca ON pm.reparto = ca.nome_reparto "
         "JOIN Ricoveri AS ri ON ca.id_camera = ri.id_camera "
"WHERE pm.capo_reparto = TRUE "
"GROUP BY pm.nome, pm.cognome, pm.badge, pm.reparto "
"HAVING COUNT(DISTINCT ca.id_camera) = ( "
    "SELECT "
        "MAX(numero_camere) "
    "FROM ( "
             "SELECT "
                 "COUNT(DISTINCT ca.id_camera) AS numero_camere "
             "FROM Camere AS ca "
                     "JOIN Ricoveri AS ri ON ca.id_camera = ri.id_camera "
             "GROUP BY ca.nome_reparto "
         ") AS conteggio "
"); ";
  PGresult *res = PQexec(conn, query);
  if (check(res,conn) == 1)
    return;
  printQuery(res);
  PQclear(res);
}

void Query4(PGconn* conn){
  char scelta2[32];
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
      printf("digitare un giorno [1-31]\n->");
      scanf("%d",&scelta);
  }
  snprintf(giorno, sizeof(anno), "%d", scelta);
  while ((getchar()) != '\n' && getchar() != EOF);
  strcpy(data, anno);
  strcat(data, turututuro);
  strcat(data, mese);
  strcat(data, turututuro),
  strcat(data, giorno);

  printf("\nDigitare il numero di operazioni da voler visualizzare:\n->");
  scanf("%d",&scelta);
  while(scelta < 0){
    printf("Scelta non valida, deve essere maggiore di zero\n->");
    scanf("%d",&scelta);
    }

  snprintf(scelta2, sizeof(scelta2), "%d", scelta);
  while (getchar() != '\n' && getchar() != EOF);
  const char *paramValues[2];
  paramValues[0] = scelta2;
  paramValues[1] = data;
  const char *query = "SELECT "
  "o.id_operazione, "
  "o.data_ AS data_operazione, "
  "p.eta AS eta_paziente, "
  "ROUND(AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, pm.data_nascita))),1) AS eta_media_chirurghi "
"FROM Operazioni AS o "
       "JOIN Lista_operazioni AS lo ON o.id_operazione = lo.id_operazione "
       "JOIN Personale_medico AS pm ON lo.badge = pm.badge "
       "JOIN Cartella_clinica AS cc ON o.id_cartella = cc.id_cartella "
       "JOIN Pazienti AS p ON cc.cf_paziente = p.c_f "
"WHERE o.data_ > $2 "
"GROUP BY o.id_operazione, o.data_, p.eta "
"ORDER BY o.data_ ASC "
  "LIMIT $1; ";

    PGresult *res = PQexecParams(conn, query, 2, NULL, paramValues, NULL, NULL, 0);
    if (check(res,conn) == 1)
      return;
    printQuery(res);
    PQclear(res);
}

void Query5(PGconn* conn){

  char *stringa[] = {"Aspirina","Ibuprofene","Paracetamolo","Amoxicillina","Ciprofloxacina","Omeprazolo","Lorazepam","Clorazepato","Metformina","Prednisolone","Cortisone","Morfina","Fentanil","Doxiciclina","Acido folico","Tachipirina","Digossina","Enalapril","Atorvastatina","Simvastatina","Lisinopril","Salmeterolo","Furosemide","Alprazolam","Diazepam","Ranitidina","Cetirizina","Loratadina","Levotiroxina","Metoclopramide","Prozac","Sertralina","Duloxetina","Losartan","Vareniclina","Fluconazolo","Itraconazolo","Amlodipina","Candesartan","Adenosina","Salbutamolo","Tobramicina","Gentamicina","Clindamicina","Aciclovir","Valaciclovir","Azitromicina","Leflunomide","Meflochina","Fosfomicina","Betametasone","Ketorolac","Naproxene","Rivaroxaban","Apixaban","Warfarin","Clopidogrel","Heparina"};

  int n = sizeof(stringa) / sizeof(stringa[0]);

    printf("Selezionare un farmaco [1-58]:\n");

    int s = -1;
    char x = '1';
    printf("Inserire un numero tra 1 e %d (H/h per mostrare la lista):\n-> ", n);
    char input[10];
    while(x == '1'){
        fgets(input, sizeof(input), stdin); // Legge una linea intera dall'input
        if (input[0] == 'H' || input[0] == 'h') {
            stampa(stringa, n);
            x = '1';
        } else { // else un po' dubbio ma non mi vengono alternative

        s = atoi(input); // Converte l'input in un intero
        
        if (s >= 1 && s <= n) {
            x = '0';
        } else {
          printf("Valore non valido. Riprova.");
          }

        }
        printf("\n-> ");
    }

    char scelta2[32];
    snprintf(scelta2, sizeof(scelta2), "%d", s + 400); // mo dovrebbe funzionare 
    const char *paramValues[1] = {scelta2};

  const char *query = "SELECT "
    "fa.nome, fa.dosaggio AS farmaco, "
    "COUNT(DISTINCT p.c_f) AS pazienti_prescritti, "
    "r.nome_reparto AS reparto_prescritto_di_piu "
"FROM "
    "Lista_farmaci lf "
    "JOIN Cure c ON lf.id_cura = c.id_cura "
    "JOIN Cartella_clinica cc ON c.id_cartella = cc.id_cartella "
    "JOIN Pazienti p ON cc.cf_paziente = p.c_f "
    "JOIN Personale_medico pm ON c.badge = pm.badge "
    "JOIN Reparti r ON pm.reparto = r.nome_reparto "
    "JOIN Farmaci fa ON lf.id_farmaco = fa.id_farmaco "
    "WHERE fa.id_farmaco = $1 "
    "GROUP BY "
        "fa.nome, r.nome_reparto,fa.dosaggio "
    "ORDER BY "
        "pazienti_prescritti DESC; ";

  PGresult *res = PQexecParams(conn, query, 1, NULL, paramValues, NULL, NULL, 0);
  if (check(res,conn) == 1)
    return;
  printQuery(res);
  PQclear(res);
}