 

import lib.*;
/**
 * <h2>Aplikacna trieda Main</h2>
 * 
 * @author Bene
 * @version 18.4.2012
 */
public abstract class Main
{
    /** Aplikacna metoda */
    public static void main(){
        String str = MojeMetody.vlozString("T = Terminal, inak GUI");
        if (str == null) str = "";

        if (str.equalsIgnoreCase("T"))  Terminal.start();
        else                            new GUI().setVisible(true);
    }
}
