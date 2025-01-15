#!/bin/bash
a=$'Witamy w wypożyczalni samochodów używanych Pol-Car. W naszej ofercie znajdują się modele aut niemieckich z lat 2000-2005.\nProsimy podać parametry auta, które Cię interesuje.\n\nPodaj markę auta, wpisując odpowiednią cyfrę:\n|1| Audi\n|2| BMW\n|3| Mercedes-Benz'
echo "" ; echo "$a" ;
while true; do
	read BRAND
	if [[ $BRAND = 1 || $BRAND = 2 || $BRAND = 3 ]] ; then
		echo "Wybrano markę." ;
	else
		echo "Podaj poprawną nazwę."
		continue ;
	fi ;
	break ;
done
case $BRAND in
	"1") BRAND="Audi" ;;
	"2") BRAND="BMW" ;;
	"3") BRAND="Mercedes-Benz" ;;
esac
grep $BRAND samochody.txt >> filtr1.txt
echo ""
a=$'Wybierz rodzaj skrzyni biegów, wpisując odpowiednią cyfrę:\n|1| manualna\n|2| automatyczna'
echo "$a"
while true; do
	read GEARBOX
	if [[ $GEARBOX = 1 || $GEARBOX = 2 ]] ; then
		echo "Wybrano skrzynię biegów." ;
	else
		echo "Podaj poprawną nazwę."
		continue ;
	fi ;
	break ;
done
case $GEARBOX in
	"1") GEARBOX="manual" ;;
	"2") GEARBOX="automat" ;;
esac
grep $GEARBOX filtr1.txt >> filtr2.txt
rm filtr1.txt
echo ""
a=$'Wybierz rodzaj nadwozia, wpisując odpowiednią cyfrę:\n|1| sedan\n|2| kombi'
echo "$a"
while true;
do
	read BODY
	if [[ $BODY = 1 || $BODY = 2 ]] ; then
		echo "Wybrano nadwozie." ;
	else
		echo "Podaj poprawną nazwę."
		continue ;
	fi ;
	break ;
done
case $BODY in
	"1") BODY="sedan" ;;
	"2") BODY="kombi" ;;
esac
grep $BODY filtr2.txt >> filtr3.txt
rm filtr2.txt
echo "" ; echo "Oto lista aut w naszej ofercie spełniających podane wymagania." ;
echo "" ; echo "Przedstawiamy modele od najnowszych rocznikowo: " ; echo ""
column -t -s $'@' filtr3.txt >> final.txt
rm filtr3.txt
sort -k 3 -r -o final.txt final.txt
FILENAME=final.txt
if [ ! -z "${FILENAME}" ]; then
	sed = final.txt | sed 'N;s/\n/   /'
else
	echo "Niestety wszystkie auta o podanych specyfikacjach zostały wypożyczone."
fi
rm final.txt
