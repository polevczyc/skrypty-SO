#!/bin/bash
run_option_1() {
    numbers=()
    for ((i=1; i<=6; i++)); do
        numbers+=($((RANDOM % 100)))
    done
    dialog --title "Lotto" --msgbox "\nLosuję liczby..." 12 50
    dialog --title "Lotto" --msgbox "\nTwoje wylosowane liczby to:\n${numbers[*]}" 12 50
}
run_option_2() {
    TEXT=$(zenity --entry --title="Długość tekstu" --text="Wprowadź tekst:" 2>/dev/null)
    dialog --title "Długość tekstu" --msgbox "\nDługość wprowadzonego tekstu to ${#TEXT} znaków." 12 50
}
run_option_3() {
    dialog --title "Kolory" --msgbox "\nWybierz kolor, aby otrzymać jego kod RGB" 12 50
    COLOR=$(zenity --color-selection --title="Wybierz swój kolor" --text="Wybierz swój kolor:" 2>/dev/null)
    dialog --title "Wybrany kolor" --msgbox "\nWybrano kolor: $COLOR" 12 50
}
run_option_4() {
    dialog --title "Rozmiar pliku" --msgbox "\nWybierz plik, aby sprawdzić jego rozmiar." 12 50
    FILE=$(zenity --file-selection --title="Wybierz plik" --text="Wybierz plik:" 2>/dev/null)
    if [[ -n $FILE ]]; then
        FILE_SIZE=$(stat -c "%s" "$FILE")
        dialog --title "Rozmiar pliku" --msgbox "\nWybrano plik:\n$FILE.\n\nRozmiar wybranego pliku to $FILE_SIZE B." 12 50
    else
        dialog --title "Błąd" --msgbox "\nNie wybrano pliku." 12 50
    fi
}
while true; do
    OPTION=$(dialog --backtitle "192562 | Jakub Polewczyk" --cancel-label "Wyjście"\
        --title "Witamy w Dial-Zen 3000!" \
        --menu "Wybierz program:" 12 50 4 \
        1 "Lotto" \
        2 "Długość tekstu" \
        3 "Kolory" \
        4 "Rozmiar pliku" \
        2>&1 >/dev/tty)
    case "$OPTION" in
        1)
            run_option_1
            ;;
        2)
            run_option_2
            ;;
        3)
            run_option_3
            ;;
        4)
            run_option_4
            ;;
        *)
            dialog --title "Wyjście"
            exit 0
            ;;
    esac
done
