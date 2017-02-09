package gui;

import java.util.Random;
import javax.swing.JOptionPane;

/**
 *
 * @author Michal Varga
 */
public class Routines {
    
    private final static String VOWELS = "aeiouy";
    private final static String CONSONANTS = "bcdfghjklmnpqrstvwxz";
    private final static Random aRand = new Random();
    
    
    /**
     * Invokes a dialog to get non negative integer value.
     * @param paPrompt prompt message.
     * @return entered integer value. If any error occurs return -1.
     */
    public static int getIntDialog(String paPrompt) {
        try {
            return Integer.parseInt(JOptionPane.showInputDialog(paPrompt));
        }
        catch(Exception ex) {
            return -1;
        }
    }
    
    /**
     * Invokes a yes-no dialog.
     * @param paMessage message of the dialog.
     * @param paTitle title of the dialog.
     * @return true, if "yes" was chosen, false otherwise.
     */
    public static boolean confirmDialog(String paMessage, String paTitle) {
        return JOptionPane.YES_OPTION == JOptionPane.showConfirmDialog(null, paMessage, paTitle, JOptionPane.YES_NO_OPTION); 
    }
    
    /**
     * Builds a string of altering random consonants and vowels.
     * @param paLength length of resulting string.
     * @return string of altering random consonants and vowels
     */
    public static String randomString(int paLength) {
        String str = "";
        
        for(int i = 0; i < paLength; i++) {
            String s = i % 2 == 0 ? CONSONANTS : VOWELS;
            str += s.charAt(random(s.length()));
        }
        
        return str;
    }
    
    /**
     * Generates a random value from the interval <0,paInterval)
     * @param paInterval high bound of the interval.
     * @return random value from the interval <0,paInterval)
     */
    public static int random(int paInterval) {
        return aRand.nextInt(paInterval);
    }
    
    /**
     * Show up an info box with OK button.
     * @param paMessage message of the info box.
     * @param paTitle title of the info box.
     */
    public static void infoBox(String paMessage, String paTitle) {
        JOptionPane.showMessageDialog(null, paMessage, "InfoBox: " + paTitle, JOptionPane.INFORMATION_MESSAGE);
    }
    
}
