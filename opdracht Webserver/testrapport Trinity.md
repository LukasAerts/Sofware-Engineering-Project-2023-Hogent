# Testrapport Opdracht web server Trinity

## Test Server Trinity deployen

**Resultaat**

- laatste lijn van output was "Vagrant has completed building server trinity successfully!" + geen error exits -> verwachte resultaat, test geslaagd

## Test SSH connectie met username en wachtwoord

**Resultaat**

- Geen wachtwoord promt  + permission denied melding -> verwachte resultaat, test geslaagd

## Test SSH connectie met username root

**Resultaat**

- Geen wachtwoord promt  + permission denied melding -> verwachte resultaat, test geslaagd

## Test SSH connecite met pubic key van test machine aanwezig op Trinity

**Resultaat**

- Krijg prompt vagrant@trinity in mijn terminal -> verwachte resultaat, test geslaagd

## Test SSH connecite met username root + pubic key van test machine aanwezig op Trinity

**Resultaat**

- Geen wachtwoord promt  + permission denied melding -> verwachte resultaat, test geslaagd

## Test nmap scan van server mag geen info of vesie geven je web services (apache en nginx) + test poorten nginx

**Resulaat**

- enkel 3 poorten open: 22/tcp SSH, 80/tcp (HTTP) en 443/tcp (HTTPS) -> ok 
- poort 9090/tcp gesloten service zeus-admin, geen versie nummer -> ok 
- Geen versie nummers te zien naast nginx voor poorten 80 en 443 -> ok
- Wel versie van openssh te zien voor poort 22 -> nok maar ok omdat het geen requirement is

## Test reverse proxy moet zowel http als https ondersteunen + test werkt rallly en wordpress site

**Resultaat**

- Wordpress website: ik wordt  geriderect naar https indien ik http gebruik (voor zowel met en zonder www) en browser toont dat website beschermd is met onze self-signed ssl certificaat -> verwachte resultaat, test geslaagd
- Rallly website: ik wordt geriderect naar https indien ik http gebruik (voor zowel met en zonder www) en browser toont dat website beschermd is met onze self-signed ssl certificaat -> verwachte resultaat, test geslaagd
- meteen surfen via https (voor zowel met en zonder www) naar rallly of de wordpress website werkt ook -> verwachte resultaat, test geslaagd

# Test beide website en app moeten gelijkertijd bereikbaar zijn + test werkt rallly en wordpress site

**Resultaat**

- ik kreeg 4 tabs voor  https://rallly.thematrix.local en 4 tabs voor https://thematrix.local -> -> verwachte resultaat, test geslaagd


Uitvoerder(s) test: Naoufal Thabet
Uitgevoerd op: 16/05
