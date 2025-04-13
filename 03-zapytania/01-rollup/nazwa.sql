-- ROLLUP

--Sprawdzenie, kt�re metody p�atno�ci generuj� najwi�ksze przychody w danym kraju, wojew�dztwie i mie�cie.
--1350

SPOOL wynik1.txt

SELECT 
    p.nazwa AS PANSTWO,
    w.nazwa AS WOJEWODZTWO, 
    m.nazwa AS MIASTO,
    r.nazwa AS RODZAJ_PLATNOSCI, 
    SUM(wyp.CENA) AS LACZNY_PRZYCHOD
FROM WYPOZYCZENIA wyp
    JOIN KLIENT k ON wyp.ID_KLIENT = k.ID
    JOIN ULICA u ON k.ID_ULICA = u.ID
    JOIN MIASTO m ON u.ID_MIASTO = m.ID
    JOIN WOJEWODZTWO w ON m.ID_WOJEWODZTWO = w.ID
    JOIN PANSTWO p ON w.ID_PANSTWO = p.ID
    JOIN RODZAJ_PLATNOSCI r ON wyp.ID_RODZAJ_PLATNOSCI = r.ID
GROUP BY ROLLUP (p.nazwa, w.nazwa, m.nazwa, r.nazwa)
ORDER BY SUM(wyp.CENA);

SPOOL OFF;