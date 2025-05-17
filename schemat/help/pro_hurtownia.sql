SELECT ID, IMIE, NAZWISKO FROM KLIENT
MINUS
SELECT * FROM H_KLIENT;
---------------------------------------------------------------
SELECT * FROM PANSTWO
MINUS
SELECT * FROM H_PANSTWO;
---------------------------------------------------------------
SELECT id, nazwa FROM wojewodztwo
MINUS
SELECT * FROM h_wojewodztwo;
---------------------------------------------------------------
SELECT id, nazwa FROM MIASTO
MINUS
SELECT * FROM H_MIASTO;
---------------------------------------------------------------
SELECT * FROM rodzaj_platnosci
MINUS
SELECT * FROM H_rodzaj_platnosci;
---------------------------------------------------------------
SELECT * FROM PRODUCENT
MINUS
SELECT * FROM h_producent;
---------------------------------------------------------------
SELECT id, nazwa FROM MODEL
MINUS
SELECT * FROM H_MODEL;
---------------------------------------------------------------
SELECT * FROM kolor
MINUS
SELECT * FROM h_kolor;
---------------------------------------------------------------
SELECT * FROM TYP_NAPEDU
MINUS
SELECT * FROM h_TYP_NAPEDU;
---------------------------------------------------------------
SELECT * FROM PAKIET_WYPOSAZENIA
MINUS
SELECT * FROM H_PAKIET_WYPOSAZENIA;
---------------------------------------------------------------
SELECT ID, IMIE, NAZWISKO FROM PRACOWNIK
MINUS
SELECT * FROM H_PRACOWNIK;
---------------------------------------------------------------
SELECT ID, NAZWA FROM wypozyczalnia
MINUS
SELECT * FROM h_wypozyczalnia;
---------------------------------------------------------------
SELECT * FROM H_MIESIAC;
---------------------------------------------------------------
SELECT w.ID,  
    k.ID, pk.ID, wk.ID, mk.ID,
    w.ID_RODZAJ_PLATNOSCI,
    m.ID_PRODUCENT, sk.ID_MODEL, sk.ID_KOLOR, sk.ID_TYP_NAPEDU, sk.ID_PAKIET_WYPOSAZENIA, 
    sk.POJEMNOSC, sk.ROK_PRODUKCJI,
    w.ID_PRACOWNIK, 
    wy.ID, pw.ID, ww.ID, mw.ID,
    w.CENA,
    EXTRACT(YEAR FROM w.DATA_WYPOZYCZENIA), EXTRACT(MONTH FROM w.DATA_WYPOZYCZENIA),
    EXTRACT(YEAR FROM w.DATA_ODDANIA), EXTRACT(MONTH FROM w.DATA_ODDANIA)
FROM WYPOZYCZENIA w
JOIN KLIENT k ON w.ID_KLIENT = k.ID
JOIN ULICA uk ON k.ID_ULICA = uk.ID
JOIN MIASTO mk ON uk.ID_MIASTO = mk.ID
JOIN WOJEWODZTWO wk ON mk.ID_WOJEWODZTWO = wk.ID
JOIN PANSTWO pk ON wk.ID_PANSTWO = pk.ID
JOIN SKUTER sk ON w.ID_SKUTER = sk.ID
JOIN MODEL m ON sk.ID_MODEL = m.ID
JOIN PRACOWNIK p ON w.ID_PRACOWNIK = p.ID
JOIN WYPOZYCZALNIA wy ON sk.ID_WYPOZYCZALNIA = wy.ID
JOIN ULICA uw ON wy.ID_ULICA = uw.ID
JOIN MIASTO mw ON uw.ID_MIASTO = mw.ID
JOIN WOJEWODZTWO ww ON mw.ID_WOJEWODZTWO = ww.ID
JOIN PANSTWO pw ON ww.ID_PANSTWO = pw.ID
MINUS
SELECT * FROM H_WYPOZYCZENIA;
