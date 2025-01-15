#!/bin/bash
echo "Witamy w eksploratorze plików stron internetowych." ; echo ""
echo "Co chciałbys zrobić? (podaj odpowiednia cyfre)"
echo "|1| Wyszukaj pliki o podanym rozszerzeniu"
echo "|2| Pokaz liczbę plików i folderów w obecnym katalogu"
echo "|3| Wykonaj kopię zapasową plików w obecnym katalogu"
echo "|4| Usuń folder z kopią zapasową"
while true; do
	read -p "opcja nr: " choice
	if [[ "$choice" == "1" ]]; then
	    echo "Wyszukiwanie plików po rozszerzeniu." ; echo ""
	    echo "Które pliki chcesz wyszukać? (podaj odpowiednią cyfre)"
	    echo "|1| dokumenty HTML"
	    echo "|2| arkusze CSS"
	    echo "|3| skrypty JS"
	    echo "|4| obrazy"
	    while true; do
		read file_type
		if [[ "$file_type" == "1" ]]; then
		    file_type_count=$(find . -name "*.html" -type f | wc -l)
		    echo "Znaleziono "$file_type_count" plików ze strukturami stron internetowych:"
		    find . -name "*.html"
		elif [[ "$file_type" == "2" ]]; then
		    file_type_count=$(find . -name "*.css" -type f | wc -l)
		    echo "Znaleziono "$file_type_count" plików z arkuszami stylow:"
		    find . -name "*.css"
		elif [[ "$file_type" == "3" ]]; then
		    file_type_count=$(find . -name "*.js" -type f | wc -l)
		    echo "Znaleziono "$file_type_count" plików ze skryptami:"
		    find . -name "*.js"
		elif [[ "$file_type" == "4" ]]; then
		    file_type_count=$(find . -name "*.jpg" -type f | wc -l)
		    echo "Znaleziono "$file_type_count" obrazy:"
		    find . -name "*.jpg"
		else
		    echo "Wybierz poprawną opcje."
		    continue
		fi
	    break
	    done
	elif [[ "$choice" == "2" ]]; then
	    find $curr_dir
	    echo ""
	    file_count=$(find . -type f | wc -l)
	    echo "Liczba plików w katalogu: $file_count"
	    folder_count=$(find . -type d | wc -l)
	    echo "Liczba folderów w katalogu: $folder_count"
	elif [[ "$choice" == "3" ]]; then
	    curr_dir=$(pwd)
	    Backup="$curr_dir/Backup"
	    if [ -d "$Backup" ]; then
		rm -r "$Backup"
	    fi
	    mkdir -p "$Backup"
	    chmod 777 "$Backup"
	    find . -type f -not -path "./Backup/*" -not -name "file_analyzer.sh" -exec cp --parents {} "$Backup" \;
	    echo "Wykonano kopię zapasową."
	    ls -l
	elif [[ "$choice" == "4" ]]; then
	    if [ -d "Backup" ]; then
		find "Backup" -type d -exec rm -r {} \;  2>/dev/null
		echo "Usunięto folder z kopią zapasową."
		ls -l
	    else
		echo "Folder z kopią zapasową nie istnieje."
	    fi
	else echo "Wybierz poprawną opcję."
	continue
	fi
break
done
