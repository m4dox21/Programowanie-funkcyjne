Informacje z numeru PESEL

    Napisz następujące funkcje zwracające następujące informacje wyciągnięte z zadanego numeru PESEL:

    plec :: [Char] -> Char
        — płeć jako pojedynczy znak ('k' — kobieta, 'm' — mężczyzna),
    rok :: [Char] -> Int
        — rok urodzenia,
    miesiac :: [Char] -> Int
        — miesiąc urodzenia,
    dzien :: [Char] -> Int
        — dzień urodzenia,
    cyfraKontrolna :: [Char] -> Int
        — cyfra kontrolna — ostatnia cyfra numeru PESEL,
    obliczonaCyfraKontrolna :: [Char] -> Int
        — cyfra kontrolna obliczona na podstawie pierwszych dziesięciu cyfr numeru.

    Powyższe funkcje mogą założyć, że PESEL przekazany jako argument jest napisem (listą znaków) o długości 11 składającym się z samych cyfr. Mogą również założyć, że zakodowana data urodzenia jest poprawna. Nie ma znaczenia jak będą się zachowywać dla numeru PESEL niespełniającego któregoś z tych warunków (nie muszą ich w żaden sposób sprawdzać) — mogą zgłaszać błąd, dawać bezsensowne wyniki lub np. zapętlać się.

    W poprawnym numerze PESEL funkcje cyfraKontrolna i obliczonaCyfraKontrolna powinny zwracać tę samą wartość, ale oczywiście obie funkcje powinny działać również dla numerów niespełniających tego warunku. Funkcje te zwracają wartość liczbową cyfry kontrolnej, czyli liczbę całkowitą (Int) a nie znak (Char).
    Sprawdzanie poprawności numeru PESEL

    Napisz następujące funkcje sprawdzające poprawność numeru PESEL:

    poprawnaCyfraKontrolna :: [Char] -> Bool
        Funkcja sprawdza, czy zakodowana cyfra kontrolna zgadza się z obliczoną.
    poprawnaData :: [Char] -> Bool
        Funkcja sprawdza, czy zakodowana data jest poprawna. Funkcja musi sprawdzić, czy poprawny jest zakodowany miesiąc (musi być z zakresu 1–12) oraz dzień. W przypadku dnia zakres poprawnych wartości zależy od miesiąca. W przypadku lutego należy również uwzględnić to, czy rok jest przestępny.
    poprawnyPesel :: [Char] -> Bool
        Funkcja sprawdza poprawność numeru PESEL. Sprawdzana jest poprawność składniowa (napis o długości 11 złożony z samych cyfr dziesiętnych) oraz poprawność daty i cyfry kontrolnej.

    Listy numerów PESEL

    Napisz następujące funkcje operujące na listach numerów PESEL (typ [[Char]]):

    poprawnePesele :: [[Char]] -> Bool
        — czy wszystkie PESELe w liście są poprawne,
    liczbyPlci :: [[Char]] -> (Int,Int)
        — zwraca krotkę; pierwszy element krotki to liczba kobiet, drugi — liczba mężczyzn,
    najmlodszy :: [[Char]] -> (Int,Int,Int)
        — najpóźniejsza data urodzenia spośród wszystkich PESELi jako krotka (rok, miesiąc, dzień),
    najstarszy :: [[Char]] -> (Int,Int,Int)
        — najwcześniejsza data urodzenia spośród wszystkich PESELi jako krotka (rok, miesiąc, dzień).

Przydatne odnośniki:

*  [Czym jest numer pesel](https://www.gov.pl/web/gov/czym-jest-numer-pesel)
  
*  [Sprawdź numer PESEL](https://sprawdz-numer.com/pesel)
  
*  [Generator numerów PESEL](http://pesel.felis-net.com/)
  
*  [Rok przestępny — Wikipedia](https://pl.wikipedia.org/wiki/Rok_przest%C4%99pny)
      
