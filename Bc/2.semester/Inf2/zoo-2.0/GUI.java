 

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.Random;
import java.io.*;
import lib.*;
/**
 * <h2>Trieda GUI</h2>
 * 
 * @author bene
 * @version 25.3.2012
 */
public class GUI extends JFrame implements ActionListener
{
    //----------------------------------------------------------- Atributy triedy --
    /** Generator pre zivocichy */
    private static Random generator = new Random();
    //-------------------------------------------------------- Atributy instancie --
    /** Zoologicka zahrada */
    private ZOO zoo;
    private String  fileName = "data/mojaZOO.dat";
    private JPanel  pnlMenu;
    private JLabel  lblNadpis;
    private JButton btnGenerViacZvierat, btnPridajZviera, btnOdstranZviera,
                    btnPrijatRiaditela, btnVytvorKamion, btnZOONaDisk,
                    btnZOOZDisku, btnNalozZviera, btnVylozZviera;
    private JTextArea txtaVystupy, txtaSprava;

    public GUI () {
        Osoba manager = new Osoba("Jan", "Novak", 26, 3, 1980);
        zoo = new ZOO(manager, 20, 10);

        vytvorGUI("Zoologicka zahrada");

        //---------------------------- Nastavenie parametrov okna: ========
        this.pack();
//         this.setSize(800, 600);         // rozmery okna
        this.setLocation(100, 200);     // umiestnenie okna na obrazovke
    }

    /**
     * Vytvorenie prostredia GUI
     * @param title     titulok okna GUI
     */
    private void vytvorGUI(String title) {
        super.setTitle (title);
        this.setLayout (new BorderLayout ());

        //---------------------------------------- Panel pre menu: ========
        pnlMenu = new JPanel();
        pnlMenu.setLayout (new GridLayout(20,1));
        //-------------------------------------------------- Napis: =======
        lblNadpis = new JLabel("Vyber cinnost");
        pnlMenu.add(lblNadpis);
        //---------------------------------------------- Tlacidla: ========
        btnPridajZviera  = new JButton("Pridaj zviera"); //-- Vytvorenie tlacidla
        pnlMenu.add(btnPridajZviera);                    //-- Pridanie na plochu

        btnGenerViacZvierat = new JButton("Generuj viac zvierat");
        pnlMenu.add(btnGenerViacZvierat);

        btnOdstranZviera  = new JButton("Odstran zviera");
        pnlMenu.add(btnOdstranZviera);

        btnPrijatRiaditela = new JButton("Prijat riaditela");
        pnlMenu.add(btnPrijatRiaditela);

        btnVytvorKamion   = new JButton("Pristav kamion");
        pnlMenu.add(btnVytvorKamion);

        btnZOONaDisk   = new JButton("Uloz ZOO na disk");
        pnlMenu.add(btnZOONaDisk);

        btnZOOZDisku   = new JButton("Citaj ZOO z disku");
        pnlMenu.add(btnZOOZDisku);

        btnNalozZviera   = new JButton("Naloz zviera na auto");
        pnlMenu.add(btnNalozZviera);

        btnVylozZviera   = new JButton("Vyloz zviera z auta");
        pnlMenu.add(btnVylozZviera);
 
        //------------------------------- Listenery na tlacidlach: ========
        btnPridajZviera.addActionListener(this);
        btnOdstranZviera.addActionListener(this);
        btnGenerViacZvierat.addActionListener(this);
        btnPrijatRiaditela.addActionListener(this);
        btnVytvorKamion.addActionListener(this);
        btnZOONaDisk.addActionListener(this);
        btnZOOZDisku.addActionListener(this);
        btnNalozZviera.addActionListener(this);
        btnVylozZviera.addActionListener(this);

        this.add(pnlMenu, BorderLayout.WEST);
        //------------------------ Plocha pre informaciu o vybere: ========
        txtaSprava = new JTextArea("", 2, 65);
        this.add(txtaSprava, BorderLayout.SOUTH);
        //----------------------------- Plocha pre vystupne texty: ========
        txtaVystupy = new JTextArea(zoo.toString(), 20, 70);
        JScrollPane scrollPane = new JScrollPane(txtaVystupy);
        this.add(scrollPane, BorderLayout.CENTER);
    }

    /**
     * Zisti poradove cislo vybranej akcie
     * @param akcia text akcie
     * @return  cislo vybranej akcie
     */
    private int cisloAkcie(String akcia) {
        if      (akcia.equals(btnPridajZviera.getText()))     return 1;
        else if (akcia.equals(btnGenerViacZvierat.getText())) return 2;
        else if (akcia.equals(btnOdstranZviera.getText()))    return 3;
        else if (akcia.equals(btnVytvorKamion.getText()))     return 5;
        else if (akcia.equals(btnZOONaDisk.getText()))        return 6;
        else if (akcia.equals(btnZOOZDisku.getText()))        return 7;
        else if (akcia.equals(btnNalozZviera.getText()))      return 8;
        else if (akcia.equals(btnVylozZviera.getText()))      return 9;
        return 0;   // neznama akcia
    }

    /**
     * Spracovanie kliknutia na jedno z tlacidiel.<br>
     * Kazde tlacidlo ma vlastnu definovanu cinnost
     * @param e   udalost
     */
    public void actionPerformed(ActionEvent e) {
        String oznam = "";
        int pozicia;
        switch (cisloAkcie(e.getActionCommand())) {
            case 1: //------------------------------------- Pridanie zvierata --
                Zivocich zviera = vytvorZivocicha();
                oznam = (zoo.pridajZivocicha(zviera))
                            ? "Vlozeny zivocich: " + zviera   // podarilo sa
                            : "ZOO je uz plna!";              // nepodarilo
                break;
            case 2: //--------------------------- Generovanie viacero zvierat --
                int poc = 5 + generator.nextInt(6);
                poc = generujViacZvierat(poc);
                oznam = poc > 0 ? "Bolo pridanych "+ poc + " zvierat"
                                : "ZOO je uz plna!";
                break;
            case 3: //---------------------------------- Odstranenie zvierata --
                pozicia = MojeMetody.vlozInt("Vloz index zvierata") - 1;
                oznam = "Zviera c. " + (pozicia + 1);
                oznam += (zoo.odstranZivocicha(pozicia) != null) 
                            ? " bolo vymazane"
                            : " nebolo najdene";
                break;
            case 5: //------------------------------------ Prepravne vozidlo --
                zoo.setPracovneVozidlo();
                oznam = "Kamion bol pristaveny ako pracovne vozidlo";
                break;
            case 6: //--------------------------------- Ulozenie ZOO na disk --
                try {
                    Subor.zapisObj(fileName, zoo);
                    oznam = "ZOO bolo ulozene na disk do suboru: " + fileName;
                } catch (IOException exIO) {
                    oznam = "Chyba pri zapise ZOO na disk\n\t\t" + exIO;
                }
                break;
            case 7: //---------------------------------- Citanie ZOO z disku --
                try {
                    zoo = (ZOO) Subor.citajObj(fileName);
                    oznam = "ZOO bolo precitane z disku";
                } catch (FileNotFoundException exFNF) {
                    oznam = "Subor [" + fileName + "]  som nenasiel";
                } catch (IOException exIO) {
                    oznam = "Chyba pri citani ZOO z disku\n\t\t" + exIO;
                } catch (ClassNotFoundException exCNF) {
                    oznam = "Chyba pri citani ZOO z disku\n\t\t" + exCNF;
                }
                break;
            case 8: //------------------------ Nalozenie zvierata na vozidlo --
                oznam = nalozZvieraNaVozidlo();
                break;
            case 9: //-------------------------- Vylozenie zvierata z vozidla --
                oznam = vylozZvieraZVozidla();
                break;

            default: //------------------------------------ Akcia mimo rozsah --
                oznam = "Tlacitko [" +e.getActionCommand() + "] este nenaprogramovane";
                break;
        }

        txtaVystupy.setText(zoo.toString());            // info o ZOO
        txtaSprava.setText("\t* Sprava *\t" + oznam);   // sprava o vykonanej akcii
    }

    /**
     * Vytvorenie zivocicha zo zoznamu zvierat
     * @return vygenerovane zviera
     */
    private Zivocich vytvorZivocicha() {
        final String[] zFarba = {"cervena", "zelena", "modra", "zlta", "zlto-zelena"};
        Zivocich zviera = null;
        double kolkoVazi = 0.0;

        //-- Vygenerujeme zviera
        int vygenerovane = 1 + generator.nextInt(4); //cislo <1,4>

        switch (vygenerovane) {
            case 1: //blcha                       
                double kolkoDoskoci=3 * generator.nextDouble() ; //cislo <0;2.99>
                double kolkoVyskoci=3 * generator.nextDouble() ; //cislo <0;2.99>
                zviera=new Blcha(6,kolkoDoskoci,kolkoVyskoci);
                break;
            case 2: //simpanz
                kolkoVazi=3 + (97 * generator.nextDouble());  //cislo <3;99.9>
                boolean cviceny;
                cviceny=generator.nextBoolean();                   
                zviera=new Simpanz(kolkoVazi,cviceny);
                break;
            case 3: //papagaj
                kolkoVazi = 0.1 + (5*generator.nextDouble());    // cislo <0.1; 6>
                String farba = zFarba[generator.nextInt(5)];     // farba zo zoznamu
                zviera = new Papagaj("Ara", 2, kolkoVazi, farba); 
                break;
            case 4: //slon
                kolkoVazi=20 + (480*generator.nextDouble());   //cislo <20;500> 
                int pocet=generator.nextInt(50);         //pocet zubov bude <0,49>
                zviera=new Slon(kolkoVazi,pocet);
                break;
        } //------------------------------------------------------------- switch --
        return zviera;
    }

    /**
     * Generovanie zvoleneho poctu zvierat a umiestnenie do ZOO
     * @param pocet planovany pocet zvierat
     * @return pocet skutocne vygenerovanych zvierat
     */
    private int generujViacZvierat(int pocet){
        int poc = 0;
        for (int i = 0; i < pocet; i++) {
            if (zoo.pridajZivocicha(vytvorZivocicha())) poc++;
        }
        return poc;
    }

    /**
     * Nalozenie zvierata zo ZOO na vozidlo
     * @return sprava o vysledku
     */
    private String nalozZvieraNaVozidlo() {
        if (zoo.getPracovneVozidlo() == null) {
            return "Pracovne vozidlo nie je pristavene";
        }

        Integer pozicia = MojeMetody.vlozInt("Vloz cislo zvierata");
        if (pozicia == null) return "";

        try {
            Prepravitelny z = (Prepravitelny) zoo.getZvierataZOO(pozicia - 1);
            zoo.nalozZivocicha(z);
            zoo.odstranZivocicha(pozicia - 1);
            return "Zviera " + z + "\n\tbolo nalozene na prepravne vozidlo";
        } catch (ClassCastException exCC) {
            return "Zviera c. " + pozicia + " nemozno prepravit\n\t";
        } catch (NullPointerException exNP) {
            return "Zviera c. " + pozicia + " nie je v ZOO";
        } catch (Exception ex) {
            return "Neznama chyba:\n\t" + ex;
        }
    }

    /**
     * Vylozenie zvierata z vozidla do ZOO
     * @return sprava o vysledku
     */
    private String vylozZvieraZVozidla() {
        if (zoo.getPracovneVozidlo() == null) {
            return "Pracovne vozidlo nie je pristavene";
        }

        Integer pozicia = MojeMetody.vlozInt("Vloz index zvierata");
        if (pozicia == null) return "";

        try {
            Zivocich ziv = zoo.vylozZivocicha(pozicia-1);
            if (ziv == null) {
                return "Zviera c. " + pozicia + " nie je na vozidle\n\t";
            }
            zoo.pridajZivocicha(ziv);
            return "Zviera " + ziv
                  + "\n\tbolo vylozene z prepravneho vozidla";
        } catch (ClassCastException exCC) {
            return "Zviera c. " + pozicia + " nie je na vozidle\n\t";
        } catch (Exception ex) {
            return "Neznama chyba:\n\t" + ex;
        }
    }

}
