package gui;

/**
 * Interface provides basic functionality to work with custom data classes. 
 * @author Michal Varga
 */
public interface IEditData {
    /**
     * Creates new data. This method should invoke an editor to fill properties.
     * @return new data instance.
     */
    public Object createData();
    /**
     * Creates random data. Does not invoke an editor, instead fills up the attribues
     * with meaningful values. This method is used in structures testing.
     * @return new data instance randomly initialized.
     */
    public Object createRandomData();
    /**
     * Opens an editor and let user edit data given as parameter.
     * @param paData instance of data to modify.
     * @return true, if data was mdified (user pressed OK) false otherwise (Cancel).
     */
    public boolean editData(Object paData);
    /**
     * Opens an editor in READ ONLY mode. User can inspect fields of data.
     * @param paData instance of data to inspect.
     */
    public void inspectData(Object paData);
}
