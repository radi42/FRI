package zoo;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.*;
import lib.MojeMetody;

/**
 * <h2>Trieda GUI</h2>
 * Grafický uživateľský interfejs.
 * @author bene
 * @version 25.3.2012
 */
public class GUI extends JFrame implements ActionListener
{
    //-------------------------------------------------------- Atribúty GUI --
    private JPanel  pnlMenu;          // panel pre tlačítka ponuky
    private JButton btnPridajZviera;  // tlačidlo
    private JButton btnPridaj10Zvierat;  // tlačidlo
    private JTextArea txtaVystupy;    // okno pre výstupy
    //----------------------------------------------------- Atribúty triedy --
    /** Zoologicka zahrada */
    private ZOO zoo = new ZOO();
    /** Generator pre zivocichy */
    private static Random generator = new Random();

    //------------------------------------------------------- Metódy triedy --
    public GUI () {
        super.setTitle ("Zoologocká zahrada");
        this.setLayout (new BorderLayout ());   // rozloženie komponentov
        setDefaultCloseOperation(EXIT_ON_CLOSE);

        //---------------------------------------- Panel pre menu: ========
        menu();

        //----------------------------- Plocha pre vystupne texty: ========
        txtaVystupy = new JTextArea(zoo.info(), 20, 70);
        this.add(txtaVystupy, BorderLayout.CENTER);

        //---------------------------- Nastavenie parametrov okna: ========
        this.pack();
        this.setSize(800, 600);         // rozmery okna
        this.setLocation(100, 200);     // umiestnenie okna na obrazovke
    }

    /**
     * Menu - Panel pre ponuku
     */
    private void menu() {
        pnlMenu = new JPanel();                 // vytvorenie panelu menu
        pnlMenu.setLayout (new FlowLayout ());  // rozloženie komponentov

        //---------------------------------------------- Tlacidla: ========
        btnPridajZviera  = new JButton("Pridaj zviera"); // Vytvor. tlačidla
        pnlMenu.add(btnPridajZviera);                    // Pridanie na plochu

        btnPridaj10Zvierat  = new JButton("Pridaj 10 zvierat"); // Vytvor. tlačidla
        pnlMenu.add(btnPridaj10Zvierat);                    // Pridanie na plochu

        //------------------------------------- Panel Menu do rámca okna --
        this.add(pnlMenu, BorderLayout.SOUTH);  // uloženie menu do okna

        //------------------------------- Listenery na tlačidlách: ========
         btnPridajZviera.addActionListener(this);
         btnPridaj10Zvierat.addActionListener(this);
    }

//     /**
//      * Spracovanie kliknutia na jedno z tlacidiel.<br>
//      * Kazde tlacidlo ma vlastnu definovanu cinnost
//      * @param e   udalost
//      */
    @Override
    public void actionPerformed(ActionEvent e) {
         String s = e.getActionCommand(); //---- Nazov pouziteho tlacidla 
 
         String oznam = "";
         if (s.equals(btnPridajZviera.getText())) { //---------------------
             Zivocich zviera = vytvorZviera();
             if (zoo.getZverinecZOO().pridajZviera(zviera)) {  // podarilo sa
                 oznam = "Vlozeny zivocich: " + zviera;
             } else {                            // nepodarilo
                 oznam = "Zoo je uz plna!";
             }
             txtaVystupy.setText(zoo.toString());

         } else if (s.equals(btnPridaj10Zvierat.getText())) {
                generuj10Zvierat();     // volame metodu generovania...
                oznam = "Pridanych nahodne 10 zvierat!";
         }
         txtaVystupy.setText(zoo.info());
         MojeMetody.disp(oznam);
    }

     /**
      * Vytvorenie zivocicha
      */
     private Zivocich vytvorZviera() {
         final String[] zFarba = {"cervena", "zelena", "modra",
                                  "zlta", "zlto-zelena"};
         Zivocich zviera = null;
         double kolkoVazi = 0.0;
 
         //-- Vygenerujeme zviera
         int vygenerovane = 1 + generator.nextInt(4); //cislo <1,4>
 
         switch (vygenerovane) {
             case 1: //blcha                       
                 double kolkoDoskoci=3 * generator.nextDouble(); //cislo <0;2.99>
                 double kolkoVyskoci=3 * generator.nextDouble(); //cislo <0;2.99>
                 zviera=new Blcha(6,kolkoDoskoci,kolkoVyskoci);
                 break;
             case 2: //simpanz
                 kolkoVazi=3 + (97 * generator.nextDouble());  //cislo <3;99.9>
                 boolean cviceny;
                 cviceny=generator.nextBoolean();                   
                 zviera=new Simpanz(kolkoVazi,cviceny);
                 break;
             case 3: //papagaj
                 kolkoVazi = 0.1 + (5*generator.nextDouble()); // cislo <0.1; 6>
                 String farba = zFarba[generator.nextInt(5)];  // farba zo zozn.
                 zviera = new Papagaj("Ara", null, kolkoVazi, farba); 
                 break;
             case 4: //slon
                 kolkoVazi=20 + (480*generator.nextDouble());  //cislo <20;500> 
                 int dlzkaChobota=generator.nextInt(50); //pocet zubov bude <0,49>
                 zviera=new Slon(kolkoVazi,dlzkaChobota);
                 break;
         }//switch
         return zviera;
     }

    private void generuj10Zvierat(){
        for (int i = 0; i < 10; i++) {
            zoo.getZverinecZOO().pridajZviera(vytvorZviera());
        }
    }
    
    /**
     * ulozenie celej zoo do suboru ako objekt
     */
    private void ulozObjektZoo(){
        ObjectOutputStream subor = null;
        try{
            subor = new ObjectOutputStream(new BufferedOutputStream(new FileOutputStream("subor.dat")));
            subor.writeObject(zoo);
            JOptionPane.showMessageDialog(null, "Zoo je ulozena");
            subor.close();
        } catch(IOException ex){
            JOptionPane.showMessageDialog(null, "nemozem zapisovat do suboru \n" + ex.getMessage() );
        }
    }
    
    /**
     * otvorenie zoo zo suboru ako objekt
     */
    private void nahrajObjektZoo(){
        ObjectInputStream subor = null;
        zoo = new ZOO();
        try{
            subor = new ObjectInputStream(new BufferedInputStream(new FileInputStream("subor.dat")));
            zoo = (ZOO) subor.readObject();
        } catch(IOException ex){
            JOptionPane.showMessageDialog(null, "nemozem citat zo suboru \n" + ex.getMessage() );
        } catch(ClassNotFoundException ex){
            JOptionPane.showMessageDialog(null, "trieda sa nenasla \n" + ex.getMessage() );
        }
    }

    /**
     * Štart GUI.
     * @param args argumenty aplikácie
     */
    public static void main(String[] args) {
            new GUI().setVisible(true); 
    }

}
