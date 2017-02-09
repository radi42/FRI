public class Strelba {
    private int aPocetVsetkychTercov;
    private int aPocetZasahov;
    private int aPocetNetrafenychTercov;
    private boolean [] aTerce;
    
    public Strelba(int paPocetVsetkychTercov){
        aPocetVsetkychTercov = paPocetVsetkychTercov;
        aTerce = new boolean[aPocetVsetkychTercov];
    }
    
    public int dajPocetTercov(){
        return aPocetVsetkychTercov;
    }
    
    public int dajPocetZasahov(){
        for (int i = 0; i < aTerce.length - 1; i++) {
            if(aTerce[i] == true) aPocetZasahov++;
        }
        return aPocetZasahov;
    }
    
    public int dajPocetNetrafenych(){
        aPocetNetrafenychTercov = aPocetVsetkychTercov - aPocetZasahov;
        return aPocetNetrafenychTercov;
    }
    
    public boolean vlozZasah(int paPozicia){
        if(paPozicia >= aPocetVsetkychTercov || paPozicia < 0){
            return false;
        } else {
            aTerce[paPozicia] = true;
            aPocetZasahov++;
            return true;
        }
    }
    
    @Override
    public String toString(){
        String zasiahnuteTerce = "Hodnoty: ";
        for (int i = 0; i < aTerce.length; i++) {
            if(aTerce[i] == true) zasiahnuteTerce = zasiahnuteTerce + " X ";
            else zasiahnuteTerce = zasiahnuteTerce + " - ";
        }
        
        return zasiahnuteTerce;
    }
}
