package lib;

import javax.swing.JOptionPane;

/**
 * Trieda MojeMetody
 * 
 * implementuje univerzalne metody vypisu, zobrazovania a vstupu
 * @author Andrej Sisila
 */
public class MojeMetody {
    /**
     * Vlozenie celeho cisla cez klavesnicu
     * @param prompt  text vyzvy pred vstupom
     * @return  vlozenia celociselna hodnota
     */
    public static Integer vlozInt(String prompt){
        Integer hodnota = null;
        String message = prompt;
        boolean ok = false;
        do{
            try{
                String inputStr = JOptionPane.showInputDialog(message);
                if (inputStr == null)
                    return null;
                hodnota = Integer.valueOf(inputStr);
                ok = true;
            }catch (java.lang.NumberFormatException ex){
                message = "Musi byt cele cislo!\n" + prompt;
            }
        }while (!ok);
        return hodnota;
    }
    
    /**
     * 
     * @return vracia privitanie
     */
    public static String hlavickaApp(String privitanie){
        System.out.println(privitanie);
        return privitanie;
    }
    
    public static void disp(Object obj){
        JOptionPane.showMessageDialog(null, obj);
    }
}