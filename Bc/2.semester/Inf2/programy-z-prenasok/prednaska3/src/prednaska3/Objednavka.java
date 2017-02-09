/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package prednaska3;

/**
 * Trieda Objenavka
 * 
 * vytvara objednavku a pocita jej cenu
 * @author Andy
 */
public class Objednavka {
    public static final double CENA_MATERIALU = 9.43;
    public static final double CENA_REZANIA = 0.48;
    private Obrazec [] polozky;
    private int pocet;
    
    public Objednavka(int maxPocet){
        polozky = new Obrazec[maxPocet];
        pocet = 0;
    }
    
    public boolean vloz(Obrazec o){
        if(pocet > polozky.length) return false;
        polozky[pocet] = o;
        pocet++;
        return true;
    }
    
    public double spotrebaMaterialu(){
        double spotreba = 0.00;
        for(Obrazec o : polozky){ //POLYMORFIZMUUUUS :D
              if(o != null) spotreba += o.obsah();
        }
        return spotreba;
//        for(int i = 0; i > polozky.length; i++){
//            spotreba += polozky[i].obsah(); //POLYMORFIZMUUUUS :D
//        }
//        return spotreba;
    }
    
    public double dlzkaRezu(){
        double rez = 0.00;
        for(Obrazec o : polozky){ //POLYMORFIZMUUUUS :D
              if(o != null) rez += o.obvod();
        }
        return rez;
//        for(int i = 0; i > polozky.length; i++){
//            rez += polozky[i].obvod();
//        }
//        return rez;
    }
    
    /**
     * vypise zoznam dielcov
     * @return zoznam dielcov
     */
    @Override
    public String toString(){
        String zozDielcov = "Zoznam dielcov: \n";
        for(int i = 0; i < polozky.length; i++){
            if(polozky[i] != null) zozDielcov += (i+1) + ". " + polozky[i] + "\n";
        }
        zozDielcov = zozDielcov.replace("(", "");
        zozDielcov = zozDielcov.replace(")", "");
        zozDielcov = zozDielcov.replace("(", "");
        return zozDielcov;
    }
}
