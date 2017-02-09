/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package zoo;

/**
 *
 * @author Andy
 */
public class Main {
    
    public static void main(String[] args) {
        int aplik = 1;
        switch(aplik){
            case 0:
                Terminal.main(args);
                break;
            case 1:
                //GUI
                GUI.main(args);
                break;
        }
    }
}
