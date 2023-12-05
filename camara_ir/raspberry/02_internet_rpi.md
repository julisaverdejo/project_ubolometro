## ¿Cómo compartir internet a la Raspberry Pi?



### Ethernet

1. Conectar la computadora y la Raspberry Pi por medio de cable ethernet
2. En tu computadora ir a **Panel de Control** > **Redes e Internet**

![img](./imagenes/panel_control.jpg)

3. **Centro de redes y recursos compartidos** 

![img](./imagenes/centro_redes.jpg)

4. **Cambiar configuración del adaptador** 

![img](./imagenes/config_adap.jpg)

5. Clic derecho en **WiFi** > **Propiedades** 

![img](./imagenes/wifi_prop.jpg)

6. **Uso compartido** > Seleccionar **Permitir que los usuarios de otras redes se conecten ...** > **Aceptar** 

![img](./imagenes/uso_compartido.jpg)



### SSH

Antes de conectar la Raspberry Pi por SSH se necesitan descargar algunos programas: [Nmap](https://nmap.org/) y [PuTTY](https://www.putty.org/) 

1. Conectar por ethernet la Raspberry Pi y la computadora
2. Conectar monitor y mouse a Raspberry Pi.
3. Ir a **Menu** > **Preferences** > **Raspberry Pi Configuration** > **Interfaces** > Habilitar **SSH** y **VNC**

![img](./imagenes/preferencias.jpg)

![img](./imagenes/rpi_config_itf.jpg)

4. Apagamos la tarjeta

5. Abrimos una terminal desde nuestra computadora y escribimos lo siguiente: `nmap -v -sn 192.168.137.1/24`. Lo anterior es para identificar la dirección IP a la cual se conectó la tarjeta. También podemos escribir `nmap 192.168.137.1/24` para obtener un reporte más detallado.

![img](./imagenes/ip_rpi.jpg)

![img](./imagenes/ip_detail.jpg)

6. Abrir **PuTTY** > Ingresar dirección **IP** > Marcar la casilla de **SSH**

![img](./imagenes/putty.jpg)

7. Después se abrirá la siguiente ventana

![img](./imagenes/putty_rpi.jpg)

Aquí debemos ingresar el usuario y contraseña de Raspbian.

En caso de que aparezca lo siguiente `Wi-Fi is currently blocked by rfkill` ejecutamos lo siguiente `sudo raspi-config` y ahora se abrirá la ventana siguiente:

![img](./imagenes/rpi_config.jpg)

Seleccionamos **Localisation Options** > **WLAN Country** > Seleccionar país.

8. Abrir **VNC Viewer** > Ingresar la dirección IP de la Raspberry Pi

![img](./imagenes/vnc_view.jpg)

9. Se abrirá una pestaña e ingresamos usuario y contraseña de Raspbian

![img](./imagenes/vnc_server.jpg)

10. Finalmente visualizaremos el escritorio de Raspbian y estaremos conectados via SSH

![img](./imagenes/rpi_ssh.jpg)
