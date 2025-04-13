-- FUNKCJE RANKINGOWE

-- Sprawdzenie, ktore modele skuterow i typy napedu ciesza sie najwiekszym zainteresowaniem w poszczegolnych wypozyczalniach, z rankingiem wedlug liczby wypozyczen.
SPOOL wynik1.txt

SELECT 
    wy.NAZWA AS WYPOZYCZALNIA,
    m.NAZWA AS MODEL,
    t.NAZWA AS TYP_NAPEDU,
    agg.LICZBA_WYPOZYCZEN,
    RANK() OVER (PARTITION BY agg.ID_WYPOZYCZALNIA ORDER BY agg.LICZBA_WYPOZYCZEN DESC) AS RANKING
FROM (
    SELECT 
        s.ID_WYPOZYCZALNIA,
        s.ID_MODEL,
        s.ID_TYP_NAPEDU,
        COUNT(wyp.ID_SKUTER) AS LICZBA_WYPOZYCZEN
    FROM WYPOZYCZENIA wyp
    JOIN SKUTER s ON wyp.ID_SKUTER = s.ID
    GROUP BY s.ID_WYPOZYCZALNIA, s.ID_MODEL, s.ID_TYP_NAPEDU
) agg
JOIN WYPOZYCZALNIA wy ON agg.ID_WYPOZYCZALNIA = wy.ID
JOIN MODEL m ON agg.ID_MODEL = m.ID
JOIN TYP_NAPEDU t ON agg.ID_TYP_NAPEDU = t.ID
ORDER BY wy.NAZWA, RANKING;

SPOOL OFF;

-------------------------------------------------------------------------------------
SPOOL wynik2.txt

SPOOL OFF;


-------------------------------------------------------------------------------------
SPOOL wynik3.txt

SPOOL OFF;
