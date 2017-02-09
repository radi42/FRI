package lib;

import javax.swing.JOptionPane;

/**
 * <h2>Abstraktna trieda MM - moje staticke metody</h2>
 * 
 * @author Bene
 * @version V1.1
 */
public abstract class MojeMetody
{
    //----------------------------------- Metody pre vypisy do terminaloveho okna --
    //
    /**
     * Vypis nadpisovej hlavicky aplikacie na terminal 
     * @param message text hlavicky
     */
    public static void hlavickaApp(String message) {
        String str = "\t****  " + message + "  ****\n";
        System.out.println(str);
    }

    /**
     * Vypis nadpisovej hlavicky aplikacie na terminal 
     * @param clear   <b>true</b> - vymazanie terminaloveho okna;
     *                <b>false</b> - bez vymazania
     * @param message text hlavicky
     */
    public static void hlavickaApp(boolean clear, String message) {
        String str = "\t****";
        if (clear) str = "\f\t***";
        for (int i=0; i<message.length(); i++) str += "*";
        str += "***\n\t*  " + message + "  *\n";
        System.out.println(str);
    }

    /** Vypis ukoncenia aplikacie na terminal */
    public static void koniecApp() {
        System.out.println("\n\t****  K o n i e c   aplikacie  ****\n");
    }

    /** Vypis textu do terminaloveho okna bez odriadkovania
     * @param obj objekt vypisu
     */
    public static void print(Object obj) { System.out.print(obj); }

    /** Vypis textu do terminaloveho okna s odriadkovanim
     * @param obj objekt vypisu
     */
    public static void println(Object obj) { System.out.println(obj); }

    //------------------------------------------------- Vypisy do dialogovych okien --
    //
    /** Vypis spravy do dialogoveho okna
     * @param str  text spravy
     */
    public static void disp(Object obj) {
        JOptionPane.showMessageDialog(null, obj);
    }

    /** Vypis spravy s titulkom do dialogoveho okna
     * @param str  text spravy
     * @param titl text titulku do nadpisoveho panelu
     */
    public static void disp(Object obj, String titl) {
        JOptionPane.showMessageDialog(null, obj, titl, JOptionPane.INFORMATION_MESSAGE);
    }

   //--------------------------------------------------- Vstupy cez dialogove okna --
   //
    /**
     * Vlozenie textoveho retazca cez klavesnicu
     * @param prompt  text vyzvy pred vstupom
     * @return  vlozeny text
     */
    public static String vlozString(String prompt) {
        return JOptionPane.showInputDialog(prompt);
    }

    /**
     * Vlozenie double hodnoty cez klavesnicu
     * @param prompt  text vyzvy pred vstupom
     * @return  vlozena double hodnota
     */
    public static Double vlozDouble(String prompt) {
        Double hodnota = null;
        String message = prompt;
        boolean ok = false;
        do {
            try {
                String inputStr = JOptionPane.showInputDialog(message);
                hodnota = Double.valueOf(inputStr);
                ok = true;
            } catch (java.lang.NumberFormatException ex) {
                message = "    !!!!!! musi byt cislo !!!!!!\n" + prompt;
            }
        } while (!ok);
        return hodnota;
    }

    /**
     * Vlozenie celeho cisla cez klavesnicu
     * @param prompt  text vyzvy pred vstupom
     * @return  vlozena celociselna hodnota
     */
    public static Integer vlozInt(String prompt) {
        Integer hodnota = null;
        String message = prompt;
        boolean ok = false;
        do {
            try {
                String inputStr = JOptionPane.showInputDialog(message);
                if (inputStr == null) return null;
                hodnota = Integer.valueOf(inputStr);
                ok = true;
            } catch (java.lang.NumberFormatException ex) {
                message = "    !!!!!! musi byt cele cislo !!!!!!\n" + prompt;
            }
        } while (!ok);
        return hodnota;
    }

}
