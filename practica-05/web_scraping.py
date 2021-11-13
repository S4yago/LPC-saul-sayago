import requests
import os
import random
import re
from bs4 import BeautifulSoup


def scraping_image(archivo):
    lectura = open(archivo, "r")

    path = input(
        "Ingresar el path absoluto donde se van a guardar las imagenes: ")
    for linea in lectura:
        url = linea.rstrip('\n')
        try:
            os.makedirs(path)
        except:
            pass
        os.chdir(path)
        print(url)
        r = requests.get(url)
        soup = BeautifulSoup(r.text, 'html.parser')
        images = soup.find_all('img')
        for image in images:
            try:
                name = image['alt']
                link = image['src']
                name = re.sub('\/', '', name)
            except:
                name = ''
                link = ''
            if link == '' and name == '':
                continue
            else:
                with open(name + '.jpg', 'wb') as f:
                    if link.count('//') == 0:
                        continue
                    elif link.count('https:') == 0:
                        im = requests.get('https:' + link)
                        f.write(im.content)
                    else:
                        im = requests.get(link)
                        f.write(im.content)


if __name__ == "__main__":
    archivo = input("Ingrese el archivo a leer: ")
    scraping_image(archivo)
