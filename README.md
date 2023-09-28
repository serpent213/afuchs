# AFuchs – Amateurfunk Cheat Sheet

von Steffen Beyer im Jahre 2023

Aktuell im Alpha-Zustand. Alle Daten ohne Gewähr, versteht sich.

## Einleitung

### Was?

AFuchs ist eine Sammlung von Datensätzen (Tabellen) in Kombination mit einem Generator,
um aus diesen ein individuell maßgeschneidertes PDF für den Druck zu erstellen. Das
Programm soll es jedem Amateurfunker ermöglichen, mit wenig Aufwand und ohne Spezialwissen
ein „Cheat Sheet“ zu generieren, ein wenige Seiten umfassendes Nachschlagewerk – man
könnte auch Spickzettel sagen.

### Einfach benutzen

Normalerweise werden zwei Versionen erzeugt:

*(in Planung)*

* [`afuchs.pdf`](https://github.com/serpent213/afuchs/blob/master/afuchs.pdf): Enthält alle Landeskenner (insgesamt 6 Seiten)
* `afuchs_kurz.pdf`: Enthält eine kurze Auswahl der Landeskenner (insgesamt 2 Seiten)

Diese können einfach heruntergeladen und ausgedruckt werden.

Ziel der Entwicklung ist jedoch vorrangig, es einfach zu machen, die Datensätze anzupassen,
zu ergänzen und beliebig zu kombinieren. Wie das geht wird im folgenden Abschnitt
beschrieben.

*73*

## Anpassung

### speedata Publisher

[speedata Publisher Download](https://download.speedata.de)

Zur automatischen Erzeugung des PDFs wird das hervorragende Programm *speedata Publisher*
verwendet (basierend auf *LuaTeX*), das kostenlos heruntergeladen werden kann. Es sollte
nach der Installation auf der Kommandozeile als `sp` verfügbar sein.

### Einstellungen

`afuchs.ini`

In der INI-Datei wird im wesentlichen festgelegt, welche CSV-Dateien in welcher Reihenfolge
in die PDF-Datei übertragen werden sollen.

### CSV-Dateien

`*.csv`

Die CSV-Dateien können in jedem Texteditor oder in einer Tabellenkalkulation wie *Excel*
oder *Numbers* bearbeitet werden. Als Trennzeichen wird das Semikolon (`;`) verwendet,
hier kann je nach Programm eine manuelle Einstellung notwendig sein.

### PDF erzeugen

`sp` im Wurzelverzeichnis ausführen, `afuchs.pdf` wird aktualisiert.

## Quellen

* [Wikipedia: ITU-Präfix](https://de.wikipedia.org/w/index.php?title=ITU-Präfix&oldid=233824738)
* [Wikipedia: Amateurfunkband](https://de.wikipedia.org/w/index.php?title=Amateurfunkband&oldid=236017496#Frequenzbereiche_in_Deutschland)
* [Chaoswelle: Q-Schlüssel](https://www.chaoswelle.de/index.php?title=Q-Schluessel&oldid=5314)
