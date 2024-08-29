# programiranj1-projekt
Mealyev avtomat je končni avtomat, kjer so izhodna stanja odvisna tako od tranzicije kot tudi od trenutnega stanja.
Ta projekta naloga deluej kot mealyev avtomat, ki v podanem besedilu poišče želeno besedo (oziroma poljubno besedilo)
in vrne pozicije, kje v besedilu se nahajajo zadnji elementi najdenih podbesedil in število najdenih vzorcev.


Navodila za uporabo:
Program naložimo in poženemo iz urejevalnika. Tekstovni vmesnik se izpiše v terminalu.
Najprej podamo besedilo, v katerem želimo poiskati pojavitve niza. Nato podamo še niz, ki ga želimo iskati.
Nato program izpiše zaporedje enic in ničel, kjer enice predstavljajo pozicije, kjer se nahajajo zadnji elementi najdenih vzorcev 
in število, koliko ponovitev vzorca je.

Primer:
Vnesi besedilo: test1jjjtst1test1ok
Vnesi vzorec: test1 
"----------
Rezultat: 0000100000000000100
Število pojavitev: 2


Stanje definiramo kot tip, ki vsebuje index, ki ga predstavlja integer, output, ki je predstavljen s stringom in count, ki je prav tako predstavljen kot integer.

Program uporablja Knuth-Morris-Pratt algoritem, da si zapomni delno ujemanje, če je to nepopolno v smislu, če želimo poiskati 
niz "ananas" in se nam v beseilu pojavi "anananas" program ob tretjem n-ju ne začne pregledovati od začetka, vendar ve, da ima še zmeraj delno ujemanje.
če imamo niz, ki se vsaj delno začne na enak način kot se konča in imamo v besedilu prekriti 2 ponovitvi program pokaže le prvo nato pa začne od začetka.
Na primer, če je naš iskani niz "kajaka" in se nam v besedilu pojavi niz "kajakajaka", bi tu program vrnil 0000010000 in ne 0000010001.

Program je sestavljen iz treh funkcij:
-kmp_tabela_calc
-proc_znak
-process_text

Prva funkcija postavi tabelo, da program lahko sledi delnim ujemanjem.
Druga funkcija služi za tranzicije, ki jih opravlja mealyev avtomat, 
zadnja funkcija pa sprocesira podano besedilo skozi avtomat.

Specifični deli kode so prav tako opisani s komentarji v kodi.

