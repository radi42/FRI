public class RozmenSumu
{
    private int aRozmienanaSuma;
    
    public RozmenSumu(int paRozmienanaSuma)
    {
        if(paRozmienanaSuma > 0){
            aRozmienanaSuma = paRozmienanaSuma;
        }else{
            System.out.println("Zadávaná suma musí byť kladné nenulové celé číslo!");
        }
    }

    public void vypisMoznostiRozmenenia()
    {
        System.out.println("Rozmieňaná suma: " + aRozmienanaSuma + " eur");
        if(aRozmienanaSuma %2 == 0){
            for(int pocetJednoeuroviek = 0; pocetJednoeuroviek <= (aRozmienanaSuma/2); pocetJednoeuroviek++ ){
                System.out.println("Počet jednoeuroviek: " + (pocetJednoeuroviek*2) + "   Počet dvojeuroviek: " + (aRozmienanaSuma - (pocetJednoeuroviek*2))/2);
            }
        }else if(aRozmienanaSuma %2 == 1){
            for(int pocetJednoeuroviek = 0; pocetJednoeuroviek <= (aRozmienanaSuma/2); pocetJednoeuroviek++ ){
                System.out.println("Počet jednoeuroviek: " + ((pocetJednoeuroviek*2) + 1) + "   Počet dvojeuroviek: " + (aRozmienanaSuma - (pocetJednoeuroviek*2) - 1)/2);
            }
        }
    }
}