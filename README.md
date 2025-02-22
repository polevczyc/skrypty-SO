**Skrypty .sh wykonujące proste operacje na plikach i danych.**
 
 ### Skrypt 1
wykorzsytanie instrukcji takich jak: 
```grep```, ```sort```, ```sed```
### Skrypt 2
wykorzystanie instrukcji ```find```
### Skrpyt 3
wykorzsystanie narzędzi takich jak:
```dialog```, ```zenity```
## Script
### Nazwa
Media Organizer
### Funkcjonalność
Skrypt służy do przeszukiwania plików z multimediami znajdujących się w określonym katalogu i przenoszenia ich do odpowiednich folderów. Po przeniesieniu plików, skrypt otwiera program odpowiedni dla danego typu pliku, umożliwiając ich odtwarzanie lub wyświetlanie. Skrypt działa dla każdego użytkownika.
### Działanie
#### Wczytywanie danych konfiguracyjnych:
- Skrypt wczytuje dane konfiguracyjne z pliku ```config.rc```, jeśli istnieje.
#### Tworzenie katalogów:
- Skrypt tworzy katalogi na podstawie danych z pliku ```.rc```. Tworzone są katalogi dla plików audio, wideo, obrazów oraz katalog tymczasowy ```/tmp```.
#### Usuwanie katalogu tymczasowego:
- Skrypt definiuje funkcję, która jest wywoływana przy każdym zamykaniu skryptu i usuwa katalog tymczasowy, w którym przechowywane są foldery utworzone wcześniej.
#### Wyświetlanie dodatkowych opcji:
- Skrypt definiuje funkcje, które wyświetlają krótką pomoc oraz informacje o wersji i autorze skryptu.
#### Przenoszenie plików:
- Skrypt wykonuje przeszukiwanie bieżącego katalogu w poszukiwaniu plików z multimediami. Pliki są wyświetlane na ekranie, a następnie przenoszone do odpowiednich folderów na podstawie ich rozszerzeń. Pliki audio są przenoszone do katalogu ```audio_dir```, pliki wideo do katalogu ```video_dir```, a pliki obrazów do katalogu ```images_dir```.
#### Otwieranie plików: 
- Skrypt umożliwia użytkownikowi wybranie pliku z katalogu tymczasowego. Na podstawie rozszerzenia wybranego pliku, skrypt otwiera go za pomocą odpowiedniego programu.
### Interfejs
- Skrypt wykorzystuje wiersz poleceń jako podstawowy interfejs. Instrukcje oraz informacje o plikach wyświetlane są w terminalu. Wybór plików dokonuje się za pomocą ```Zenity```. Pliki multimedialne otwierane są w programach ```Amberol``` (muzyka i dźwięki), ```VLC``` (filmy) oraz ```Image Viewer``` (zdjęcia i obrazy).
### Wykorzystane narzędzia 
- Zenity
- Amberol
- VLC
- Image Viewer

### Autor
**Jakub Polewczyk** 192562 | [GitHub](https://github.com/polevczyc)
