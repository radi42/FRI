package zoo;


import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.HeadlessException;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Random;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextArea;
import lib.MojeMetody;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Andy
 */
public class GUI extends JFrame implements ActionListener{
    
    private JPanel pnlMenu;
    private JButton btnPridajZviera;
    private JButton btnPridajDesatZvierat;
    private JTextArea txtaVystupy;
    private Zoo zoo = new Zoo();
    private static Random rng = new Random();

    /**
     * Konstruktor GUI - grafickeho rozhrania
     * @throws HeadlessException 
     */
    public GUI() throws HeadlessException {
        super.setTitle("Zoologicka zahrada");
        this.setLayout(new BorderLayout() ); //umiestnenie podla svetovych stran
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        
        menu();
        
        txtaVystupy = new JTextArea(zoo.info(), 20, 70);
        this.add(txtaVystupy, BorderLayout.CENTER);
        
        //Nastavenie parametrov okna
        this.pack();
        this.setSize(800, 600); //rozmery okna
        this.setLocation(100, 200); //umiestnenie okna na obrazovke
    }
    
    public static void main(String[] args) {
        new GUI().setVisible(true); //zviditelni okno; ak false skryjeme okno, ALE aplikacia bude bezat, aj ked nic nebudeme vidiet   
    }
    
    /**
     * metoda na zostrojenie panelu (JPanel)
     */
    private void menu(){
        pnlMenu = new JPanel();
        pnlMenu.setLayout(new FlowLayout() ); //rozlozenie komponentov
        
        //vytvorenie tlacitka a pridanie ho do panela
        btnPridajZviera = new JButton("Pridaj zviera");
        this.add(pnlMenu, BorderLayout.SOUTH );
        pnlMenu.add(btnPridajZviera);
        btnPridajZviera.addActionListener(this); //priradi listener tlacitku
        
        btnPridajDesatZvierat = new JButton("Pridaj 10 zvierat");
        pnlMenu.add(btnPridajDesatZvierat);
        btnPridajDesatZvierat.addActionListener(this);
        
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        String s = e.getActionCommand(); // zisti napis na tlacitku
        
        String oznam = "";
        
        if(s.equals(btnPridajZviera.getText() ) ){
            Zivocich zviera = vytvorZviera();
                if (zoo.getZverinecZOO().pridajZviera(zviera) ){
                    oznam = "Vložený živocích:\n" + zviera;
                }
                else{
                    oznam = "Zoo je už plná!";
                }
        }
        if(s.equals(btnPridajZviera.getText() ) ){
            generuj10Zvierat();
            MojeMetody.disp("FOO");
            oznam = "Pridanych nahodne 10 zvierat!";
        }
        txtaVystupy.setText(zoo.info() );
        MojeMetody.disp(oznam);
    }
    
    private Zivocich vytvorZviera() {
     final String[] zFarba = {"cervena", "zelena", "modra", "zlta", "zlto-zelena"};
        Zivocich zviera = null;
        double kolkoVazi = 0.0;
        

        //-- Vygenerujeme zviera
        int vygenerovane = 1 + rng.nextInt(4); //cislo <1,4>

        switch (vygenerovane) {
            case 1: //blcha                       
                double kolkoDoskoci=3 * rng.nextDouble() ; //cislo <0;2.99>
                double kolkoVyskoci=3 * rng.nextDouble() ; //cislo <0;2.99>
                zviera=new Blcha(6,kolkoDoskoci,kolkoVyskoci);
                break;
            case 2: //simpanz
                kolkoVazi=3 + (97 * rng.nextDouble());  //cislo <3;99.9>
                boolean cviceny;
                cviceny=rng.nextBoolean();                   
                zviera=new Simpanz(kolkoVazi,cviceny);
                break;
            case 3: //papagaj
                kolkoVazi = 0.1 + (5*rng.nextDouble());    // cislo <0.1; 6>
                String farba = zFarba[rng.nextInt(5)];     // farba zo zoznamu
                zviera = new Papagaj("Ara", 2, kolkoVazi, farba); 
                break;
            case 4: //slon
                kolkoVazi=20 + (480*rng.nextDouble());   //cislo <20;500> 
                int pocet=rng.nextInt(50);               //pocet zubov bude <0,49>
                zviera=new Slon(kolkoVazi,pocet);
                break;
        }
        return zviera;
    }
    
    private void generuj10Zvierat(){
        for (int i = 0; i < 10; i++) {
            zoo.getZverinecZOO().pridajZviera(vytvorZviera() );
        }
    }
}
