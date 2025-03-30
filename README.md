# Progetto Basi di Dati

Progettato con **PostgreSQL 17**.

## Compilazione

La compilazione è facilitata dalla presenza di uno script `rebuild.sh` nella cartella `c`.  
Per compilare il progetto, è necessario avere installato **PostgreSQL** e assicurarsi che sia attivo.

### Verifica dei requisiti

1. **Verificare PostgreSQL**  
   Controllare che PostgreSQL sia installato eseguendo il seguente comando da terminale:
   ```bash
   psql --version
   ```

2. **Verificare CMake**  
   Il codice C per accedere a PostgreSQL richiede la presenza di **CMake**.  
   Controllare che sia installato con il comando:
   ```bash
   cmake --version
   ```

### Compilazione ed esecuzione

Una volta verificata la presenza di CMake e PostgreSQL, procedere come segue:

1. Accedere alla cartella `c`:
   ```bash
   cd c
   ```
2. *(Opzionale)* Modificare il file `main.c` per impostare i dati di accesso a **PostgreSQL**, aggiornando i valori dei `#define` secondo le proprie credenziali.
3. Eseguire lo script Bash `rebuild.sh` per compilare ed eseguire il codice:
   ```bash
   sh rebuild.sh
   ```
   
Se non ci sono errori, sarà possibile interagire con **PostgreSQL** direttamente dal terminale.

### Compatibilità

Lo script è stato testato con successo su:
- **Debian 12**
- **macOS Sequoia 15.3.2**
