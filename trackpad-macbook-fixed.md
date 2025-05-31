## Configurar Tapping y Gestos en Trackpad Apple (Xorg + libinput)

### 🛠️ Instalar dependencias de Xorg

```bash
sudo pacman -S xorg-server xorg-xinput
```

### 🔍 Ver qué driver usa el trackpad

Ejecuta:

```bash
xinput list
```

Ejemplo de salida:

```
⎜   ↳ Apple Inc. Apple Internal Keyboard / Trackpad    id=12   [slave  pointer  (2)]
```

### 👆 Activar "Tapping"

Crea el archivo de configuración:

```bash
sudo nano /etc/X11/xorg.conf.d/40-libinput.conf
```

Contenido del archivo:

```conf
Section "InputClass"
    Identifier "Apple Touchpad"
    MatchProduct "bcm5974"
    MatchIsTouchpad "on"
    Driver "libinput"
    Option "Tapping" "on"
    Option "NaturalScrolling" "true"
    Option "ClickMethod" "clickfinger"
    Option "DisableWhileTyping" "true"
EndSection
```

### 🔁 Reiniciar sesión

Cierra sesión o reinicia el equipo para aplicar los cambios:

```bash
logout
```

¡Listo! El tapping y desplazamiento natural deberían estar habilitados.
