-- Obliczenie sumy przychod�w z wypo�ycze� w r�nych lokalizacjach: kraj, wojew�dztwo, miasto oraz sumy przychod�w w tych lokalizacjach na r�nych poziomach agregacji.

SPOOL wynik1.txt

SELECT 
    p.NAZWA AS PANSTWO, 
    w.NAZWA AS WOJEWODZTWO, 
    m.NAZWA AS MIASTO,
    SUM(wyp.CENA) AS SUMA_PLATNOSCI, 
    SUM(SUM(wyp.CENA)) OVER (PARTITION BY p.NAZWA) AS SUMA_PLATNOSCI_W_KRAJU,
    SUM(SUM(wyp.CENA)) OVER (PARTITION BY p.NAZWA, w.NAZWA) AS SUMA_PLATNOSCI_W_WOJEWODZTWIE,
    SUM(SUM(wyp.CENA)) OVER (PARTITION BY p.NAZWA, w.NAZWA, m.NAZWA) AS SUMA_PLATNOSCI_W_MIE�CIE
FROM WYPOZYCZENIA wyp
    JOIN KLIENT k ON wyp.ID_KLIENT = k.ID
    JOIN ULICA u ON k.ID_ULICA = u.ID
    JOIN MIASTO m ON u.ID_MIASTO = m.ID
    JOIN WOJEWODZTWO w ON m.ID_WOJEWODZTWO = w.ID
    JOIN PANSTWO p ON w.ID_PANSTWO = p.ID
GROUP BY p.NAZWA, w.NAZWA, m.NAZWA;

SPOOL OFF;