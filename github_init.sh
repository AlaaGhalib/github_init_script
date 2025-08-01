#!/usr/bin/env bash

REPO_NAME=""
REPO_DESC=""
REPO_LANG=""
REPO_VISIBILITY=""

# --- Argument parsing function ---
parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -n)
        REPO_NAME="$2"
        shift 2
        ;;
      -d)
        REPO_DESC="$2"
        shift 2
        ;;
      -l)
        REPO_LANG="$2"
        shift 2
        ;;
      -v)
        if [[ "$2" != "public" && "$2" != "private" ]]; then
          echo " Fel: -v måste vara 'public' eller 'private'"
          exit 1
        fi
        REPO_VISIBILITY="$2"
        shift 2
        ;;
      -h)
        echo "Användning:"
        echo "  ./create_repo.sh -n <namn> -d <beskrivning> -l <språk> -v <public|private>"
        exit 0
        ;;
      *)
        echo " Okänd flagga: $1"
        exit 1
        ;;
    esac
  done
}

# --- Main function ---
main() {
  parse_args "$@"

  if [[ -z "$REPO_NAME" || -z "$REPO_DESC" || -z "$REPO_VISIBILITY" || -z "$REPO_LANG" ]]; then
    echo " Du måste ange -n, -d, -l och -v"
    exit 1
  fi

  if [[ "$REPO_VISIBILITY" == "private" ]]; then
    VISIBILITY_FLAG="--private"
  else
    VISIBILITY_FLAG="--public"
  fi

  echo " Skapar repo: $REPO_NAME ($REPO_VISIBILITY)"
  mkdir "$REPO_NAME"
  cd "$REPO_NAME" || exit 1

  # Create README.md
  echo "# $REPO_NAME" > README.md
  echo -e "\n📄 Beskrivning: $REPO_DESC" >> README.md
  echo " Språk: $REPO_LANG" >> README.md

if [[ "$REPO_LANG" == "Java" ]]; then
  echo " Skapar Java-projektstruktur..."

  mkdir -p src/main/java src/test/java

  cat > .gitignore <<EOL
# Compiled class files
*.class

# Logs
*.log

# Maven target directory
target/

# Eclipse files
.project
.classpath

# IntelliJ files
.idea/
*.iml
*.iws

EOL

  cat > src/main/java/Main.java <<EOL
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, $REPO_NAME!");
    }
}
EOL

  # Skapa build.sh
  cat > build.sh <<'EOL'
#!/usr/bin/env bash

echo "Kompilerar Java-koden..."
mkdir -p build/classes
javac -d build/classes $(find src/main/java -name "*.java")

if [[ $? -ne 0 ]]; then
  echo "Kompilering misslyckades!"
  exit 1
fi

echo "Kör programmet..."
java -cp build/classes Main
EOL

  chmod +x build.sh

else
  echo " Obs: Projektstruktur för språket '$REPO_LANG' är inte implementerad."
fi


  # Initialize git repo
  git init
  git add .
  git commit -m "Initial commit with project structure"

  # Create GitHub repo and push
  gh repo create "$REPO_NAME" --description "$REPO_DESC" $VISIBILITY_FLAG --source=. --remote=origin --push
}

main "$@"
