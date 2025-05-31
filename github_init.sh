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

  echo "# $REPO_NAME" > README.md
  echo -e "\n📄 Beskrivning: $REPO_DESC" >> README.md
  if [[ -n "$REPO_LANG" ]]; then
    echo " Språk: $REPO_LANG" >> README.md
  fi

  git init
  git add .
  git commit -m "Initial commit"

  gh repo create "$REPO_NAME" --description "$REPO_DESC" $VISIBILITY_FLAG --source=. --remote=origin --push
}

main "$@"