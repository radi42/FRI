/**
 * Trieda Hra je hlavna trieda aplikacie "World of FRI".
 * "World of FRI" je velmi jednoducha textova hra - adventura. 
 * Hrac sa moze prechadzat po niektorych priestoroch - miestnostiach fakulty. 
 * To je v tejto verzii vsetko. Hru treba skutocne zancne rozsirit,
 * aby bola zaujimava.
 * 
 * Ak chcete hrat "World of FRI", vytvorte instanciu triedy Hra (hra) 
 * a poslite jej spravu hraj.
 * 
 * Hra vytvori a inicializuje vsetky potebne objekty:
 * vytvori vsetky miestnosti, vytvori parser a zacne hru. Hra tiez vyhodnocuje
 * a vykonava prikazy, ktore vrati parser.
 * 
 * @author  Michael Kolling, David J. Barnes
 * @version 2006.03.30
 * @author  lokalizacia: Lubomir Sadlon, Jan Janech
 * @version 2012.02.21
*/
 
public class Hra 
{
    private Parser aParser;
    private Miestnost aAktualnaMiestnost;
        
    /**
     * Vytvori a inicializuje hru.
     */
    public Hra() 
    {
        vytvorMiestnosti();
        aParser = new Parser();
    }

    /**
     * Vytvori mapu hry - miestnosti.
     */
    private void vytvorMiestnosti()
    {
        // zoznam miestnosti
        Miestnost terasa, aula, bufet, labak, kancelaria;
      
        // vytvorenie miestnosti
        terasa = new Miestnost("terasa - hlavny vstup na fakultu");
        aula = new Miestnost("aula");
        bufet = new Miestnost("bufet");
        labak = new Miestnost("pocitacove laboratorium");
        kancelaria = new Miestnost("kancelaria spravcu pocitacoveho laboratoria");
        
        // inicializacia miestnosti = nastavenie vychodov
        terasa.nastavVychody(null, aula, labak, bufet);
        aula.nastavVychody(null, null, null, terasa);
        bufet.nastavVychody(null, terasa, null, null);
        labak.nastavVychody(terasa, kancelaria, null, null);
        kancelaria.nastavVychody(null, null, null, labak);

        aAktualnaMiestnost = terasa;  // startovacia miestnost hry
    }

    /**
     *  Hlavna metoda hry.
     *  Cyklicky opakuje kroky hry, kym hrac hru neukonci.
     */
    public void hraj() 
    {            
        vypisPrivitanie();

        // Vstupny bod hlavneho cyklu.
        // Opakovane nacitava prikazy hraca
        // vykonava ich kym hrac nezada prikaz na ukoncenie hry.
                
        boolean jeKoniec = false;
        while (! jeKoniec) {
            Prikaz prikaz = aParser.dajPrikaz();
            jeKoniec = vykonajPrikaz(prikaz);
        }
        System.out.println("Maj sa fajn!");
    }

    /**
     * Vypise privitanie hraca do terminaloveho okna.
     */
    private void vypisPrivitanie()
    {
        System.out.println();
        System.out.println("Vitaj v hre World of FRI!");
        System.out.println("World of FRI je nova, neuveritelne nudna adventura.");
        System.out.println("Zadaj 'pomoc' ak potrebujes pomoc.");
        System.out.println();
        System.out.println("Teraz si v miestnosti " + aAktualnaMiestnost.dajPopis());
        System.out.print("Vychody: ");
        if(aAktualnaMiestnost.aSevernyVychod != null) {
            System.out.print("sever ");
        }
        if(aAktualnaMiestnost.aVychodnyVychod != null) {
            System.out.print("vychod ");
        }
        if(aAktualnaMiestnost.aJuznyVychod != null) {
            System.out.print("juh ");
        }
        if(aAktualnaMiestnost.aZapadnyVychod != null) {
            System.out.print("zapad ");
        }
        System.out.println();
    }

    /**
     * Prevezne prikaz a vykona ho.
     * 
     * @param paPrikaz prikaz, ktory ma byt vykonany.
     * @return true ak prikaz ukonci hru, inak vrati false.
     */
    private boolean vykonajPrikaz(Prikaz paPrikaz) 
    {
        boolean jeKoniec = false;

        if(paPrikaz.jeNeznamy()) {
            System.out.println("Nerozumiem, co mas na mysli...");
            return false;
        }

        String nazovPrikazu = paPrikaz.dajNazov();
        if (nazovPrikazu.equals("pomoc")) {
            vypisNapovedu();
        } else if (nazovPrikazu.equals("chod")) {
            chodDoMiestnosti(paPrikaz);
        } else if (nazovPrikazu.equals("ukonci")) {
            jeKoniec = ukonciHru(paPrikaz);
        }

        return jeKoniec;
    }

    // implementacie prikazov:

    /**
     * Vypise text pomocnika do terminaloveho okna.
     * Text obsahuje zoznam moznych prikazov.
     */
    private void vypisNapovedu() 
    {
        System.out.println("Zabludil si. Si sam. Tulas sa po fakulte.");
        System.out.println();
        System.out.println("Mozes pouzit tieto prikazy:");
        System.out.println("   chod ukonci pomoc");
    }

    /** 
     * Vykona pokus o prechod do miestnosti urcenej danym smerom.
     * Ak je tym smerom vychod, hrac prejde do novej miestnosti.
     * Inak sa vypise chybova sprava do terminaloveho okna.
     */
    private void chodDoMiestnosti(Prikaz paPrikaz) 
    {
        if(!paPrikaz.maParameter()) {
            // ak prikaz nema parameter - druhe slovo - nevedno kam ist
            System.out.println("Chod kam?");
            return;
        }

        String smer = paPrikaz.dajParameter();

        // Pokus o opustenie aktualnej miestnosti danym vychodom.
        Miestnost novaMiestnost = null;
        if(smer.equals("sever")) {
            novaMiestnost = aAktualnaMiestnost.aSevernyVychod;
        }
        if(smer.equals("vychod")) {
            novaMiestnost = aAktualnaMiestnost.aVychodnyVychod;
        }
        if(smer.equals("juh")) {
            novaMiestnost = aAktualnaMiestnost.aJuznyVychod;
        }
        if(smer.equals("zapad")) {
            novaMiestnost = aAktualnaMiestnost.aZapadnyVychod;
        }

        if (novaMiestnost == null) {
            System.out.println("Tam nie je vychod!");
        }
        else {
            aAktualnaMiestnost = novaMiestnost;
            System.out.println("Teraz si v miestnosti " + aAktualnaMiestnost.dajPopis());
            System.out.print("Vychody: ");
            if(aAktualnaMiestnost.aSevernyVychod != null) {
                System.out.print("sever ");
            }
            if(aAktualnaMiestnost.aVychodnyVychod != null) {
                System.out.print("vychod ");
            }
            if(aAktualnaMiestnost.aJuznyVychod != null) {
                System.out.print("juh ");
            }
            if(aAktualnaMiestnost.aZapadnyVychod != null) {
                System.out.print("zapad ");
            }
            System.out.println();
        }
    }

    /** 
     * Ukonci hru.
     * Skotroluje cely prikaz a zisti, ci je naozaj koniec hry.
     * Prikaz ukoncenia nema parameter.
     * 
     * @return true, if this command quits the game, false otherwise.
     * @return true, ak prikaz konci hru, inak false.
     */
    private boolean ukonciHru(Prikaz paPrikaz) 
    {
        if(paPrikaz.maParameter()) {
            System.out.println("Ukonci, co?");
            return false;
        } else {
            return true;
        }
    }
}
