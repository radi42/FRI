package zoo;

/**
 * <h2>Trieda Blcha</h2>
 * Blcha je potomkom triedy Zivocich, je jeho specializaciou.
 * Z triedy Zivocich dedi vsetky metody a vnutorny stav (atributy),
 * ktory je pristupny ale len cez pristupove metody.
 * 
 * @author bene
 * @version 14.3.2012
 */
public class Blcha extends Zivocich
{
    //---------------------------------------- Atributy instancie --
    private double dlzkaSkoku;
    private double vyskaSkoku;
    
    /**
     * Konstruktor nastavi pocet koncatin do predka a oba atributy
     * @param pocetKoncatin pocet noh pre ulozenie do predka
     * @param vyskaSkoku    vyska skoku blchy
     * @param dlzkaSkoku    dllzka skoku
     */
    public Blcha(int pocetKoncatin, double vyskaSkoku, double dlzkaSkoku) {
        super("blcha", "kontajner", pocetKoncatin);
        nastavVyskuSkoku(vyskaSkoku);
        nastavDlzkuSkoku(dlzkaSkoku);
    }

    public double dajDlzkuSkoku() {
        return dlzkaSkoku;
    }
    
    public double dajVyskuSkoku() {
        return vyskaSkoku;
    }
    
    public void nastavVyskuSkoku(double vyska) {
        this.vyskaSkoku = vyska;
    }
    
    public void nastavDlzkuSkoku(double dlzka) {
        this.dlzkaSkoku = dlzka;
    }
        
    @Override
    public String toString() {
        return super.toString()
             + " dlzka skoku: " + String.format("%.1f cm,", dajDlzkuSkoku())
             + " vyska skoku: " + String.format("%.1f cm.", dajVyskuSkoku());
    }
}
