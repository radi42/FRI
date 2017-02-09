package kniznica.data;

import datastructures.lists.ArrayList.ArrayList;
import datastructures.lists.EList;
import java.io.Serializable;
import kniznica.Exception.EKniznica;

/**
 *
 * @author Andrej Šišila
 */
public class Citatel implements Serializable{

    private String aMeno;
    private String aPriezvisko;
    private int aVek;
    private int aPrioritaCitatela;
    private int aPocetPozicanychKnihTeraz;
    private int aPocetPozicanychKnihCelkovo;
    private int aPocetCakajucichPoziadaviek;
    private ArrayList<Kniha> aZoznamJehoKnih;
    
    public Citatel(String paMeno, String paPriezvisko, int paVek){
        aMeno = paMeno;
        aPriezvisko = paPriezvisko;
        aVek = paVek;
        aPrioritaCitatela = getPrioritaCitatela();
        aPocetPozicanychKnihTeraz = 0;
        aPocetPozicanychKnihCelkovo = 0;
        aZoznamJehoKnih = new ArrayList<Kniha>();
    }

    public String getMeno(){
        return aMeno;
    }

    public String getPriezvisko(){
        return aPriezvisko;
    }

    public int getVek(){
        return aVek;
    }
    
    public int getPrioritaCitatela(){
        if(getVek() >= 60)
            return 0;
        else if(getVek() <= 26)
            return 1;
        else
            return 2;
    }
    
    public String getVekovaSkupina(){
        if(getVek() >= 60)
            return "dochodca";
        else if(getVek() <= 26)
            return "student";
        else
            return "citatel";
    }

    public int getPocetPozicanychKnihTeraz(){
        return aPocetPozicanychKnihTeraz;
    }

    public int getPocetPozicanychKnihCelkovo(){
        return aPocetPozicanychKnihCelkovo;
    }
    
    public int getPocetCakajucichPoziadaviek(){
        return aPocetCakajucichPoziadaviek;
    }
    
    public ArrayList<Kniha> getJehoKnihy(){
        return aZoznamJehoKnih;
    }

    //#########################################################################
    
    public void setMeno(String paMeno){
        aMeno = paMeno;
    }

    public void setPriezvisko(String paPriezvisko){
        aPriezvisko = paPriezvisko;
    }

    public void setVek(int paVek){
        aVek = paVek;
    }

    public void setPocetPozicanychKnihTeraz(int paPocetPozicanychKnihTeraz){
        aPocetPozicanychKnihTeraz = paPocetPozicanychKnihTeraz;
    }

    public void setPocetPozicanychKnihCelkovo(int paPocetPozicanychKnihCelkovo){
        aPocetPozicanychKnihCelkovo = paPocetPozicanychKnihCelkovo;
    }
    
    public void setPocetCakajucichPoziadaviek(int paPocetCakajucichPoziadaviek){
        aPocetCakajucichPoziadaviek = paPocetCakajucichPoziadaviek;
    }
    
    public void pridajPozicanuKnihu(Kniha paPozicanaKniha) throws EKniznica{
        try {
            aZoznamJehoKnih.add(paPozicanaKniha);
        } catch (EList ex) {
            throw new EKniznica(("Nepodarilo sa " + ex.getMessage() ) );
        }
    }
    
    private String vypisPozicaneKnihy() throws EKniznica{
        String pozicaneKnihy = "";
        try {
            if(aZoznamJehoKnih.size() == 0){
                pozicaneKnihy = "ziadne pozicane knihy";
                return pozicaneKnihy;
            } else {
                for(int i = 0; i < aZoznamJehoKnih.size() -1; i++){
                    pozicaneKnihy += aZoznamJehoKnih.get(i).getNazov() + " ";
                    pozicaneKnihy += aZoznamJehoKnih.get(i).getAutorPriezvisko() + " ";
                    pozicaneKnihy += aZoznamJehoKnih.get(i).getAutorMeno() + " ▪ ";
                }
                int posledna = aZoznamJehoKnih.size() -1;
                pozicaneKnihy += aZoznamJehoKnih.get(posledna).getNazov() + " ";
                pozicaneKnihy += aZoznamJehoKnih.get(posledna).getAutorPriezvisko() + " ";
                pozicaneKnihy += aZoznamJehoKnih.get(posledna).getAutorMeno() + " ▪ ";
                return pozicaneKnihy;
            }
        } catch (EList ex) {
            throw new EKniznica("Nepodarilo sa " + ex.getMessage() );
        }
    }
    
    @Override
    public String toString(){
        String citatel = "";
        try {
            citatel = getMeno() + " █ " +  getPriezvisko() + " █ " + getVek() + " █ " + getVekovaSkupina() + " █ ";
            citatel += getPocetPozicanychKnihTeraz() + " █ " + getPocetPozicanychKnihCelkovo() + " █ " + getPocetCakajucichPoziadaviek() + " █ ";
            citatel += vypisPozicaneKnihy();
            return citatel;
        } catch (EKniznica ex) {
            return "Nieco sa pokazilo";
        }
    }
}