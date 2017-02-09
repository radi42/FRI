package sk.uniza.fri.kcaib.databaza;

import java.util.ArrayList;
import java.util.Iterator;
import sk.uniza.fri.kcaib.polozky.CD;

public class Katalog {

    private ArrayList<CD> aZoznamCD;

    public Katalog() {
        aZoznamCD = new ArrayList<CD>();
    }

    public void pridaj(CD paNoveCD) {
        aZoznamCD.add(paNoveCD);
    }

    public void vypisPolozky() {
        for (CD cd : aZoznamCD) {
            cd.vypis();
            System.out.println("==============================================");
        }
    }
    
    public void vypisPolozky2(){
        Iterator<CD> prst = aZoznamCD.iterator();
        while(prst.hasNext() ){
            CD cd = prst.next();
            cd.vypis();
            System.out.println("==============================================");
        }
    }
}
