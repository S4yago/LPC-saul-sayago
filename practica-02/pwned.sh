# Author: Ángel Saúl Sáyago Leiba

#!/bin/bash

# Valida que se pase como parámetro un .txt
if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <archivo txt que contiene los emails>"
  exit 1
fi

# Función que guarda la key
function api_key() {
  echo
  echo -n "Ingresé su API KEY: "
  read -s apikey
  echo
}

function data() {
  # Recorre el .txt linea por linea
  for email in $(cat $1)
  do
    echo $email
    
    # Se comunica con la API y está devuelve un json. Esté lo pasamos a un programa (jq)
    # a través de una tubería para extraer los datos que necesitamos y darle formato.
    curl -s -A "Saul Sayago" \
         -H "hibp-api-key:$apikey" \
         https://haveibeenpwned.com/api/v3/breachedaccount/$email?truncateResponse=false \
         | jq -j '.[] | "Infracción: ", .Title, " [", .Name, "] ", .BreachDate, "\n",
                 "Descripción:", "\n", .Description, "\n"'

    echo "+----------------------+"
    sleep 1
  done
  exit 0
}

api_key
data $1
