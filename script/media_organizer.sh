#!/bin/bash

###########################################
# Licencja: GNU GPLv2
# Autor: Jakub Polewczyk 192562
# Opis działania: Skrypt przeszukuje pliki z multimediami i przenosi je do odpowiednich folderów. Następnie otwiera program odpowiedni dla danego typu pliku.
###########################################

# Wczytywanie danych konfiguracyjnych z pliku .rc
config_file="config.rc"
if [[ -f "$config_file" ]]; then
	source "$config_file"
else 
	echo "Brak pliku .rc. Program zostanie zamknięty"
	exit 1
fi

# Tworzenie katalogów z multimediami ora zkatalogu /tmp na podstawie danych z pliku .rc
mkdir -p "$audio_dir" "$video_dir" "$images_dir" "$media_dir"

# Funkcja usuwania katalogu tmp
rm_tmp_dir() {
	rm -R $media_dir
}

# Usuwanie katalogu tymczasowego
trap rm_tmp_dir EXIT

# Funkcja wyświetlająca krótką pomoc
print_help() {
	echo "Użycie: media_organizer.sh [opcje]"
	echo "Opcje:"
	echo "  -v      Wyświetla wersję skryptu i informacje o autorze"
	echo "  -h      Wyświetla tę pomoc"
}

# Funkcja wyświetlająca informacje o wersji i autorze
print_version() {
	echo "Media Organizer - wersja 1.0"
	echo "Autor: Jakub Polewczyk 192562"
}

# Funkcja przenosząca pliki do odpowiednich folderów
organize_files() {
	echo "Wyszukuję pliki z multimediami w obecnym katalogu..."
	
	# Wyświetlanie plików z multimediami
	files_found=0
	for file in *.{mp3,flac,mp4,avi,jpg,jpeg,png,gif}; do
    		if [ -f "$file" ]; then
        		echo "$file"
        		files_found=1
    		fi
	done
	if [ $files_found -eq 0 ]; then 
		echo "Brak plików z multimediami. Program zostanie zakończony."
		exit 1
	else
		read -p "(kliknij Enter, aby kontynuować)"
	fi ;
	echo ""
	echo "Organizuję pliki..." 
	
	# Przeszukiwanie plików w bieżącym katalogu
	copied_files=0
	for file in *; do
		if [[ -f "$file" ]]; then
			extension="${file##*.}"
			case $extension in
                		mp3|flac)
                    			cp "$file" "$audio_dir/"
                    			copied_files=$((copied_files+1)) ;;
                		mp4|avi)
                    			cp "$file" "$video_dir/"
                    			copied_files=$((copied_files+1)) ;;
                		jpg|jpeg|png|gif)
                			cp "$file" "$images_dir/"
                			copied_files=$((copied_files+1)) ;;
                		*)
                    			;;
                    	esac
        	fi
    	done
    	echo "Pliki zostały posortowane. Przeniesione pliki: $copied_files"
}

open_zenity() {
	echo ""
	cd $media_dir
	selected_file=$(zenity --file-selection --title "Wybierz plik")

	# Sprawdzanie, czy użytkownik wybrał plik
	if [ -n "$selected_file" ]; then
    		file_extension="${selected_file##*.}"
    
    		case "$file_extension" in
        		mp3|flac)
            			amberol "$selected_file" 2>/dev/null ;;
        		mp4|avi)
            			vlc "$selected_file" 2>/dev/null ;;
        		png|jpg|jpeg|gif)
        			eog "$selected_file" 2>/dev/null ;;
        	esac
	else
    		echo "Nie wybrano pliku. Program zostanie zamknięty."
    		exit 1
	fi
}

# Funkcja uruchamiająca program właściwy dla danego pliku
open_file() {
	# Sprawdzanie, czy Zenity jest zainstalowany
	if ! command -v zenity &> /dev/null; then
		echo "Zenity nie jest zainstalowany. Czy chcesz go zainstalować teraz? (tak/nie)"
		while true ; do
			read a
			if [ "$a" = "tak" ]; then
				echo "Instaluję program zenity..."
				sudo apt-get install -y zenity
				open_zenity
			elif [ "$a" = "nie" ]; then
				read -p "Nie można kontynuować skryptu. Program zostanie zakończony"
				exit 1
			else
				echo "Nieprawidłowa wartość. Spróbuj jeszcze raz."
				continue ;
			fi ;
		break ;
		done ;
	else open_zenity
	fi
}

# Sprawdzanie opcji wiersza poleceń
while getopts ":vh" option; do
	case $option in
		v)
			print_version
			exit ;;
		h)
			print_help
			exit ;;
		\?)
			echo "Błędna opcja: -$OPTARG"
			print_help
			exit 1 ;;
	esac
done

# Wywołanie funkcji przenoszącej pliki
organize_files

# Wywołanie funkcji otwierającej plik w programie
while true; do
	echo "Wybierz opcję: "
	echo "|1| otwórz plik"
	echo "|2| zamknij program"
	read a
	if [ "$a" = "2" ]; then
		echo "Program zostanie zakończony."
		exit 1
	elif [ "$a" = "1" ]; then
		open_file
	else 
	continue;
	fi;
done;

