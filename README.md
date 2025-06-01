# github_init_script

Ett Bash-skript som automatiserar skapandet av ett GitHub-repository med GitHub CLI.

## Funktioner

- Skapar en lokal mapp med valfritt namn
- Initialiserar ett Git-repository
- Skapar en README.md-fil
- Använder GitHub CLI för att skapa ett nytt repo på GitHub
- Pushar koden till GitHub via SSH
- Stöd för publika eller privata repositories
- Användaren specificerar:
  - Namn på repo
  - Beskrivning
  - Programmeringsspråk
  - Synlighet (public/private)

## Användning

Kör skriptet från terminalen:

```bash
./github_init.sh -n <repo-namn> -d "<beskrivning>" -l <språk> -v <public|private>
