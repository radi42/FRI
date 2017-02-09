/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package kruskalovalgoritmus;

import java.util.Comparator;

/**
 *
 * @author Andy
 */
public class PorovnavacHranOdNajvacsej implements Comparator<Hrana> {
    
    public int compare(Hrana h1, Hrana h2){
        if (h1.getCenaHrany()< h2.getCenaHrany()) return 1;
        if (h1.getCenaHrany() == h2.getCenaHrany()) return 0;
        else return -1;
    }
}