/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package zoo;

/**
 * <h2>Trieda Main.</h2>
 * Aplikačná trieda.
 *
 * @author bene
 * @version  V-0-2   [12.4.2014]
 */
public class Main {
    //////////////////////////////////////////////////-- Atribúty inštancie --

    ////////////////////////////////////////////////////-- Metódy inštancie --

    public static void main(String[] args) {
        int aplik = 2;
        switch (aplik) {
            case 0:
                Terminal.main(args);
                break;
            case 1:
                GUI.main(args);
                break;
            case 2:
                GUI_Desinger.main(args);
                break;
        }
        
    }
//=========================================== end of class Main ==
}
