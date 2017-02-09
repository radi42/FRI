package data;

/**
 *
 * @author Michal Varga
 */
public class Person {
    private String aName;
    private int aAge;
    
    public Person(String paName, int paAge) {
        aName = paName;
        aAge= paAge;
    }
    
    public String getName() {
        return aName;
    }
    
    public void setName(String paName) {
        aName = paName;
    }
    
    public int getAge() {
        return aAge;
    }
    
    public void setAge(int paAge) {
        aAge = paAge;
    }
    
    @Override
    public String toString() {
        return aName + " " + aAge;
    }
}
