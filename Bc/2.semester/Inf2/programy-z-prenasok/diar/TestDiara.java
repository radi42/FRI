import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

public class TestDiara
{
    private Den den1;
    private Udalost vymysliet;
    private Udalost vykonat;
    private Udalost zabudnut;

    @Before
    public void setUp()
    {
        den1 = new Den(1);
        vymysliet = new Udalost("Vymysliet", 1);
        vykonat = new Udalost("Vykonat", 2);
        zabudnut = new Udalost("Zabudnut", 1);
    }

    @Test
    public void testVytvorTriUdalosti()
    {
        Assert.assertTrue(den1.vlozUdalost(9, vymysliet));
        Assert.assertTrue(den1.vlozUdalost(10, vykonat));
        Assert.assertTrue(den1.vlozUdalost(12, zabudnut));
    }

    @Test
    public void testOtestujUdalost()
    {
        Assert.assertEquals(1, vymysliet.dajTrvanie());
        Assert.assertEquals(2, vykonat.dajTrvanie());
        Assert.assertEquals("Vymysliet", vymysliet.dajPopis());
        Assert.assertEquals("Vykonat", vykonat.dajPopis());
    }
}
