package cielwerofhanoi;

import java.util.Scanner;

public class TowerOfHanoi {

    private static int pocetIteracii = 0;
    
    /**
     *
     * @param n pocet kotucov
     * @param a zdroj
     * @param b cez
     * @param c ciel
     */
    public static void hanoi(int n, String zdroj, String cez, String ciel) {
        if (n == 1) {
            System.out.println("Disk 1 z " + zdroj + " do " + ciel);
        } else {
            //posuvame kotuce z prveho stojana na druhy cez treti
            hanoi(n-1, zdroj, ciel, cez);
            System.out.println("Disk " + n + " z " + zdroj + " do " + ciel);
            hanoi(n-1, cez, zdroj, ciel);
            pocetIteracii++;
        }
    }
    

    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        System.out.println("Zadajte pocet kotucov: ");
        int n = scan.nextInt();
        hanoi(n, "A", "B", "C");
        System.out.println(pocetIteracii);
    }

}
