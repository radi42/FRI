public class Pretekar {
    private String aMeno;
    private int aStartovacieCislo;
    private int aCas;   //cas je uvedeny v stotinach sekundy
    private Strelba aStrelba;
    
    public Pretekar(String paMeno, int paStartovacieCislo){
        aMeno = paMeno;
        aStartovacieCislo = paStartovacieCislo;
        aCas = 0;
    }
    
    public Pretekar(String paMeno){
        aMeno = paMeno;
        aCas = 0;
    }
    
    public void setStartovacieCislo(int paStartovacieCislo){
        aStartovacieCislo = paStartovacieCislo;
    }
    
    public Strelba dajStrelbu(){
        return aStrelba;
    }
    
    public String getMeno(){
        return aMeno;
    }
    
    public int dajStartovneCislo(){
        return aStartovacieCislo;
    }
    
    public int dajCelkovyCas(){
        return aCas + dajTrestnyCasZaStrelbu();
    }
    
    public void setCasBehu(int paCas){
        aCas = paCas;
    }
    
    public void vlozStrelbu(Strelba paStrelba){
        aStrelba = paStrelba;
    }
    
    public int dajKolkoNastrielal(){
        return aStrelba.dajPocetZasahov();
    }
    
    public int dajTrestnyCasZaStrelbu(){
        return aStrelba.dajPocetNetrafenych() * 6000;
    }
    
    public boolean pretekarDobeholDoCiela(){
        return (aCas != 0) ? true : false;
    }
    
    public String dajFormatovanyVyslednyCas(){
        String vyslednyCas = "";
        int minuty;
        int sekundy;
        int stotiny;
        
        double presnyCasVMinutach = (double)aCas / 6000;
        minuty = (int)presnyCasVMinutach;
        
        double presnyZostavajuciCasVSekundach = (presnyCasVMinutach - minuty) * 60;
        sekundy = (int)presnyZostavajuciCasVSekundach;
        
        double desatinyAStotiny = (presnyZostavajuciCasVSekundach - sekundy) * 100;
        stotiny = (int)desatinyAStotiny;
        
        vyslednyCas = minuty + ":" + sekundy + "," + stotiny;
        
        return vyslednyCas;
    }
    
    @Override
    public String toString(){
        if(pretekarDobeholDoCiela()){
            return aMeno + " dobehol za " + dajFormatovanyVyslednyCas()
                    + " a nastrielal " + aStrelba.toString();
        } else {
            return aMeno + " este nedobehol";
        }
    }
}
