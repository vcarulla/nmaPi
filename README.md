Automatic Nmap 4 Raspberry PI
==================================

## Que

Es un simple script en bash.

Raspbian + Nmap + WiringPi + NmaPi

Conecte el raspberryPi en una red invitado y el nmap comenzara a mapear todas las computadoras de la red y los puertos que tenga abiertos. Todo esto de forma automática.

Básicamente los pasos son tres. <-- Al menos por ahora.

1) Asigna IP por DHCP.

2) Analiza la red.

3) Crea un reporte.


Los leds son opcionales, son solo una referencia de que el proceso marcha bien. Pero quedan muy bien :)


![](https://lh4.googleusercontent.com/-B8MZPznmNho/UjZvH-zC7fI/AAAAAAAASes/YsjE--DjGP0/s320/Rasp.png)

![](https://lh3.googleusercontent.com/-97XGzZwooRI/UjZw-tSWm9I/AAAAAAAASe4/pySenC_jztQ/s320/Led.png)

 [Video](http://www.youtube.com/watch?v=iubOgQMG2_o)
 

## Dependencias:

* macchanger (opcional pero recomendado)
* nmap
* WiringPi (para los leds)


## nmaPi.sh


### Ejecución

Solo hacerlo la 1era ves:

* Marcar como ejecutable `chmod +x nmapi.sh`
* Copiarlo en init.d `cp nmapi.sh /etc/init.d`
* Y actualizar `update-rc.d nmapi.sh defaults`

-Con esto, el scrip arrancará automáticamente en cada booteo-


## nmaPi_term.sh

Es lo mismo que el nmaPi.sh, pero para la consola de la Pc, no es tan automático. Útil para pruebas.


### Ejecución

`./nmaPiterm.sh [opción]`

#### Opciones
                -h - Esta Ayuda.

                -f - Escaneo Rápido.
                -d - Escaneo Profundo {Opción por defecto}.
                -q - Escaneo Silencioso.
