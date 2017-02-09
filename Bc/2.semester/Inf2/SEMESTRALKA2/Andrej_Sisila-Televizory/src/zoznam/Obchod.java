package zoznam;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.EOFException;
import televizory.*;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import javax.swing.JOptionPane;

/**
 *
 * @author Andy
 */
public class Obchod {
    
    private List<ITelka> obchod;
    
    public Obchod(){
        obchod = new ArrayList<ITelka>();
    }
    
    /**
     * Pridava televizor do zoznamu
     * @param paTelka urcity druh televizora
     */
    public void pridaj(ITelka paTelka){
        obchod.add(paTelka);
    }

    public List<ITelka> getObchod() {
        return obchod;
    }
    
    /**
     * @return vrati vsetky televizory v poli
     */
    public String vypisVsetkyTV(){
        String vypis = "";
        int i = 1;
        for(ITelka tv : obchod){                                   //for-each funguje
            vypis += String.format("%d. %s %n", i, tv.vypis() );
            i++;
        }
        return vypis;
    }
    
    /**
     *  zapis do suboru - to iste len v bledomodrom
     */
    public void zapisDataZoznam() throws FileNotFoundException, IOException{
        FileOutputStream fos = new FileOutputStream("obchodik.dat");
        BufferedOutputStream bos = new BufferedOutputStream(fos);
        DataOutputStream dos = new DataOutputStream(bos);
        
        for(ITelka tv : obchod){
             dos.writeUTF(tv.zapisData() );
        }
        dos.close();
        bos.close();
        fos.close();
    }

    /**
     * citaj datovy subor - kazdy atribut na novom riadku
     * 
     * opravit vynimku EOFException, FileNotFoundException
     */
    public void citajDataZoznam() throws IOException{
        FileInputStream fis = new FileInputStream("obchodik.dat");
        BufferedInputStream bis = new BufferedInputStream(fis);
        DataInputStream dis = new DataInputStream(bis);
        
        String nazovTv = "";
        int cena = 0;
        int uhlopriecka = 0;
        boolean zapnuty = false;

        obchod.clear();
        
        try{
            //citaj subor riadok po riadku
            while(dis.available() > 0 ){
                nazovTv = dis.readLine().substring(3);
                cena = Integer.parseInt(dis.readLine() );
                uhlopriecka = Integer.parseInt(dis.readLine() );
                zapnuty = Boolean.getBoolean(dis.readLine() );

                switch(nazovTv){
                    case "televizory.TelkaCrt":
                        boolean stereo = Boolean.getBoolean(dis.readLine() );
                        obchod.add(new TelkaCrt(cena, uhlopriecka, zapnuty, stereo) );
                        //dis.readLine();
                        break;

                    case "televizory.TelkaLcd":
                        boolean led = dis.readBoolean();
                        obchod.add(new TelkaLcd(cena, uhlopriecka, zapnuty, led) );
                        //dis.readLine();
                        break;

                    case "televizory.TelkaPlazma":
                        boolean triDee = dis.readBoolean();
                        obchod.add(new TelkaPlazma(cena, uhlopriecka, zapnuty, triDee) );
                        dis.readLine();
                        break;

                    default:
                        continue;
                }
            }
        } catch(EOFException ex){
//            System.out.println("Snazis sa citat za koncom suboru \n" + ex);
        } catch(NumberFormatException ex){
//            System.out.println("Citam nespravny format cisla do ciselnej premennej \n" + ex);
        }
        
        finally{
            dis.close();
            bis.close();
            fis.close();
        }
    }
    
    @Override
    public String toString(){
        return vypisVsetkyTV();
    }
}
