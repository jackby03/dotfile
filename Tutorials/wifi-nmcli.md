`nmcli` es una herramienta de línea de comandos para controlar *NetworkManager*, muy útil para gestionar conexiones de red (WiFi, Ethernet, VPN, etc.) desde la terminal. Aquí te doy una guía rápida con ejemplos comunes para que sepas cómo se usa:

---

### 🔍 Ver el estado de la red
```bash
nmcli general status
```

### 🌐 Ver todas las conexiones disponibles
```bash
nmcli connection show
```

### 📡 Ver redes WiFi disponibles
```bash
nmcli device wifi list
```

---

## ✅ Conectarte a una red WiFi

### Si la red está visible:
```bash
nmcli device wifi connect NOMBRE_DE_RED password TU_CONTRASEÑA
```

Ejemplo:
```bash
nmcli device wifi connect MiRedWiFi password supersecreta123
```

### Si ya está guardada (o es abierta):
```bash
nmcli connection up id NOMBRE_DE_CONEXIÓN
```

---

## ✂️ Desconectar una red

```bash
nmcli connection down id NOMBRE_DE_CONEXIÓN
```

---

## 🛠 Crear una conexión manual (por ejemplo, Ethernet con IP estática)
```bash
nmcli connection add type ethernet ifname eth0 con-name mi-eth ipv4.addresses 192.168.1.100/24 gw4 192.168.1.1
nmcli connection modify mi-eth ipv4.dns "8.8.8.8 1.1.1.1" ipv4.method manual
```

---

## 🚫 Borrar una conexión
```bash
nmcli connection delete id NOMBRE_DE_CONEXIÓN
```

---

## 📶 Ver el estado de los dispositivos de red
```bash
nmcli device status
```

---

## 🧪 Activar o desactivar un dispositivo
```bash
nmcli device disconnect wlan0
nmcli device connect wlan0
```

---

Si quieres, dime qué tipo de conexión estás intentando hacer (WiFi, cable, VPN, etc.) y te doy comandos exactos para tu caso.
