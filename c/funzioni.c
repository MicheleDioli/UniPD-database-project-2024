#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include"funzioni.h"
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

void Query1(PGconn *conn) {
  const char *query =
    "WITH stipendio_per_gruppo AS ( "
    "SELECT 'Responsabili' AS gruppo, d.id_dipendente, c.stipendio "
    "FROM Responsabili r "
    "JOIN Dipendenti d ON r.id_responsabile = d.id_dipendente "
    "JOIN Contratti c ON d.id_contratto = c.id_contratto "
    "UNION ALL "
    "SELECT 'Personal Trainer' AS gruppo, d.id_dipendente, c.stipendio "
    "FROM Personal_trainer p "
    "JOIN Dipendenti d ON p.id_dipendente = d.id_dipendente "
    "JOIN Contratti c ON d.id_contratto = c.id_contratto "
    "UNION ALL "
    "SELECT 'Altri Impiegati' AS gruppo, d.id_dipendente, c.stipendio "
    "FROM Dipendenti d "
    "JOIN Contratti c ON d.id_contratto = c.id_contratto "
    "LEFT JOIN Responsabili r ON d.id_dipendente = r.id_responsabile "
    "LEFT JOIN Personal_trainer p ON d.id_dipendente = p.id_dipendente "
    "WHERE r.id_responsabile IS NULL AND p.id_dipendente IS NULL "
    "), "
    "media_stipendi AS ( "
    "SELECT gruppo, AVG(stipendio) AS media_stipendio "
    "FROM stipendio_per_gruppo "
    "GROUP BY gruppo "
    "), "
    "max_stipendi AS ( "
    "SELECT gruppo, MAX(stipendio) AS stipendio_max "
    "FROM stipendio_per_gruppo "
    "GROUP BY gruppo "
    "), "
    "dipendenti_max_stipendi AS ( "
    "SELECT sp.gruppo, sp.id_dipendente, sp.stipendio "
    "FROM stipendio_per_gruppo sp "
    "JOIN max_stipendi ms ON sp.gruppo = ms.gruppo AND sp.stipendio = ms.stipendio_max "
    ") "
    "SELECT m.gruppo, m.media_stipendio, c.nome, c.cognome, d.stipendio AS stipendio_max "
    "FROM media_stipendi m "
    "JOIN dipendenti_max_stipendi d ON m.gruppo = d.gruppo "
    "JOIN Dipendenti dp ON d.id_dipendente = dp.id_dipendente "
    "JOIN Contratti c ON dp.id_contratto = c.id_contratto "
    "ORDER BY m.gruppo;";

  PGresult *res = PQexec(conn, query);
  if (check(res,conn) == 1)
    return;
  printQuery(res);
  PQclear(res);
}

void Query2(PGconn *conn){
  char scelta[32];
  int valore;
  printf("Seleziona il corso\n");
  stampaCorsi();
  printf("\n->");
  scanf("%d",&valore);
  while (getchar() != '\n' && getchar() != EOF);
  
  while(valore < 1 || valore > 8){
    printf("Seleziona il corso(1 - 8)");
    stampaCorsi();
    printf("\n->");
    scanf("%d",&valore);
    scanf("%d",&valore);
    while (getchar() != '\n' && getchar() != EOF);
  }
  
  if (valore == 1) 
    strcpy(scelta, "Boxe");
  else if (valore == 2) 
    strcpy(scelta, "Crossfit");
  else if (valore == 3) 
    strcpy(scelta, "Fitness");
  else if (valore == 4) 
    strcpy(scelta, "Pilates");
  else if (valore == 5) 
    strcpy(scelta, "Sollevamento Pesi");
  else if (valore == 6) 
    strcpy(scelta, "Spinning");
  else if (valore == 7) 
    strcpy(scelta, "Yoga");
  else if (valore == 8)
    strcpy(scelta,"Zumba");
  
  const char *paramValues[1];
  paramValues[0] = scelta;
  
  const char *query = 
        "WITH corsi_info AS ( "
        "SELECT p.id_dipendente, p.corso, c.nome, c.cognome "
        "FROM Personal_trainer p "
        "JOIN Dipendenti d ON p.id_dipendente = d.id_dipendente "
        "JOIN Contratti c ON d.id_contratto = c.id_contratto "
        "WHERE p.corso = $1 "
        "), "
        "numero_abbonati AS ( "
        "SELECT a.corso, COUNT(*) AS numero_abbonati "
        "FROM Abbonati a "
        "WHERE a.corso = $1 "
        "GROUP BY a.corso "
        ") "
        "SELECT ci.nome, ci.cognome, na.numero_abbonati "
        "FROM corsi_info ci "
        "JOIN numero_abbonati na ON ci.corso = na.corso;";

 PGresult *res = PQexecParams(conn, query, 1, NULL, paramValues, NULL, NULL, 0);
  if (check(res,conn) == 1)
    return;
  printQuery(res);
  PQclear(res);
}

void Query3(PGconn *conn){  
  const char *query =
        "WITH PartecipazioneCorsi AS ( "
        "SELECT "
        "c.nome_corso, "
        "COUNT(a.id_abbonato) AS numero_partecipanti, "
        "ROUND(AVG(a.età), 1) AS età_media_partecipanti, "
        "MIN(a.età) AS età_minima, "
        "MAX(a.età) AS età_massima "
        "FROM "
        "Corsi_settimanali c "
        "LEFT JOIN "
        "Abbonati a ON c.nome_corso = a.corso "
        "GROUP BY "
        "c.nome_corso "
        ") "
        "SELECT "
        "nome_corso, "
        "numero_partecipanti, "
        "età_media_partecipanti, "
        "età_minima, "
        "età_massima, "
        "ROUND(numero_partecipanti::DECIMAL / SUM(numero_partecipanti) OVER () * 100, 1) AS frequenza_relativa "
        "FROM "
        "PartecipazioneCorsi "
        "ORDER BY "
        "numero_partecipanti DESC;";
 
  PGresult *res = PQexec(conn, query);
  if (check(res,conn) == 1)
    return;
  printQuery(res);
  PQclear(res);
}



void Query4(PGconn *conn){
 
  const char *query =
        "WITH VenditeTotali AS ( "
        "SELECT "
        "d.id_dipendente, "
        "c.nome, "
        "c.cognome, "
        "COUNT(v.id_vendita) AS numero_vendite, "
        "SUM(p.prezzo) AS totale_vendite "
        "FROM "
        "Dipendenti d "
        "JOIN "
        "Contratti c ON d.id_contratto = c.id_contratto "
        "JOIN "
        "Vendite v ON d.id_dipendente = v.id_commesso "
        "JOIN "
        "Shop p ON v.id_prodotto = p.id_prodotto "
        "GROUP BY "
        "d.id_dipendente, c.nome, c.cognome "
        ") "
        "SELECT "
        "nome, "
        "cognome, "
        "numero_vendite, "
        " totale_vendite, "
        " ROUND(totale_vendite / SUM(totale_vendite) OVER () * 100, 1) AS percentuale_vendite_totale "
        "FROM "
        "VenditeTotali "
        "ORDER BY "
        "totale_vendite DESC;";
 
  PGresult *res = PQexec(conn, query);
  if (check(res,conn) == 1)
    return;
  printQuery(res);
  PQclear(res);
}




void Query5(PGconn *conn){

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
    printf("Inserire numero minimo di vendite\n-> ");
    scanf("%d", &min_vendite);
    while ((getchar()) != '\n' && getchar() != EOF);
    char min_vendite_str[10];
    snprintf(min_vendite_str, sizeof(min_vendite_str), "%d", min_vendite);

  const char *paramValues[2];
  paramValues[0] = scelta;
  paramValues[1] = min_vendite_str;
  const char *query =
        "WITH VenditeDipendenti AS ( "
        "SELECT "
        "d.id_dipendente, "
        "d.id_contratto, "
        "COUNT(v.id_vendita) AS numero_vendite, "
        "SUM(s.prezzo) AS totale_vendite, "
        "s.tipo_prodotto "
        "FROM "
        "Dipendenti d "
        "JOIN "
        "Vendite v ON d.id_dipendente = v.id_commesso "
        "JOIN "
        "Shop s ON v.id_prodotto = s.id_prodotto "
        "GROUP BY "
        "d.id_dipendente, d.id_contratto, s.tipo_prodotto "
        ") "
        "SELECT "
        "c.nome AS nome_dipendente, "
        "c.cognome AS cognome_dipendente, "
        "vd.numero_vendite, "
        "vd.totale_vendite "
        "FROM "
        "VenditeDipendenti vd "
        "JOIN "
        "Contratti c ON vd.id_contratto = c.id_contratto "
        "WHERE "
        "vd.numero_vendite >= $2 "
        "AND vd.tipo_prodotto = $1;";
 
  PGresult *res = PQexecParams(conn, query, 2, NULL, paramValues, NULL, NULL, 0);
  if (check(res,conn) == 1)
    return;
  printQuery(res);
  PQclear(res);
}




void Query6(PGconn *conn){

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
