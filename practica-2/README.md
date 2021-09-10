# PWNED

Scrip en bash que hace un llamado a la API de [Have I been pwned?][pwned].
Para saber si tu email está en una violación de datos.

### Usage:
Se va a pasar como parámetro un _.txt_ con los emails a verificar.

```bash
./pwned.sh emails.txt
```

# StatusPerfil

Scrip en powershell que espera un parametro del usuario (Public o Private).
Y te da la opción de cambiar el status del firewall.

### Usage:

```powershell
./StatusPerfil.ps1 -perfil [Public o Private]
```

[pwned]:https://haveibeenpwned.com/ "https://haveibeenpwned.com/"
