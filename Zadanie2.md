Generatory liczb pseudolosowych

Generatory liczb pseudolosowych (ang. Pseudo-random number generator — PRNG) są algorytmami generującymi nieskończone ciągi liczb mające wyglądać „losowo”. Dane wejściowe generatora nazywane są ziarnem (ang. seed). Postać tych danych (liczba, ciąg bitów) zależy od konkretnego algorytmu. Wygenerowany ciąg zależy wyłącznie od ziarna. Dla tego samego ziarna generator wygeneruje zawsze ten sam ciąg liczb — jest to algorytm całkowicie deterministyczny.

Generator do działania potrzebuje pewnych roboczych danych. Dane te są nazywane stanem generatora. Początkowy stan generatora wyznaczony jest na podstawie ziarna. W każdym kroku generator generuje jedną liczbę oraz zmienia stan. Bieżący stan generatora jednoznacznie wyznacza to, jaka będzie kolejna wygenerowana liczba oraz to, jaki będzie jego kolejny stan. Oczywiście wygenerowanie kolejnej liczby powinno wiązać się ze zmianą stanu — brak zmiany stanu oznaczałby wygenerowanie w kolejnym kroku tej samej liczby.

Przykłady:

    Liniowy generator kongruencyjny (ang. Linear congruential generator — LCG)

    Generator zdefiniowany jest przez pewne stałe całkowite m, a i c, przy czym m > 0, 0 < a < m, 0 ≤ c < m. Wartość m w praktyce często jest postaci 2n lub 2n−1, np. 232, 231−1.

    Ziarnem jest pewna liczba X0, 0 ≤ X0 < m.

    Początkowy stan to wartość ziarna. Kolejne stany wyznaczone są wzorem Xn = (aXn−1 + c) mod m.

    Jako kolejne generowane liczby można przyjąć po prostu wartości kolejnych stanów: X0, X1, X2, … W zależności od użytych parametrów może to jednak prowadzić do „niewystarczająco losowego” ciągu. W związku z tym wygenerowana liczba często jest w jakiś prosty sposób przekształcana (np. ucinane są najmniej znaczące cyfry z jej reprezentacji binarnej). Oznacza to, że ciągiem wygenerowanych liczb jest f(X0), f(X1), f(X2), …, gdzie f jest funkcją wyznaczającą to przekształcenie.

    Przykład: m = 8, a = 1, c = 3. Przekształceniem f jest ucięcie ostatniego bitu (dzielenie całkowite przez 2).

    Jeżeli ziarnem będzie 4, to kolejnymi stanami będą: 4, 7, 2, 5, 0, 3, 6, 1, 4, …

    X0   =   4,
    X1   =   (1·X0 + 3) mod 8   =   7 mod 8   =   7,
    X2   =   (1·X1 + 3) mod 8   =   10 mod 8   =   2,
    ⋮
    Kolejnymi generowanymi liczbami będą wtedy: 2, 3, 1, 2, 0, 1, 3, 0, 2, …

    Rejestr przesuwający z liniowym sprzężeniem zwrotnym (ang. Linear-feedback shift register — LFSR)

    Generator generuje losowe bity (generowane liczby mają wartość zero lub jeden). Stanem generatora jest rejestr — ciąg bitów o długości n (w praktyce n jest zwykle wielokrotnością ośmiu, np. 8, 16, 32). Ziarnem jest początkowy stan rejestru. Wygenerowanym w każdym kroku bitem jest skrajny prawy bit rejestru. Kolejny stan wyznaczony jest w następujący sposób: mamy daną funkcję f, która dla danego stanu rejestru (wartości wszystkich bitów rejestru) zwraca wartość zero lub jeden (jej wynikiem jest jeden bit). Następnie wszystkie bity rejestru przesuwane są o jeden w prawo (prawy skrajny bit jest usuwany), a na miejsce lewego skrajnego bitu wstawiany jest obliczony wcześniej wynik funkcji. Funkcja użyta do obliczenia nowego bitu powinna spełniać pewne dodatkowe warunki — w praktyce najczęściej używa się operacji XOR wykonanej dla pewnych ustalonych bitów rejestru.

    Przykład: n = 16, r0 = 0010110000110110. Funkcja f zdefiniowana jest jako XOR z jedenastego, trzynastego, czternastego i szesnastego bitu od lewej (szóstego, czwartego, trzeciego i pierwszego od prawej). Kolejne wygenerowane bity oznaczamy przez b0, b1, b2, … Wtedy:

    r0 = 0010110000110110,    b0 = 0,    f(r0) = 1⊕0⊕1⊕0 = 0,
    r1 = 0001011000011011,    b1 = 1,    f(r1) = 0⊕1⊕0⊕1 = 0,
    r2 = 0000101100001101,    b2 = 1,    f(r2) = 0⊕1⊕1⊕1 = 1,
    r3 = 1000010110000110,    b3 = 0,    f(r3) = 0⊕0⊕1⊕0 = 1,
    r4 = 1100001011000011,    b4 = 1,    f(r4) = 0⊕0⊕0⊕1 = 1,
    r5 = 1110000101100001,    b5 = 1,    f(r5) = 1⊕0⊕0⊕1 = 0,
    r6 = 0111000010110000,    b6 = 0,    f(r6) = 1⊕0⊕0⊕0 = 1,
    r7 = 1011100001011000,    b7 = 0,    f(r7) = 0⊕1⊕0⊕0 = 1,
    r8 = 1101110000101100,    b8 = 0,    f(r8) = 1⊕1⊕1⊕0 = 1,
    r9 = 1110111000010110,    b9 = 0,    f(r9) = 0⊕0⊕1⊕0 = 1,
    ⋮

Implementacja ogólnego generatora

Generator liczb pseudolosowych może być w Haskellu reprezentowany przez funkcję, która jako parametr przyjmuje ziarno (dowolnego typu) i zwraca nieskończoną listę liczb ([Integer]). Typ takiej funkcji można np. zdefiniować jako

type PRNG seed = seed -> [Integer]

gdzie seed jest typem ziarna.

Generator możemy też opisać za pomocą dwóch funkcji. Pierwsza z nich wyznacza początkowy stan generatora na podstawie ziarna, druga — na podstawie stanu generatora wyznacza wygenerowaną liczbę oraz kolejny stan. Jeżeli typ ziarna oznaczymy przez seed, a typ stanu przez state, to typem pierwszej z funkcji może być

seed -> state,

a drugiej

state -> (state, Integer).

Załóżmy, że mamy np. generator, który dla zakresu zadanego przez dwie liczby całkowite zwraca ostatnie cyfry kolejnych liczb z zadanego zakresu. Po wyczerpaniu się liczb z zakresu generator wraca do początkowego stanu i generuje od nowa te same liczby. Np. dla zakresu zadanego przez liczby 19 i 23 generowanymi liczbami będą kolejno 9, 0, 1, 2, 3, 9, 0, 1, … Oczywiście nie jest to zbyt dobry generator (zwracane wartości zupełnie nie wyglądają losowo), ale pozwala pokazać opisywany mechanizm.

Ziarnem jest zakres. Można go reprezentować krotką liczb: (Integer, Integer), np. (19, 23). Stan może składać się z trzech liczb: (Integer, Integer, Integer) — oprócz zakresu można przechowywać bieżącą wartość, np. dla powyższych wartości początkowym stanem może być (19, 23, 19), a po wygenerowaniu pierwszych dwóch liczb będzie to (19, 23, 21). Powyższe dwie funkcje mogłyby wtedy być zdefiniowane następująco:

type Seed = (Integer, Integer)
type State = (Integer, Integer, Integer)

rInit :: Seed -> State
rInit (begin, end) = (begin, end, begin)

rStep :: State -> (State, Integer)
rStep (begin, end, current)
    | current == end     = ((begin, end, begin), mod current 10)
    | otherwise          = ((begin, end, current + 1), mod current 10)
                

Przykłady ich użycia:

> rInit (19, 21)
(19,21,19)

> rStep (19, 21, 19)
((19,21,20),9)

> rStep (19, 21, 20)
((19,21,21),0)

> rStep (19, 21, 21)
((19,21,19),1)
    

Napisz funkcję

prng :: (seed -> state) -> (state -> (state, Integer)) -> (seed -> [Integer])
    

Tworzącą generator na podstawie dwóch funkcji — funkcji tworzącej stan na podstawie ziarna i funkcji opisującej pojedynczy krok generatora. Np. opisany powyżej generator można stworzyć tak:

rGen = prng rInit rStep

i użyć tak:

rGen (19, 33)
[9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,9,0,1,2,3,4,
5,6,7,8,9,0,1,2,3,9,0,1,2,3,4,5,6,7,8,9,0,1
,2,3,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,9,0,1,2,
3,4,5,6,7,8,9,0,1,2,3,9,0,1,2,3,4,5,6,7,8,9
,0,1,2,3,9,0,1,2,3,4,5,6,7,8,...
        

Implementacja generatorów LCG i LFSR

Napisz odpowiednie pary funkcji dla generatorów LCG (lcgInit, lcgStep) i LFSR (lfsrInit, lfsrStep).

W przypadku generatora LCG zarówno parametry m, a, c jak i ziarno oraz stan reprezentowane są za pomocą typu Integer. Odpowiednie funkcje mają mieć sygnatury:

lcgInit :: Integer -> Integer

lcgStep :: Integer -> Integer -> Integer -> (Integer -> Integer) -> Integer -> (Integer, Integer) — funkcja przyjmuje jako parametry kolejno wartości m, a, c, funkcję f oraz stan.

Przykłady użycia:

> lcgInit 7
7

> lcgInit 3
3

> lcgStep 8 1 3 (`div` 2) 4
(7,2)

> lcgStep (2^31) 1103515245 12345 id 5
(1222621274,5)

> lcgStep (2^31) 1103515245 12345 id 1222621274
(554244747,1222621274)
            

Generator z przykładu można wtedy stworzyć tak:

lcgExampleGen = prng lcgInit (lcgStep 8 1 3 (`div` 2))

i użyć tak:

> lcgExampleGen 4
[2,3,1,2,0,1,3,0,2,...
            

Drugim argumentem funkcji prng powinna być funkcja dostająca jeden parametr, czyli stan. Funkcja lcgStep ma pięć parametrów, z których stan jest ostatni. Natomiast wywołanie jej z czterema argumentami daje w wyniku właśnie funkcję, która potrzebuje już tylko jednego argumentu — właśnie stanu.

W przypadku generatora LFSR ziarno ma być reprezentowane przez liczbę całkowitą (Integer). Natomiast stan ma być listą bitów — [Integer]. Bity w rejestrze są binarną reprezentacją ziarna o zadanej długości w kolejności od najbardziej do najmniej znaczącej cyfry. Np. liczba 5 użyta jako ziarno będzie w przypadku rejestru 8-bitowego przekształcona do listy [0,0,0,0,0,1,0,1].

Funkcja przekształcająca ziarno na stan początkowy będzie zatem miała sygnaturę:

lfsrInit :: Int -> Integer -> [Integer]

Pierwszy argument oznacza liczbę bitów rejestru.

Funkcja implementująca krok generatora będzie miała sygnaturę:

lfsrStep :: ([Integer] -> Integer) -> [Integer] -> ([Integer], Integer)

Pierwszy argument funkcji lfsrStep oznacza funkcję używaną do wyznaczenia nowego bitu na podstawie stanu rejestru.

Przykłady użycia:

> lfsrInit 16 11318
[0,0,1,0,1,1,0,0,0,0,1,1,0,1,1,0]

> lfsrInit 8 5
[0,0,0,0,0,1,0,1]

> lfsrStep last [0,0,0,1]
([1,0,0,0],1)

> lfsrStep ((`mod` 2) . sum) [0, 0, 0, 0, 1, 1, 0, 1]
([1,0,0,0,0,1,1,0],1)
            

W celu implementacji generatora LFSR z przykładu napisz następujące funkcje

xor :: Integer -> Integer -> Integer — realizuje operację XOR (ma działać poprawnie dla wartości argumentów 0 i 1).

xorList :: [Integer] -> Integer — oblicza wynik operacji XOR dla listy bitów.

xor_11_13_14_16 :: [Integer] -> Integer — oblicza wynik operacji XOR wykonanej na jedenastym, trzynastym, czternastym oraz szesnastym bicie szesnastosbitowego rejestru.

Przykłady użycia:

> xor 1 0
1

> xor 1 1
0

> xorList [1, 1, 1]
1

> xorList [1, 0, 1, 0]
0

> xor_11_13_14_16 [0,0,1,0,1,1,0,0,0,0,1,1,0,0,1,0]
1
            

Po zaimplementowaniu powyższych funkcji generator z przykładu można stworzyć tak:

lfsrExampleGen = prng (lfsrInit 16) (lfsrStep xor_11_13_14_16)

Użyć go można tak (11318 to dziesiętny zapis liczby binarnej 0010110000110110 — ziarna użytego w przykładzie):

> lfsrExampleGen 11318
[0,1,1,0,1,1,0,0,0,0,...]
            

Konwersje pomiędzy liczbami a bitami

Niektóre generatory liczb pseudolosowych wygodniej jest definiować jako algorytmy generujące liczby z pewnego zakresu, a niektóre jako algorytmy generujące pojedyncze bity. Napisz dwie funkcje umożliwiające konwersje między listą bitów a listą liczb:

bitsToIntegers :: Int -> [Integer] -> [Integer]

integersToBits :: Int -> [Integer] -> [Integer] 
            

Pierwsza z nich zamienia ciąg bitów (zer i jedynek) na ciąg liczb. Pierwszy argument oznacza liczbę bitów, z których skonstruowana jest każda liczba. Skonstruowana liczba jest po prostu wartością liczby zapisanej w systemie binarnym w kolejności od bardziej znaczących cyfr. Druga funkcja wykonuje odwrotne przekształcenie. Poniżej są sygnatury funkcji i przykłady ich użycia:

bitsToIntegers :: Int -> [Integer] -> [Integer]

integersToBits :: Int -> [Integer] -> [Integer] 

> bitsToIntegers 3 [1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0]
[5,7,0,2]

> integersToBits 8 [1, 3, 255, 128]
[0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0]
            

Uwagi:

    Funkcje nie muszą wykrywać błędnych danych. Jeżeli np. funkcja oczekuje parametru oznaczającego liczbę bitów, to nie ma znaczenia jak będzie się zachowywać dla wartości ujemnej. Może np. dać błędne wyniki, zgłosić błąd lub się zapętlić. Podobnie np. nie ma znaczenia wynik funkcji xor dla argumentów innych niż 0 i 1.
