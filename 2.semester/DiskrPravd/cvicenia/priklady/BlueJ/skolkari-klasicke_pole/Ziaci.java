
/**
 * Vytvor dvojice 20 ziakov
 * Nezalezi na tom, ci je ziak A so ziakom B alebo ziak B so ziakom A, nezalezi na ich umiestneni v rade
 * 
 * @author Anrej Sisila
 *  @version v1.0
 */
public class Ziaci
{
    private int pocZiak; //pocet ziakov by mal byt parne cislo
    private Dvojica [] dvojiceZiakov; //pole ziakov
    private Dvojica dvojica;

    public Ziaci(int pocZiak, Dvojica dvojica) {
        this.pocZiak = pocZiak;
        dvojiceZiakov = new Dvojica[pocZiak];
    }

    public Ziaci() {
        this.pocZiak = 999;
        dvojiceZiakov = new Dvojica[pocZiak];
    }

    //metoda naplna pole ziakov cislami; kazde cislo reprezentuje jedneho ziaka
    public void naplnDvojiceZiakmi(){
//        int aktualnyPocet = 1;
//        dvojiceZiakov[0] = new Dvojica(1, 2);
//         for(int i = 0; i < 20; i++){
//             for(int j = 0; j < 19; j++){
// 
//                 for(int k = 0; k <= aktualnyPocet-1; k++){
//                     int ziak1 = dvojiceZiakov[k].getZiak1();
//                     int ziak2 = dvojiceZiakov[k].getZiak2();
// 
//                     if(i == j){
//                         continue;
//                     }else if(i+1 == ziak1 && j+1 == ziak2){
//                         continue;
//                     }else if(j+1 ==  ziak1 && i+1 == ziak2){
//                         continue;
//                     }else{
//                         dvojiceZiakov[i] = new Dvojica(i+1, j+1);
//                         aktualnyPocet++;
//                     }
//                 }
// 
//             }
//         }
            
            int pocet = 0;
            for(int i = 0; i < 20; i++){
                for(int j = 0; j < 20; j++){
                    if(i==j){
                        continue;
                    }else{
                        dvojiceZiakov[pocet] = new Dvojica(i+1, j+1);
                        System.out.println(dvojiceZiakov[pocet]);
                        pocet++;
                    }
                }
            }
            System.out.println("Pocet opakovani cyklu: " + pocet);
            System.out.println("Existuje " + ( (pocet/2)/19) + " rieseni" );
    }
    
    //vytvorit si pole ktore bude obsahovat dvojice
    public String toString() {
        naplnDvojiceZiakmi(); //najprv naplnime pole ziakov

        return "";
    }
}
//chyby algoritmu:
//dvojicu 18 19 a 19 18 berie za roznu => ma byt rovnaka
//ci je dvojica a kdekolvek v rade, vzdy je to ina dvojica v => ma byt rovnaka
