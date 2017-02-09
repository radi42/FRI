

import static org.junit.Assert.*;
import org.junit.After;
import org.junit.Before;
//import org.junit.Test;

/**
 * The test class Test.
 *
 * @author  (your name)
 * @version (a version number or a date)
 */
public class Test
/*
 * vytvori testovaciu triedu
 * vsetky aktualne instancie vlozim do testu metodou Object Bench to Text Fixture
 * instancie dostanem z tiredy metodou Text Fixture to Object Bench
 */
{
    private Datum datum1;
    private Osoba osoba1;
    private Student student1;

    
    
    

    /**
     * Default constructor for test class Test
     */
    public Test()
    {
    }

    /**
     * Sets up the test fixture.
     *
     * Called before every test case method.
     */
    @Before
    public void setUp()
    {
        datum1 = new Datum();
        osoba1 = new Osoba("A", "Novak", datum1, "Zilina");
        student1 = new Student(osoba1, "Informatika", 1);
        System.out.println(student1);
    }

    /**
     * Tears down the test fixture.
     *
     * Called after every test case method.
     */
    @After
    public void tearDown()
    {
    }
}
