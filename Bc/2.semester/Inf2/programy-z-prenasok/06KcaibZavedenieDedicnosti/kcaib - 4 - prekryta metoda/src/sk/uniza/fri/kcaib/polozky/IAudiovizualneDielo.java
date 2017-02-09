/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sk.uniza.fri.kcaib.polozky;

/**
 *
 * @author janik
 */
public interface IAudiovizualneDielo {

    String dajTitul();

    String dajKomentar();

    void pridajKomentar(String paKomentar);

    void vypis(); //no do boha, ked to chcem vypisat do messageboxu, treba tuto metodu zmenit z void na String a potom vsade preprogramovat metodu vypis tak aby vracala String
}
