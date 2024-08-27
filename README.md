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



---------------------------

Useamman avaimen käyttö git:ssä

1. Generoi passelit avaimet ja nimeä ne vaikka ssh-personal ja ssh-work
Esim komento:
ssh-keygen -t ed25519 -f my_personal_key -C "antti.v.kiiveri@gmail.com"

Tässä täytyy tuon sähköpostin olla sama, kun github username, millä kirjaudutaan sisään. (meleko varmasti?)

2. Sit tarvitaan ~/.ssh/congig tiedosto, johon ko avaimet konfiguroidaan näin:

#personal account
Host github.com-personal
  Hostname github.com
  User git
  IdentityFile=~/.ssh/my_personal_key

#work account
Host github.com-work
  Hostname github.com
  User git
  IdentityFile=~/.ssh/my_work_key

3. Kun repo kloonataan, niin tuohon käytettävään avaimeen viitataan seuraavasti
git clone git@github.com-personal:anttikiiveri/sanakyselin.git

Eli config -filessä annettu Host on se referenssi, joka täytyy listätä tuohon rimpsuun (esim github.com-personal)