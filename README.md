Sanakyselin

Käyttö: lisää hakemistoon 'sanastot' opeteltavat sanat. Hakemistosta löytyy esimerkkejä. Uuden tiedoston nimeksi kannattaa valita esimerkiski "Minun-englannnin-kpl-3.csv". Tiedostopäätteen tulee olla .csv. Nimen kannatta olla myös kuvaava, että tietää mitä kirjan kappaletta sanat koskevat ja mikä kieli on kyseessä.

Kun tiedosto on lisätty 'sanastot'-kansioon, niin aja tee_hakemisto_sivu.sh skripti

sh ./tee_hakemisto_sivu.sh

Skripti luo etusivun, jolla on linkit tiedostoihin.

Tämän jälkeen lisätään muutokset version hallintaan ja päivitetään muutokset

git add .
git commit -m "Sanoja lisätty"
git push

Mikäli sanoja lisätään jo olemassa olevaan tiedostoon, niin silloin riittää, kun tiedosto tallennetaa muutosten jälkeen ja suoritetaan samat versionhallinnan komennot:

git add .
git commit -m "Sanoja lisätty"
git push