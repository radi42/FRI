package maticazosuboru;

import java.io.FileNotFoundException;

/**
 * Trieda MaticoveOperacieMain sa stara o vypis vysledkov metod
 * @author Andy
 */
public class MaticoveOperacieMain {
    public static void main(String[] args) throws FileNotFoundException{
        MaticoveOperacie mo = new MaticoveOperacie(50, 50);
        mo.citaj("matrix.txt");
        mo.vypisPrvky();
        System.out.println(mo.scitajRiadok() );
    }
}
