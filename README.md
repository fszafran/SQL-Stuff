ZADANIE

Korzystając z modelu pojęciowego bazy BDOT10k proszę wykonać schemat bazy w PostgreSQL zawierający
klasy: OT_SWRS_L, OT_SWKN_L , OT_SWRM_L oraz wszystkie klasy i atrybuty z nimi powiązane lub
dziedziczone.
Należy zadbać o wszystkie elementy, które zapewnią integralność danych oraz możliwość efektywnego dostępu
do danych (ograniczenia, indeksy itp.). Dla wskazanych klas wykonać należy widoki zmaterializowane, które
będą zawierać kilka najważniejszych atrybutów oraz pełne wartości słownikowe.
Należy zadbać o wszystkie cechy, które spowodują, że w powstałym schemacie będzie można przechowywać
i wydajnie korzystać z danych przestrzennych (atrybuty przestrzenne o właściwych typach, indeksy
przestrzenne).

AUTOMATYZACJA PROCESÓW

Proszę wykonać mechanizmy, które w powstałym schemacie:
1. Po wykryciu próby tworzenia nowych obiektów w tabelach ot_swrs_l, ot_swkn_l, ot_swrm_l
wprowadzą odpowiedni wpis o dacie utworzenia, o autorze do odpowiednich pól.

PRZETWARZANIE DANYCH

Napisz funkcję, która:
1. Utworzy tabelę raster_cieki o strukturze (id serial (PK), geom(geometry), liczba_rs(integer),
srednia_rs(text), liczba_kn(integer), srednia_kn(text), liczba_rm(integer), srednia_rm(text)). Jeżeli taka
tabela była wcześniej, zostanie usunięta.
2. Do tabeli raster_cieki wprowadzi obiekty w taki sposób, żeby tworzyły na mapie sieć kwadratów,
których długość boku jest podana jako parametr funkcji, a które w sumie zajmują obszar taki jak
sumaryczny zasięg obiektów z klas ot_swrs_l, ot_swkn_l, ot_swrm_l. Warto przyjąć dopuszczalne
wartości długości boku kwadratu i kontrolować zgodność z tym kryterium danych wprowadzanych jako
parametr funkcji.
3. Dla każdego z obiektów wykonanych w pkt. 2. wykonana zostanie operacja:
a. wybrane zostaną obiekty z każdej z klas ot_swrs_l, ot_swkn_l, ot_swrm_l, których centroidy
zawierają się danym kwadracie,
b. dla każdego iterowanego rekordu do odpowiedniego atrybutu wprowadzona zostanie liczba
obiektów, które zostały wybrane oraz średnia wartość ich długości.
