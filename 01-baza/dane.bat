set USERNAME=pro_bd
set PASSWORD=123
set HOST=localhost:1522
set INSTANCE=XEPDB1

sqlldr %USERNAME%/%PASSWORD%@%HOST%/%INSTANCE% control=ctl/panstwo.ctl log=log/panstwo.log bad=bad/panstwo.bad
sqlldr %USERNAME%/%PASSWORD%@%HOST%/%INSTANCE% control=ctl/wojewodztwo.ctl log=log/wojewodztwo.log bad=bad/wojewodztwo.bad
sqlldr %USERNAME%/%PASSWORD%@%HOST%/%INSTANCE% control=ctl/miasto.ctl log=log/miasto.log bad=bad/miasto.bad
sqlldr %USERNAME%/%PASSWORD%@%HOST%/%INSTANCE% control=ctl/ulica.ctl log=log/ulica.log bad=bad/ulica.bad
sqlldr %USERNAME%/%PASSWORD%@%HOST%/%INSTANCE% control=ctl/klient.ctl log=log/klient.log bad=bad/klient.bad
sqlldr %USERNAME%/%PASSWORD%@%HOST%/%INSTANCE% control=ctl/wypozyczalnia.ctl log=log/wypozyczalnia.log bad=bad/wypozyczalnia.bad
sqlldr %USERNAME%/%PASSWORD%@%HOST%/%INSTANCE% control=ctl/pracownik.ctl log=log/pracownik.log bad=bad/pracownik.bad
sqlldr %USERNAME%/%PASSWORD%@%HOST%/%INSTANCE% control=ctl/producent.ctl log=log/producent.log bad=bad/producent.bad
sqlldr %USERNAME%/%PASSWORD%@%HOST%/%INSTANCE% control=ctl/model.ctl log=log/model.log bad=bad/model.bad
sqlldr %USERNAME%/%PASSWORD%@%HOST%/%INSTANCE% control=ctl/kolor.ctl log=log/kolor.log bad=bad/kolor.bad
sqlldr %USERNAME%/%PASSWORD%@%HOST%/%INSTANCE% control=ctl/typ_napedu.ctl log=log/typ_napedu.log bad=bad/typ_napedu.bad
sqlldr %USERNAME%/%PASSWORD%@%HOST%/%INSTANCE% control=ctl/pakiet_wyposazenia.ctl log=log/pakiet_wyposazenia.log bad=bad/pakiet_wyposazenia.bad
sqlldr %USERNAME%/%PASSWORD%@%HOST%/%INSTANCE% control=ctl/skuter.ctl log=log/skuter.log bad=bad/skuter.bad
sqlldr %USERNAME%/%PASSWORD%@%HOST%/%INSTANCE% control=ctl/rodzaj_platnosci.ctl log=log/rodzaj_platnosci.log bad=bad/rodzaj_platnosci.bad
sqlldr %USERNAME%/%PASSWORD%@%HOST%/%INSTANCE% control=ctl/wypozyczenia.ctl log=log/wypozyczenia.log bad=bad/wypozyczenia.bad
