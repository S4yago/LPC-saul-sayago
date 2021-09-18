#!/bin/sh

function get_repos() {
  repos=`curl -s  "https://api.github.com/users/$user_git/repos" | jq -j '.[] | "\n", "- ", .name'`
  echo -e "Repositorios de $user_git: $repos"
}

function get_contributors(){
  r_contributors=`curl -s "https://api.github.com/repos/$user_git/$repositorio/contributors" | jq -j '.[] | .login, ", "'`
  echo -e "Contribuyentes: $r_contributors"
}

function get_info() {
  curl -s "https://api.github.com/repos/$user_git/$repositorio" | jq -j '"url_repo: ", .html_url, "\n"'
  curl -s "https://api.github.com/repos/$user_git/$repositorio" | jq -j '"ssh_url: ", .ssh_url, "\n"'
  curl -s "https://api.github.com/repos/$user_git/$repositorio" | jq -j '"created_at: ", .created_at, "\n"'
}

echo -n "Ingrese el usuario de GitHub: "; read user_git
get_repos
echo -n "Introduce el nombre del repositorio: "; read repositorio
get_contributors
echo -e "Información del repositorio:"
get_info
