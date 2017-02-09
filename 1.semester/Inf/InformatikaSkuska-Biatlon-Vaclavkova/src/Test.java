public class Test {
    
    public static void main(String[] args) {       
        Preteky contest = new Preteky();
        contest.pridajPretekara("Antony Hopkins");
        contest.pridajPretekara("Gordon Freeman");
        
        Strelba shooting1 = new Strelba(5);
        Strelba shooting2 = new Strelba(5);
        
        //nalinkuj strelby pretekarom
        
        System.out.println(contest.dajPocetVsetkychPretekarov());
        int indexPrvehoPretekara = contest.dajIndexPretekaraPodlaMena("Antony Hopkins");
        System.out.println(indexPrvehoPretekara);
        contest.dajPretekaraNaIndexe(indexPrvehoPretekara).vlozStrelbu(shooting1);
        System.out.println(contest.dajPretekaraNaIndexe(indexPrvehoPretekara).dajStrelbu().dajPocetTercov());
        
        int indexDruhehoPretekara = contest.dajIndexPretekaraPodlaMena("Gordon Freeman");
        System.out.println(indexDruhehoPretekara);
        contest.dajPretekaraNaIndexe(indexDruhehoPretekara).vlozStrelbu(shooting2);
        System.out.println(contest.dajPretekaraNaIndexe(indexDruhehoPretekara).dajStrelbu().dajPocetTercov());
        
        int pocetVsetkychTercov = 
                contest.dajPretekaraNaIndexe(indexPrvehoPretekara).dajStrelbu().dajPocetTercov();
        System.out.println(pocetVsetkychTercov);
        
        for (int i = 0; i < 5; i++) {
            contest.dajPretekaraNaIndexe(contest.dajIndexPretekaraPodlaMena("Antony Hopkins")).dajStrelbu().vlozZasah(i);
        }
        
        contest.dajPretekaraNaIndexe(contest.dajIndexPretekaraPodlaMena("Gordon Freeman")).dajStrelbu().vlozZasah(0);
        contest.dajPretekaraNaIndexe(contest.dajIndexPretekaraPodlaMena("Gordon Freeman")).dajStrelbu().vlozZasah(2);
        contest.dajPretekaraNaIndexe(contest.dajIndexPretekaraPodlaMena("Gordon Freeman")).dajStrelbu().vlozZasah(4);
        
        System.out.println(contest.dajPretekaraNaIndexe(indexPrvehoPretekara).dajStrelbu().toString());
        System.out.println(contest.dajPretekaraNaIndexe(indexDruhehoPretekara).dajStrelbu().toString());
        
        
        contest.nastavCasPretekaroviPodlaIndexu(contest.dajIndexPretekaraPodlaMena("Antony Hopkins"), 180000);
        contest.nastavCasPretekaroviPodlaIndexu(contest.dajIndexPretekaraPodlaMena("Gordon Freeman"), 10000);
        
        System.out.println(contest.dajPretekaraNaIndexe(indexPrvehoPretekara).dajCelkovyCas());
        System.out.println(contest.dajPretekaraNaIndexe(indexDruhehoPretekara).dajCelkovyCas());
        
        
        
        System.out.println(contest.toString());
        System.out.println("\n");
        Pretekar theBest = contest.najdiVitaza();
        System.out.println("Vitazom pretekov je: " +
                theBest.dajStartovneCislo() + ". " +
                theBest.toString());
    }
}
