-- Sprawdzenie liczby wypo�ycze� skuter�w w r�nych lokalizacjach: kraj, wojew�dztwo, miasto.

SPOOL wynik1.txt

SELECT 
    p.NAZWA AS PANSTWO, 
    w.NAZWA AS WOJEWODZTWO, 
    m.NAZWA AS MIASTO, 
    COUNT(wyp.ID_SKUTER) AS LICZBA_WYPOZYCZEN
FROM WYPOZYCZENIA wyp
    JOIN KLIENT k ON wyp.ID_KLIENT = k.ID
    JOIN ULICA u ON k.ID_ULICA = u.ID
    JOIN MIASTO m ON u.ID_MIASTO = m.ID
    JOIN WOJEWODZTWO w ON m.ID_WOJEWODZTWO = w.ID
    JOIN PANSTWO p ON w.ID_PANSTWO = p.ID
GROUP BY CUBE (p.NAZWA, w.NAZWA, m.NAZWA);

SPOOL OFF;