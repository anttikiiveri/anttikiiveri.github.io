var sanasto = [];
var oikeatVastaukset = 0;
var vaaratVastaukset = 0;
var kysymys = '';
var sanojenMaara = 0;

var answerInput = document.getElementById('answer');

document.addEventListener('DOMContentLoaded', function () {
    var tiedostoParametri = getURLParameter('tiedosto');
    // Lataa CSV-tiedoston sisältö ja käynnistä sovellus
    fetch('https://anttikiiveri.github.io/sanastot/' + tiedostoParametri)
        .then(function (response) {
            document.getElementById('otsikko').textContent = 'Sanakyselin: ' + tiedostoParametri
            return response.text();
        })
        .then(function (tiedostonSisalto) {
            sanasto = parseCSV(tiedostonSisalto);
            sanojenMaara = sanasto.length
            naytaTilanne();
            naytaKysymys();
        })
        .catch(function (error) {
            console.error("Virhe tiedoston latauksessa: " + error);
        });
});

// Funktio hakee URL-parametrin
function getURLParameter(name) {
    var urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(name);
}

// Kuuntele 'Enter'-näppäimen painallusta input-kentässä
answerInput.addEventListener('keyup', function (event) {
    // Tarkista, onko painallus 'Enter'
    if (event.key === 'Enter') {
        // Suorita vastaavan toiminnon kuin 'Vastaa'-näppäimen painallus
        tarkistaVastaus();
    }
});

function naytaTilanne() {
    // Näytä tilanne jokaisen vastauksen jälkeen
    var tilanne = 'Oikeat vastaukset: ' + oikeatVastaukset + ', Väärät vastaukset: ' + vaaratVastaukset + ', Kysymyksiä jäljellä: ' + sanasto.length;
    document.getElementById('stats-container').textContent = tilanne;
    setProgress(oikeatVastaukset/sanojenMaara*100)
}

function parseCSV(csvData) {
    var rivit = csvData.split('\n');
    var sanat = [];
    for (var i = 0; i < rivit.length; i++) {
        var sana = rivit[i].split(';');
        sanat.push({
            suomi: sana[0],
            englanti: sana[1]
        });
    }
    shuffle(sanat);
    return sanat;
}

function setProgress(percent) {
    const circle = document.querySelector('.progress-bar circle');
    const radius = circle.r.baseVal.value;
    const circumference = 2 * Math.PI * radius;
    const offset = circumference - percent / 100 * circumference;
    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = offset;
  }

function shuffle(array) {
    let currentIndex = array.length, randomIndex;
    // While there remain elements to shuffle.
    while (currentIndex > 0) {
        // Pick a remaining element.
        randomIndex = Math.floor(Math.random() * currentIndex);
        currentIndex--;

        // And swap it with the current element.
        [array[currentIndex], array[randomIndex]] = [
            array[randomIndex], array[currentIndex]
        ];
    }
    return array;
}

function naytaKysymys() {
    kysymys = sanasto.pop();
    var kysymysJaVastausDiv = document.getElementById('kysymysJaVastaus');
    kysymysJaVastausDiv.style.display = 'block';
    kysymysJaVastausDiv.style.visibility = 'visible';
    document.getElementById('question-container').textContent = kysymys.suomi;
    document.getElementById('answer').value = '';
}

function tarkistaVastaus() {
    var kayttajanVastaus = document.getElementById('answer').value;
    document.getElementById('solu1').textContent = "";
    document.getElementById('solu2').textContent = "";
    document.getElementById('solu3').textContent = "";
    document.getElementById('solu4').textContent = "";
    var oikeaVastaus = kysymys.englanti;
    if (kayttajanVastaus === oikeaVastaus && kayttajanVastaus.slice(1) === oikeaVastaus.slice(1)) {
        oikeatVastaukset++;
        document.getElementById('solu1').textContent = "Oikein";
        document.getElementById('solu2').textContent = "";
        document.getElementById('solu3').textContent = "Oikea vastaus on ";
        document.getElementById('solu4').textContent = oikeaVastaus;
    } else {
        vaaratVastaukset++;
        sanasto.unshift(kysymys);
        document.getElementById('solu1').textContent = "Väärin. Kirjoitit ";
        document.getElementById('solu2').textContent = kayttajanVastaus;
        if (sanasto.length > 1) {
            document.getElementById('solu3').textContent = "Oikea vastaus on ";
            document.getElementById('solu4').textContent = oikeaVastaus;
        }
    }
    naytaTilanne();

    if (sanasto.length > 0) {
        naytaKysymys();
    } else {
        naytaTulokset();
    }
}

function naytaTulokset() {
    document.getElementById('kysymysJaVastaus').style.display = 'none';
    document.getElementById('alaNakyma').textContent = "Testi on päättynyt";
}
