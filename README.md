Automatic Nmap 4 Raspberry PI
==================================

## What

Its a simple Bash script.

Raspbian + Nmap + NmaPi + WiringPi


Plug in a raspberryPi into a guest network and the nmap does a mapping of all computers on the network and what ports are open, and this saves it to a file for later analysis. All is automatically!

Basically the steps are three <-- At least for now.

1) Assign IP by DHCP.

2) Analyzing the network.

3) Creating the report.


The leds are optional, they are just a reference that the process is going well. But it`s looks cool. :)

![](https://lh4.googleusercontent.com/-B8MZPznmNho/UjZvH-zC7fI/AAAAAAAASes/YsjE--DjGP0/s320/Rasp.png)

![](https://lh3.googleusercontent.com/-97XGzZwooRI/UjZw-tSWm9I/AAAAAAAASe4/pySenC_jztQ/s320/Led.png)

 [Video](http://www.youtube.com/watch?v=iubOgQMG2_o)
 

## Dependencies:

* macchanger (optional but recommended)
* nmap
* WiringPi (for the Leds)


## nmaPi.sh


### Running it

Just run:

`./nmaPi.sh`


## nmaPi_term.sh

Is the same as nmaPi.sh, but for PC console, is not as automatic. Useful for testing.


### Running it

`./nmaPiterm.sh [option]`

#### Options
                -h - This Help.

                -f - Fast Scan.
                -d - Deep Scan {Default Option}.
                -q - Quiet Scan.
                

