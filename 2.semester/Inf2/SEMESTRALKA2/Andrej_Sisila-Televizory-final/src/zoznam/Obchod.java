package zoznam;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.EOFException;
import televizory.*;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


/**
 * Trieda Main
 * Zobrazuje dynamicke uzivatelske prostredie (input- a messagebox)
 * 
 * @author Andrej Šišila
 */
public class Obchod {
    
    private List<ITelka> aObchod;
    
    /**
     * Bezparametricky konstruktor
     * 
     * vytvara ArrayList, ktoreho polozky patria interface-u ITelka
     */
    public Obchod(){
        aObchod = new ArrayList<ITelka>();
    }
    
    /**
     * Pridava televizor do zoznamu
     * @param paTelka urcity druh televizora
     */
    public void pridaj(ITelka paTelka){
        aObchod.add(paTelka);
    }
    
    /**
     * @return vracia cely List aObchod
     */
    public List<ITelka> getObchod() {
        return aObchod;
    }
    
    /**
     * @return vrati vsetky televizory v poli
     */
    public String vypisVsetkyTV(){
        String vypis = "";
        int i = 1;
        for(ITelka tv : aObchod){
            vypis += String.format("%d. %s %n", i, tv.vypis() );
            i++;
        }
        return vypis;
    }
    
    /**
     * zapis do suboru
     * 
     * odvolava sa na prekrytu metodu "zapisData()" z tried potomkov
     */
    public void zapisDataZoznam() throws FileNotFoundException, IOException{
        FileOutputStream fos = new FileOutputStream("obchodik.dat");
        BufferedOutputStream bos = new BufferedOutputStream(fos);
        DataOutputStream dos = new DataOutputStream(bos);
        
        for(ITelka tv : aObchod){
             dos.writeUTF(tv.zapisData() );
        }
        dos.close();
        bos.close();
        fos.close();
    }

    /**
     * citaj datovy subor - kazdy atribut na novom riadku
     * 
     * atributy cita v poradi:
     * nazov triedy potomka, cena, uhlopriecka, specialne vlastnosti /led, stereo, 3D/, stav /zapnuty.vypnuty/
     * kazdy atribut je na novom riadku
     */
    public void citajDataZoznam() throws IOException{
        FileInputStream fis = new FileInputStream("obchodik.dat");
        BufferedInputStream bis = new BufferedInputStream(fis);
        DataInputStream dis = new DataInputStream(bis);
        
        String triDee = "";
        String stereo = "";
        String led = "";
        
        String nazovTv = "";
        String cena = "";
        String uhlopriecka = "";
        
        ITelka tv = null;
        
        aObchod.clear();
        
        try{
            //citaj subor riadok po riadku az kym nedojdes na koniec
            while(dis.available() > 0 ){
                nazovTv = dis.readLine().substring(3); //orez prve tri znaky nazvu telky
                cena = dis.readLine();
                uhlopriecka =  dis.readLine();

                switch(nazovTv){
                    case "televizory.TelkaCrt":
                        stereo = dis.readLine();
                        String zapnuty = dis.readLine();
                        tv = new TelkaCrt(Integer.parseInt(cena), Integer.parseInt(uhlopriecka), Boolean.parseBoolean(zapnuty), Boolean.parseBoolean(stereo) );
                        if(Boolean.parseBoolean(zapnuty) ){
                            tv.prepniProgramNahodne();
                        }
                        aObchod.add(tv);
                        break;

                    case "televizory.TelkaLcd":
                        led = dis.readLine();
                        zapnuty = dis.readLine();
                        tv = new TelkaLcd(Integer.parseInt(cena), Integer.parseInt(uhlopriecka), Boolean.parseBoolean(zapnuty), Boolean.parseBoolean(led) );
                        if(Boolean.parseBoolean(zapnuty) ){
                            tv.prepniProgramNahodne();
                        }
                        aObchod.add(tv);
                        break;

                    case "televizory.TelkaPlazma":
                        triDee = dis.readLine();
                        zapnuty = dis.readLine();
                        tv = new TelkaPlazma(Integer.parseInt(cena), Integer.parseInt(uhlopriecka), Boolean.parseBoolean(zapnuty), Boolean.parseBoolean(triDee) );
                        if(Boolean.parseBoolean(zapnuty) ){
                            tv.prepniProgramNahodne();
                        }
                        aObchod.add(tv);
                        break;

                    default:
                        
                }
            }
        } catch(EOFException ex){
            System.out.println("Pokusas sa citat za koncom suboru");
        } catch(NumberFormatException ex){
            System.out.println("Citas nespravny format cisla do ciselnej premennej \n" + ex);
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
