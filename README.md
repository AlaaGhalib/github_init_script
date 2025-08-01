# github_init_script
# ny version som även skapar nödvändiga filer  

## Projektstruktur
<REPO_NAME>/
├── src/
│ ├── main/
│ │ └── java/
│ │ └── Main.java
│ └── test/
│ └── java/
├── .gitignore
└── README.md

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
chmod +x github_init.sh       # Gör scriptet körbart (behövs bara en gång)
./github_init.sh -n <repo-namn> -d "<beskrivning>" -l <språk> -v <public|private>
