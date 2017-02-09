package zoo;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import lib.*;
/**
 * <h2>Trieda Zoo</h2>
 * Instancia typu Zoo ma manazera, zvierata a vozidla.
 * Je kompoziciou tychto objektov. 
 * 
 * @author bene 
 * @version 16.3.2012
 */
public class ZOO
{
    //===================================================== Atributy instancie ==
    private Osoba manazer;
    private Zverinec zverinecZOO;               // zoznam zvierat v ZOO
    private Kamion pracVozidlo;                 // Pracovne vozidlo
    //=========================================================== Konstruktory ==
    /**
     * Konstruktor s nastavenim atributov
     * @param manager
     * @param kapacitaZverinca
     */
    public ZOO(Osoba manager, int kapacitaZverinca) {
        this.manazer  = manager;
        this.zverinecZOO = new Zverinec(kapacitaZverinca);
        this.pracVozidlo = null;
    }

    public ZOO() {
        this(null, 50);
        setManazer(new Osoba("Jan", "Novak", 
                             new Datum(26, 3, 1970)));
    }

    //==================================================== Metody instancie ==
    public Osoba getManazer() { return manazer; }
    public void setManazer(Osoba manazer) { this.manazer = manazer; }
    public Zverinec getZverinecZOO() { return zverinecZOO; }
    public Kamion getPracVozidlo() { return pracVozidlo; }


    public void vytvorKamion() {
        Osoba man = new Osoba("Peter", "Hrasko", new Datum(5, 7, 1975));
        this.pracVozidlo = new Kamion(man, 1500);
    }

    /**
     * Naloženie živočícha na vozidlo
     * @param ziv
     * @return
     */
    public boolean nalozZivocicha(Prepravitelny ziv) {
        return pracVozidlo.nalozZivocicha(ziv);
    }

    public String info() {
        String str = "*** Zoologická záhrada ****\n";
        str += "Manazer: " + manazer + "\n--------\n";
        str += "Zverinec:\n" + zverinecZOO + "\n--------\n";
        
        return str;
    }

    @Override
    public String toString(){
        String vozidlo = pracVozidlo == null ? "vozidlo nie je pristavené"
                                             : "vozidlo je pristavené";
        return "Manazer: " + manazer + "\n--------\n" + zverinecZOO
            + "\n--------\n" + vozidlo;
    }
    
    /**
     * zapis data do suboru
     */
    public void zapisDataTxt() throws FileNotFoundException, IOException{
        FileOutputStream fos = new FileOutputStream("subor.txt"); //otvor vystupny kanal
        BufferedOutputStream bos = new BufferedOutputStream(fos); //vytvor buffer - medzistupen medzi programom a diskom - prevencia proti zahlteniu pocitaca
        DataOutputStream dos = new DataOutputStream(bos); //otvor kanal na zapis binarnych dat
        
        dos.writeUTF(null);
        dos.writeUTF(zverinecZOO.zapisZveryTxt() );
        
        dos.close();
        bos.close();
        fos.close();
    }
    
    /**
     * citaj data do suboru
     */
    public void citajDataTxt() throws FileNotFoundException, IOException{
        FileInputStream fis = new FileInputStream("subor.txt"); //otvor vstupny kanal
        BufferedInputStream bis = new BufferedInputStream(fis); //vytvor buffer - medzistupen medzi programom a diskom - prevencia proti zahlteniu pocitaca
        DataInputStream dis = new DataInputStream(bis); //otvor kanal na citanie binarnych dat
        
        dis.close();
        bis.close();
        fis.close();
    }

}

