package zoo;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.Random;
import lib.*;
/**
 * <h2>Trieda GUIpovodne</h2>
 * 
 * @author bene
 * @version 25.3.2012
 */
public class GUIpovodne extends JFrame// implements ActionListener
{
    //------------------------------------------------------------- Atributy triedy --
    /** Generator pre zivocichy */
    private static Random generator = new Random();
    //------------------------------------------------------------- Atributy triedy --
    /** Zoologicka zahrada */
    private Zoo zoo = new Zoo();
    private JPanel  pnlMenu;
    private JButton /*btnGener10Zvierat,*/ btnPridajZviera/*, btnOdstranZviera*/;
    private JTextArea txtaVystupy;

    public GUIpovodne () {
        super.setTitle ("Zoologocka zahrada");
        this.setLayout (new BorderLayout ());

        //---------------------------------------- Panel pre menu: ========
        pnlMenu = new JPanel();
        this.setLayout (new FlowLayout ());
        //---------------------------------------------- Tlacidla: ========
        btnPridajZviera  = new JButton("Pridaj zviera"); //-- Vytvorenie tlacidla
        pnlMenu.add(btnPridajZviera);                    //-- Pridanie na plochu

//         btnOdstranZviera   = new JButton("Odstran zviera");
//         pnlMenu.add(btnOdstranZviera);
// 
//         btnGener10Zvierat = new JButton("Generuj 10 zvierat");
//         pnlMenu.add(btnGener10Zvierat);
//  
        //------------------------------- Listenery na tlacidlach: ========
//         btnPridajZviera.addActionListener(this);
//         btnOdstranZviera.addActionListener(this);
//         btnGener10Zvierat.addActionListener(this);

        this.add(pnlMenu, BorderLayout.SOUTH);
        //----------------------------- Plocha pre vystupne texty: ========
        txtaVystupy = new JTextArea(zoo.toString(), 20, 70);
//         ScrollPane(ScrollPane.SCROLLBARS_AS_NEEDED); 
        this.add(txtaVystupy, BorderLayout.NORTH);
 
        //---------------------------- Nastavenie parametrov okna: ========
        this.pack();
        this.setSize(800, 600);         // rozmery okna
        this.setLocation(100, 200);     // umiestnenie okna na obrazovke


    }

//     /**
//      * Spracovanie kliknutia na jedno z tlacidiel.<br>
//      * Kazde tlacidlo ma vlastnu definovanu cinnost
//      * @param e   udalost
//      */
//     public void actionPerformed(ActionEvent e) {
//         String s = e.getActionCommand(); //---- Nazov pouziteho tlacidla 
// 
//         String oznam = "";
// //         if (s.compareTo(btnPridajZviera.getLabel()) == 0) { //---------------------
//         if (s.equals(btnPridajZviera.getText())) { //---------------------
//             Zivocich zviera = vytvorZivocicha();
//             if (zoo.pridajZivocicha(zviera)) {  // podarilo sa
//                 oznam = "Vlozeny zivocich: " + zviera;
//             } else {                            // nepodarilo
//                 oznam = "Zoo je uz plna!";
//             }
//             txtaVystupy.setText(zoo.toString());
//         } else if (s.compareTo(btnOdstranZviera.getText()) == 0) { //------------
//             int pozicia = MojeMetody.vlozInt("Vloz index zvierata") - 1;
//             oznam = "Zviera c. " + (pozicia + 1);
//             if (zoo.odstranZivocicha(pozicia) != null) {
//                 oznam += " bolo vymazane";
//             } else {
//                 oznam += " nebolo najdene";
//             }
//         } else if (s.compareTo(btnGener10Zvierat.getText()) == 0) { //------------
//             generuj10Zvierat();
//             oznam = "Bolo pridanych 10 zvierat";
//         }
// 
//         txtaVystupy.setText(zoo.toString());
//         MojeMetody.disp(oznam);
//     }
// 
// 
//     /**
//      * Vytvorenie zivocicha
//      */
//     private Zivocich vytvorZivocicha() {
//         final String[] zFarba = {"cervena", "zelena", "modra", "zlta", "zlto-zelena"};
//         Zivocich zviera = null;
//         double kolkoVazi = 0.0;
// 
//         //-- Vygenerujeme zviera
//         int vygenerovane = 1 + generator.nextInt(4); //cislo <1,4>
// 
//         switch (vygenerovane) {
//             case 1: //blcha                       
//                 double kolkoDoskoci=3 * generator.nextDouble() ; //cislo <0;2.99>
//                 double kolkoVyskoci=3 * generator.nextDouble() ; //cislo <0;2.99>
//                 zviera=new Blcha(6,kolkoDoskoci,kolkoVyskoci);
//                 break;
//             case 2: //simpanz
//                 kolkoVazi=3 + (97 * generator.nextDouble());  //cislo <3;99.9>
//                 boolean cviceny;
//                 cviceny=generator.nextBoolean();                   
//                 zviera=new Simpanz(kolkoVazi,cviceny);
//                 break;
//             case 3: //papagaj
//                 kolkoVazi = 0.1 + (5*generator.nextDouble());    // cislo <0.1; 6>
//                 String farba = zFarba[generator.nextInt(5)];     // farba zo zoznamu
//                 zviera = new Papagaj("Ara", 2, kolkoVazi, farba); 
//                 break;
//             case 4: //krokodil
//                 kolkoVazi=20 + (480*generator.nextDouble());   //cislo <20;500> 
//                 int pocet=generator.nextInt(50);         //pocet zubov bude <0,49>
//                 zviera=new Slon(kolkoVazi,pocet);
//                 break;
//         }//switch
//         return zviera;
//     }
// 
//     private void generuj10Zvierat(){
//         for (int i = 0; i < 10; i++) {
//             zoo.pridajZivocicha(vytvorZivocicha());
//         }
//     }

    public static void main(/*String[] args*/) {
            new GUIpovodne().setVisible(true); 
    }
}
