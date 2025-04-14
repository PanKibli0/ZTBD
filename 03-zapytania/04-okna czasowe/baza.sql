-- OKNA CZASOWE

-- Liczba klient�w miesi�cznie wg producenta i typu nap�du
SPOOL wynik1.txt

SELECT 
    dane.MIESIAC,
    producent.NAZWA AS NAZWA_PRODUCENTA,
    typ_nap.NAZWA AS NAZWA_TYPU_NAPEDU,
    agg.LICZBA_KLIENTOW,
    SUM(agg.LICZBA_KLIENTOW) OVER (PARTITION BY producent.NAZWA ORDER BY agg.MIESIAC) AS SUMA_NARASTAJACO
FROM (
    SELECT 
        TO_CHAR(wyp.DATA_WYPOZYCZENIA, 'YYYY-MM') AS MIESIAC,
        model.ID_PRODUCENT,
        skuter.ID_TYP_NAPEDU,
        COUNT(DISTINCT wyp.ID_KLIENT) AS LICZBA_KLIENTOW
    FROM WYPOZYCZENIA wyp
    JOIN SKUTER skuter ON wyp.ID_SKUTER = skuter.ID
    JOIN MODEL model ON skuter.ID_MODEL = model.ID
    GROUP BY TO_CHAR(wyp.DATA_WYPOZYCZENIA, 'YYYY-MM'), model.ID_PRODUCENT, skuter.ID_TYP_NAPEDU
) agg
JOIN PRODUCENT producent ON agg.ID_PRODUCENT = producent.ID
JOIN TYP_NAPEDU typ_nap ON agg.ID_TYP_NAPEDU = typ_nap.ID;


SPOOL OFF;
----------------------------------------------------------------------------------------------------------------------
--Sprawdzenie, jak zmienia si� �rednia roczna liczba wypo�ycze� skuter�w poszczeg�lnych producent�w w zale�no�ci od rodzaju p�atno�ci.

SPOOL wyniki2.txt

SELECT 
    producent.NAZWA AS NAZWA_PRODUCENTA,
    platnosc.NAZWA AS NAZWA_RODZAJU_PLATNOSCI,
    agg.ROK,
    agg.LICZBA_WYPOZYCZEN,
    AVG(agg.LICZBA_WYPOZYCZEN) OVER (
        PARTITION BY producent.NAZWA, agg.ROK
    ) AS SREDNIA_ROCZNA_DLA_PRODUCENTA
FROM (
    SELECT 
        EXTRACT(YEAR FROM wyp.DATA_WYPOZYCZENIA) AS ROK,
        model.ID_PRODUCENT,
        wyp.ID_RODZAJ_PLATNOSCI,
        COUNT(wyp.ID_SKUTER) AS LICZBA_WYPOZYCZEN
    FROM WYPOZYCZENIA wyp
    JOIN SKUTER skut ON wyp.ID_SKUTER = skut.ID
    JOIN MODEL model ON skut.ID_MODEL = model.ID
    GROUP BY EXTRACT(YEAR FROM wyp.DATA_WYPOZYCZENIA), model.ID_PRODUCENT, wyp.ID_RODZAJ_PLATNOSCI
) agg
JOIN PRODUCENT producent ON agg.ID_PRODUCENT = producent.ID
JOIN RODZAJ_PLATNOSCI platnosc ON agg.ID_RODZAJ_PLATNOSCI = platnosc.ID
ORDER BY agg.ROK, NAZWA_PRODUCENTA, NAZWA_RODZAJU_PLATNOSCI;

SPOOL OFF;
----------------------------------------------------------------------------------------------------------------------
--Liczba wypozyczen miesiecznie z podzialem na wypozyczalnie i producentow oraz ich srednia

SPOOL wynik3.txt

SELECT 
    agg.MIESIAC,
    wypozyczalnia.NAZWA AS NAZWA_WYPOZYCZALNI,
    producent.NAZWA AS NAZWA_PRODUCENTA,
    agg.LICZBA_WYPOZYCZEN,
    round(AVG(agg.LICZBA_WYPOZYCZEN) OVER (PARTITION BY wypozyczalnia.NAZWA, producent.NAZWA ORDER BY agg.MIESIAC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2) AS SREDNIA_LICZBA_WYPOZYCZEN
FROM (
    SELECT 
        TO_CHAR(wyp.DATA_WYPOZYCZENIA, 'YYYY-MM') AS MIESIAC,
        p.ID_WYPOZYCZALNIA,
        m.ID_PRODUCENT,
        COUNT(*) AS LICZBA_WYPOZYCZEN
    FROM WYPOZYCZENIA wyp
    JOIN SKUTER s ON wyp.ID_SKUTER = s.ID
    JOIN MODEL m ON s.ID_MODEL = m.ID
    JOIN PRACOWNIK p ON wyp.ID_PRACOWNIK = p.ID
    GROUP BY TO_CHAR(wyp.DATA_WYPOZYCZENIA, 'YYYY-MM'), p.ID_WYPOZYCZALNIA, m.ID_PRODUCENT
) agg
JOIN WYPOZYCZALNIA wypozyczalnia ON agg.ID_WYPOZYCZALNIA = wypozyczalnia.ID
JOIN PRODUCENT producent ON agg.ID_PRODUCENT = producent.ID
ORDER BY agg.MIESIAC, wypozyczalnia.NAZWA, producent.NAZWA;

SPOOL OFF;



