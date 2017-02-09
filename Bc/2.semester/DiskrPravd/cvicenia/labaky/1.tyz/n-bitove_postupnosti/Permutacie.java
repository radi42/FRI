import java.util.Scanner;
/**
 * Trieda Permutacie
 * Vypisuje vsetky kombinacie nul a jednotiek v n-tici
 * 
 * @author Andrej Sisila
 * @version v2.0
 */
public abstract class Permutacie
{
    //static Permutacie perm;
    static String[] prvky = {"0", "1"};
    
    /**
     * @param katice datovy typ int - udava pocet miest katice
     */
    public static String[] getVsetkyZoznamy(int katice)
    {
        //vytvorenie zoznamu, ktory bude obsahovat vsetky vyhovujuce moznosti
        String[] vsetkyZoznamy = new String[(int)Math.pow(prvky.length, katice)];

        //ak ma katica dlzy 1 vracia len prvky z pola, ktory obsahuje samotne prvky
        if(katice == 1){
            for(int i = 0; i < prvky.length; i++){
                System.out.println(prvky[i] );
            }
            return prvky; 
        }
        else
        {
            //rekurzia - zisti vsetky zoznamy dlzky n, n-1, ...  az po 3, 2, 1 a uloz vytvorene
            //katice do pola vsetkyPodzoznamy
            String[] vsetkyPodzoznamy = getVsetkyZoznamy(katice -1);

            String moznosti = "";
            
            //prirad podzoznamy ku kazdemu prvku
            int index = 0;
            //najprv prechadzaj pole prvkov
            for(int i = 0; i < prvky.length; i++)
            {
                //potom prejdi pole podzoznamov
                for(int j = 0; j < vsetkyPodzoznamy.length; j++)
                {
                    //pridaj novovytvorenu kombinaciu do zoznamu vsetkyZoznamy, kde pridavame
                    //postupne vsetky moznosti usporiadania prvkov
                    vsetkyZoznamy[index] = prvky[i] + vsetkyPodzoznamy[j];
                    //prirad premennej moznosti to iste, co do zoznamu vsetkyZoznamy
                    moznosti += prvky[i] + vsetkyPodzoznamy[j] + "\n";
                    index++;
                }
            }
            
            //vypise vsetky moznosti od dvojic po katicu
            System.out.print(moznosti);
            
            //nakoniec vrat 
            return vsetkyZoznamy;
        }
    }

    public static void main(String[] args) {
        System.out.print("Zadajte velkost katice: ");
        Scanner scan = new Scanner(System.in);
        int lenghtOfString = scan.nextInt();
        System.out.println();
        System.out.println(getVsetkyZoznamy(lenghtOfString) );
    }
}