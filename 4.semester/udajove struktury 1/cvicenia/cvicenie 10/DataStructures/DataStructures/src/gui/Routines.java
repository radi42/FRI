package gui;

import datastructures.frontStack.EFrontStack;
import datastructures.frontStack.IFrontStack;
import datastructures.lists.EList;
import datastructures.lists.IList;
import datastructures.priorityFronts.EPriorityFront;
import datastructures.priorityFronts.IPriorityFront;
import datastructures.tables.ETable;
import datastructures.tables.ITable;
import datastructures.tables.TablePair;
import datastructures.trees.ITree;
import datastructures.trees.ITreeNode;
import java.util.HashMap;
import java.util.Random;
import javax.swing.DefaultListModel;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.JTree;
import javax.swing.table.DefaultTableModel;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.DefaultTreeModel;
import javax.swing.tree.TreePath;

/**
 *
 * @author Michal Varga
 */
public class Routines {
    
    private final static String VOWELS = "aeiouy";
    private final static String CONSONANTS = "bcdfghjklmnpqrstvwxz";
    private final static Random aRand = new Random();
    
    
    /**
     * Invokes a dialog to get non negative integer value.
     * @param paPrompt prompt message.
     * @return entered integer value. If any error occurs return -1.
     */
    public static int getIntDialog(String paPrompt) {
        try {
            return Integer.parseInt(JOptionPane.showInputDialog(paPrompt));
        }
        catch(Exception ex) {
            return -1;
        }
    }
    
    /**
     * Invokes a yes-no dialog.
     * @param paMessage message of the dialog.
     * @param paTitle title of the dialog.
     * @return true, if "yes" was chosen, false otherwise.
     */
    public static boolean confirmDialog(String paMessage, String paTitle) {
        return JOptionPane.YES_OPTION == JOptionPane.showConfirmDialog(null, paMessage, paTitle, JOptionPane.YES_NO_OPTION); 
    }
    
    /**
     * Builds a string of altering random consonants and vowels.
     * @param paLength length of resulting string.
     * @return string of altering random consonants and vowels
     */
    public static String randomString(int paLength) {
        String str = "";
        
        for(int i = 0; i < paLength; i++) {
            String s = i % 2 == 0 ? CONSONANTS : VOWELS;
            str += s.charAt(random(s.length()));
        }
        
        return str;
    }
    
    /**
     * Generates a random value from the interval <0,paInterval)
     * @param paInterval high bound of the interval.
     * @return random value from the interval <0,paInterval)
     */
    public static int random(int paInterval) {
        return aRand.nextInt(paInterval);
    }
    
    /**
     * Show up an info box with OK button.
     * @param paMessage message of the info box.
     * @param paTitle title of the info box.
     */
    public static void infoBox(String paMessage, String paTitle) {
        JOptionPane.showMessageDialog(null, paMessage, "InfoBox: " + paTitle, JOptionPane.INFORMATION_MESSAGE);
    }
    
    /**
     * Show up an error box with OK button.
     * @param paMessage message of the error box.
     * @param paTitle title of the error box.
     */
    public static void errorBox(String paMessage, String paTitle) {
        JOptionPane.showMessageDialog(null, paMessage, "Error: " + paTitle, JOptionPane.ERROR_MESSAGE);
    }
    
    /**
     * Add all elements from iterable structure into JList.
     * @param paStructure structure to be listed.
     * @param paElementsCount number of listed elements.
     * @param paList list, where elements of structure will be presented.
     */
    private static void listStructureElements(Iterable paStructure, int paElementsCount, JList paList) {                     

        if(paElementsCount >= 100000 && 
           !Routines.confirmDialog("Structure contains " + paElementsCount + " elements,\ndo you want to print it?", "Structure too large!"))
            return;
        
        DefaultListModel<Object> dlm = new DefaultListModel<Object>();
                              
        for (Object person : paStructure)
            dlm.addElement(person);
        

        paList.setModel(dlm);
    }
    
    /**
     * Add all elements from list into JList.
     * @param paStructure list structure to be listed.
     * @param paList list, where elements of structure will be presented.
     */
    public static void listListElements(IList paStructure, JList paList) {
        try {
            Routines.listStructureElements(paStructure, paStructure.size(), paList);
        } catch (EList ex) {
            Routines.errorBox("Elements listing failed!", "Can not list elements: " + ex.getMessage());
        }
    }
    
    /**
     * Add all elements from list into JList.
     * @param paStructure list structure to be listed.
     * @param paTree tree, where elements of structure will be presented.
     */
    public static void listTreeElements(ITree paStructure, JTree paTree) {
        try {
            if(paStructure.isEmpty()) {
                paTree.setModel(new DefaultTreeModel(null));
                paTree.setRootVisible(false);
            }
            else {
                HashMap<ITreeNode<Object>,DefaultMutableTreeNode> map = new HashMap<ITreeNode<Object>,DefaultMutableTreeNode>();
                IList<ITreeNode> list = paStructure.levelOrder();
                DefaultMutableTreeNode root = null;
                
                for(ITreeNode treeNode : list) {
                    DefaultMutableTreeNode modelNode = new DefaultMutableTreeNode(treeNode);
                    map.put(treeNode, modelNode);
                    if(treeNode.getParent() != null) {
                        DefaultMutableTreeNode parentModelNode = map.get(treeNode.getParent());
                        parentModelNode.add(modelNode);
                    }
                    else
                        root = modelNode;
                }
                                
                paTree.setModel(new DefaultTreeModel(root));
                paTree.setRootVisible(true);
                paTree.setSelectionPath(new TreePath(root.getPath()));
                
                for (int i = 0; i < paTree.getRowCount(); i++) {
                    paTree.expandRow(i);
}
            }
        }
        catch (Exception ex) {
            Routines.errorBox("Elements listing failed!", "Can not list elements: " + ex.getMessage());
        }
    }
    
    public static void ListTableElements(ITable paStructure, JTable paTable) {
        DefaultTableModel dtm = new DefaultTableModel(0,0);
        dtm.setColumnIdentifiers(new String[] {"Key","Value"});
        paTable.setModel(dtm);
        for(Object pair : paStructure) 
            dtm.addRow(new Object[] { ((TablePair)pair).getKey(),
                                      ((TablePair)pair).getElement()
                                    });
    }
    
    /**
     * Add all elements from front (stack) into JList.
     * @param paStructure front (stack) structure to be listed.
     * @param paList list, where elements of structure will be presented.
     */
    public static void listFrontElements(IFrontStack paStructure, JList paList) {
        try {
            Routines.listStructureElements(paStructure, paStructure.size(), paList);
        } catch (EFrontStack ex) {
            Routines.errorBox("Elements listing failed!", "Can not list elements: " + ex.getMessage());
        }
    }
    
    /**
     * Add all elements from priority front into JList.
     * @param paStructure front (stack) structure to be listed.
     * @param paList list, where elements of structure will be presented.
     */
    public static void listPriorityFrontElements(IPriorityFront paStructure, JList paList) {
        try {
            if(paStructure.size() >= 100000 && 
                !Routines.confirmDialog("Structure contains " + paStructure.size() + " elements,\ndo you want to print it?", "Structure too large!"))
                 return;

             DefaultListModel<Object> dlm = new DefaultListModel<Object>();

             for (Object person : paStructure) {
                 dlm.addElement(person);
             }


             paList.setModel(dlm);
        } catch (EPriorityFront ex) {
            Routines.errorBox("Elements listing failed!", "Can not list elements: " + ex.getMessage());
        }
    }
    
}
