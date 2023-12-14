![image](https://github.com/CanIsguzar/Datawarehousing/assets/60609529/cb779cbd-1f7f-4ef2-8565-d135ef6bd29f)
 






Casus   ANBC

AIS-DW (DATWAHxx)
BIM2-BINT (BUSIIN29)












Beschrijving casus voortraject en prototypetraject.

In deze onderwijspublicatie is geen auteursrechtelijk werk opgenomen.
copyright HAN-AIM






 
Inhoudsopgave

1.	Algemeen	3
2.	Het bedrijf	4
2.1 Het bedrijfsproces	4
2.2 Managementinformatiesysteem	5
3.	Casus voortraject.	6
Opdracht 1: Stel het operationeel informatieplan op	6
Opdracht 2: Maak het meetplan voor de belangrijkste operationele KPI’s	6
Opdracht 3: Beschrijf per geselecteerde operationele KPI de mogelijke maatregelen (Actieplan)	7
4.	Prototype	8
Opdracht A: Bronanalyse	8
Opdracht B: Functioneel ontwerp	8
Opdracht C: Technisch ontwerp en implementatie	8
Opdracht D: Ontsluiting	9
Verslaglegging	9
Inleveren en demo	9
Bijlage A: Het LRS van het informatiesysteem	10
Bijlage B: Ontsluiting van KNMI data	11
 
1.	Algemeen

Deze casus en opdrachtomschrijving is onderdeel van de beoordeling van de course DW van het semester AIS. Deze omschrijving heeft betrekking op twee beroepsproducten namelijk het voortraject en het prototypetraject. In de onderstaande tabel vind je de toetscodes en vakcodes van Osiris.

AIS-DW (DATWAHxx)		
Voortraject:	B_Casus 	Casus
Prototypetraject:	B_Prototype 	Prototype
		
BIM2-BINT (BUSIIN29)		
Voortraject:	B_CaseVoortra	Adviesrapport
Prototypetraject:	B_CaseProtype 	Casus Prototype

Het voortraject betreft een casus met als output een een advies waarbij je beargumenteerd een Balanced scorecard inricht met bijbehorende ksf-en en kpi’s. Je werkt dit uit tot meetplannen en actieplannen. 

Het prototypetraject betreft het ontwerp en ontwikkeling van een prototype en ondersteunende documentatie. Het prototypetraject bevat een analyse van de data, het ontwerp van een datavault, datamart. Daarnaast wordt er een protoype ontwikkeld van de kpi’s uit het voortraject.

De omschrijving begint met een algemeen gedeelte, waarna de opdrachten volgen voor beide beroepsproducten afzonderlijk. Voor de ontwikkeling van het prototype heb je de uitkomst van het meetplan nodig, maar verder staan beide producten los van elkaar en kun je ze los van elkaar wel of niet halen, ze worden apart beoordeeld. Indien je alleen het prototype maakt of herkanst zal de docent je een aantal KPI’s of een meetplan als input geven.

Voor beide toetsen moeten deelproducten en een totaalverslag ingeleverd worden. Die verslagen bestaan uit de verschillende producten die je maakt bij de opdrachten. Van het prototype moet ook een demonstratie gegeven worden.

Voor beide beroepsproducten geldt dat je deze als tweetal uitvoert, zodat je van elkaar kunt leren. Door het reviewen van elkaars werk kom je tot een beter eindresultaat. In de verslagen moet duidelijk aangegeven worden wat de persoonlijke bijdrage is geweest van elke student. Bij beide toetsen hoort mogelijk ook een individueel assessment indien er vragen zijn over de producten of de persoonlijke bijdrage.

Voor de oplevermomenten van de beroepsproducten en herkansingen, raadpleeg het toetsrooster.

Voor deze opdracht heb je de als uitgangspunt de opdrachtendatabase nodig. Een backup van deze database alsmede andere bestanden en vind je op Teams. Ook de instructies voor het voortraject en prototypetraject kun je hier vinden. 
 
2.	Het bedrijf

Arnhem Nijmegen Biker Couriers is een snel groeiende fietskoeriersdienst. Naast de vestiging in Arnhem is er enige tijd geleden een tweede vestiging geopend in Nijmegen. Vanuit Arnhem worden ook pakjes bezorgd in Nijmegen en vice versa. In Arnhem is de centrale met een verdeelcentrum erbij en in Nijmegen is er enkel een verdeelcentrum dat bestaat uit een afgesloten ruimte waar de Biker Couriers een sleutel van hebben.
2.1 Het bedrijfsproces
Klanten bellen naar de centrale. Daar wordt de opdracht geregistreerd. Als het een nieuwe klant betreft worden meteen alle gegevens van de klant genoteerd. Voor elke opdracht worden ophaaladres en bezorgadres genoteerd . Klanten kunnen de opdracht ook aanmelden via de website of app van ANBC. Een opdracht kan bestaan uit één of meerdere pakjes. Van elk pakje wordt het gewicht genoteerd. Het is mogelijk dat een opdracht zo groot is dat hij verdeeld wordt over meerdere koeriers. De pakjes kunnen dus onafhankelijk van elkaar bezorgd worden. De centrale wijst de pakjes toe aan de koeriers. De centrale noteert ook of het een express bezorging is of niet en spreekt een ophaaltijd af met de klant. Tevens schat hij in hoe lang het bezorgen gaat duren (in minuten). Expressbezorgingen kunnen daarom alleen via de centrale geregeld worden. De klant kan direct betalen. 

De prijs van een bezorging wordt berekend aan de hand van het gewicht van elk pakje. Voor elk pakje wordt dus apart één prijs bepaald. Zie voor de kostprijs ook de tabel Delivery price uit de database (bijlage A). Een klant krijgt 25% korting voor elke 10de opdracht. Deze korting krijgt hij niet direct maar pas aan het einde van het jaar als bonus uitgekeerd. 
De klant kan online of direct bij ophalen van de pakketjes betalen en zal dan een kopie van de kwitantie krijgen. De koerier berekent de kosten uit een afdruk van de Delivery price tabel en geeft de kwitanties af aan de centrale (of stuurt ze op). 
Bij een expressbezorging is de bezorgtijd gegarandeerd. Het tarief is hoger, maar als de opdracht te laat bezorgd wordt, hoeft de klant de hele opdracht niet te betalen. Niet alle bikers mogen express-pakketten rondbrengen: alleen de ervaren snelle bikers mogen dat. Met alle bikers is een maximum aantal keer afhalen en bezorgen afgesproken. 

Elke stad is verdeeld in een aantal wijken. Als de opdracht binnen dezelfde wijk bezorgd moet worden dan worden de pakjes direct van het ophaaladres naar het bezorgadres gebracht. Over het algemeen is de bezorgtijd dan korter. Pakjes naar een andere wijk worden soms naar het verdeelcentrum gebracht om op een later tijdstip alsnog bezorgd te worden (door dezelfde koerier).
Twee keer per werkdag (11.00 uur en 15.00 uur) rijdt een auto van het verdeelcentrum Arnhem naar het verdeelcentrum Nijmegen en vervolgens weer terug met de pakjes die naar het andere verdeelcentrum moeten worden gebracht.
Als er weinig pakjes zijn om van verdeelcentrum te wisselen en voor de express verzendingen wordt  er vaak voor gekozen om een werkstudent met de trein te laten gaan (met z’n OV jaarkaart!).

Bij het ophalen noteert de koerier het tijdstip van ophalen. De hele opdracht wordt in één keer opgehaald, indien nodig dus door meerdere koeriers. Bij het bezorgen wordt per pakje het tijdstip van aflevering genoteerd. Daarbij wordt gebruik gemaakt van smartphones. Een opdracht wordt als afgesloten beschouwd als het laatste pakje bezorgd is. 

Er is een redelijk goed gemodelleerd informatiesysteem dat dit proces ondersteunt. Dit systeem is in het Engels. Een aantal termen die in het systeem gebruikt worden, worden hieronder uitgelegd.

Parcel = pakket
Consignment = opdracht
Dispatch = verdeelcentrum
Pickup = het ophalen
Delivery = het bezorgen
District = wijk
Scheduled pickup time = de ophaaltijd die afgesproken is met de klant
Pickup time = werkelijke tijd dat het pakje is opgehaald
Exp_Duration = de geschatte duur van het bezorgen (expected duration)
2.2 Managementinformatiesysteem
In de loop van tijd zijn er vele nieuwe koeriers in dienst genomen. Het management, zelf in het begin enthousiaste koeriers, realiseert zich dat ze moeten professionaliseren en daarvoor hebben ze meer inzicht nodig in de bedrijfsprocessen. Het management verliest het overzicht en kent niet alle koeriers en klanten meer persoonlijk, zoals in het begin. Onduidelijk is welke activiteiten winstgevend zijn en welke niet. Nieuwe koeriers verdwalen soms en klanten klagen dat pakjes niet op tijd bezorgd worden. Het lijkt erop dat de problemen verergeren bij heftige regen, onweer of gladheid door hagel en sneeuw. Gelukkig worden alle opdrachten redelijk nauwkeurig geregistreerd in het informatiesysteem.

Het management huurt jouw team in om een managementinformatiesysteem op te zetten waarmee ze beter inzicht krijgen in de uitvoering van de processen.

Op basis hiervan besluit jouw bedrijf de eerste stap te zetten door je een operationeel informatieplan, meetplan en actieplan te laten schrijven. Het is aan jou om te achterhalen wat nu precies de vragen zijn waar het management meer inzicht in wil krijgen en hoe zich dat vertaalt in KPI’s. Zie hiervoor de instructies bij de toets voortraject op Teams.

Vervolgens besluit het management om op basis van dit plan een prototype voor een dashboard te laten ontwerpen en realiseren. Met dit prototype willen ze ervaring opdoen met verschillende aspecten van data warehousing. Hierbij ligt al vast dat de centrale opslag een data warehouse met een Data Vault model moet worden. Op dit data warehouse komen één of meerdere data marts voor de ontsluiting van de gegevens en meerdere rapportageomgevingen zodat het management hier een keuze uit kan maken. Zie hiervoor de instructie voor de toets prototype traject op Teams.

 
Bijlage A: Het LRS van het informatiesysteem

 


 
Bijlage B: Voorbeelddocumenten

Het label hieronder is een voorbeeld van een label dat op een pakketje geplakt door de Biker Courier die de opdracht gaat ophalen. 

 

Hieronder zie je een schermpje van de App waarmee de Biker een opdracht kan aannemen. Met behulp van deze App kan hij ook de verschillende statussen van de opdracht doorgeven, de tijd wordt dan automatisch opgeslagen.

 

 
Bijlage C: Ontsluiting van KNMI data

KNMI datasets kunnen op verschillende manieren ontsloten worden. Kies één van onderstaande opties:
1.	Je download een dataset als tekstbestand en leest dat in in een database in SQL Server. Schrijf een query FOR JSON waarmee je de gegevens die je nodig hebt in een JSON file zet. Ontsluit de JSON file met SSIS. Daarvoor zijn verschillende mogelijkheden. Onderzoek die en kies er één. Je hoeft hier géén onderzoeksplan of -verslag voor op te stellen, hou het praktisch. Onderbouw alleen je keuze kort in je verslag. Je kunt hierbij gebruik maken van de klimaatdata: KNMI - Klimatologie, bijvoorbeeld uurwaarden van weerstations: KNMI - Uurgegevens van het weer in Nederland.
2.	Je maakt gebruik van een API voor het open dataplatform. Zie voor de datasets en instructies over het gebruik van API’s het KNMI Open Dataplatform: Open Data | KNMI Dataplatform. Let wel op, de datasets op dit platform zijn ruwe, onbewerkte meetgegevens en het is veel lastiger om hier een bruikbare dataset te vinden dan bij de link genoemd onder optie 1.
