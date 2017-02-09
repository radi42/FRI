package dijkstra;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

/**
 * Dijkstrov algoritmus
 * 
 * implementacia Dijkstrovho algoritmu v Jave
 * Hlada najkratsiu cestu zo zaciatocneho bodu do koncoveho bodu v hranovo
 * ohodnotenom grafe
 * @author Andy
 */
class Dijkstra {
    
    /*
    Matica incidencii
    na jednej strane uklada vrcholy, na druhej hrany
    matica ukazuje, ci je vrchol s hranou incidentny tj. ci vrchol patri hrane
    uklada zadanie
    */
    private Map<String, Map<String, Integer> > matrix = 
            new HashMap<String, Map<String, Integer> >();
    
    /*
    uklada odhady vzdialenosti
    String - nazov vrchola
    Integer - vzdialenosti vrcholov
    */
    private Map<String, Integer> distances = new HashMap<String, Integer>();
    
    /*
    Uklada dlzku moznej najkratsej cesty
    */
    int possiblyBetterDistance = 0;
    
    
    
    //Metody
    /**
     * pridaj novy uzol
     * @param newNode nazov noveho uzla
     */
    private void addNode(String newNode){
        // na koniec kazdeho zoznamu prida mapovanie node->0
        for(Map<String, Integer> row : matrix.values() ){
            row.put(newNode, 0);
        }
        
        // prida novy zoznam dlzky pocetUzlov + 1 plny nul
        Map<String, Integer> list = new HashMap<String, Integer>();
        for(String n : matrix.keySet() ){
            list.put(n, 0);
        }
        list.put(newNode, 0);
        matrix.put(newNode, list);
    }
    
    /**
     * odstran uzol
     * @param node nazov uzla
     */
    protected void removeNode(String node){
        matrix.remove(node);
        for(Map<String, Integer> row : matrix.values() ){
            row.remove(node);
        }
    }
    
    /**
     * pridava hrany
     * @param node1 uzol 1
     * @param node2 uzol 2
     * @param weight cena hrany
     */
    public void addEdge(String node1, String node2, int weight){
        if(!matrix.containsKey(node1) ) {addNode(node1); } 
        if(!matrix.containsKey(node2) ) {addNode(node2); } 
        
        //pre orientovane grafy
        matrix.get(node1).put(node2, weight);
        
        //pre neorientovane grafy treba doplnit opacnu hranu
        matrix.get(node2).put(node1, weight);
    }
    
    /**
     * ziskat pristup ku vsetkym uzlom
     * @return zoznam uzlov
     */
    public Set<String> getNodes(){
        return matrix.keySet();
    }
    
    /**
     * 
     * @param sourceNode zdrojovy uzol
     * @param destinationNode cielovy uzol
     * @return zoznam uzlov najkratsej cesty
     */
    public List<String> findPath(String sourceNode, String destinationNode){
        //inicializuj vsetky vrcholy na nekonecnu vzdialenost
        for(String node : getNodes() ){
            distances.put(node, Integer.MAX_VALUE);
        }
        //inicializuj zaciatocny vrchol na nulovu vzdialenost
        distances.put(sourceNode, 0);
        
        Map<String, String> predecessors = new HashMap<String, String>();
        String currentNode = null;
        
        //prehladavame uzly a hladame najblizsi
        while((currentNode = findNearestNode() ) != null){
            for(String adjacentNode : findAdjacentNodes(currentNode) ){
                possiblyBetterDistance = distances.get(currentNode) + 
                        distance(currentNode, adjacentNode);
                //ak je nova cesta kratsia ako povodna
                if(possiblyBetterDistance < distances.get(adjacentNode) ){
                    //nastav susedny vrchol na tuto hodnotu
                    distances.put(adjacentNode, possiblyBetterDistance);
                    //a pridaj aktualny uzol do zoznamu predchodcov
                    predecessors.put(adjacentNode, currentNode);
                }
            }
            removeNode(currentNode);
            distances.remove(currentNode);
        }
        
        List<String> path = new ArrayList<String>();
        String predecessor;
        String node = destinationNode;
        path.add(destinationNode);
        while((predecessor = predecessors.get(node) ) != null ){
            path.add(0, predecessor);
            node = predecessor;
        }
        
        return path;
    }

    /**
     * hlada najblizsi uzol 
     * @return dlzka cesty k najblizsiemu uzlu
     */
    private String findNearestNode() {
        int minimum = Integer.MAX_VALUE;
        String nearestNode = null;
        for(Entry<String, Integer> entry : distances.entrySet() ){
//            if(minimum > entry.getValue() ){
            if(entry.getValue() < minimum ){
                minimum = entry.getValue();
                nearestNode = entry.getKey();
            }
        }
        return nearestNode;
    }

    /**
     * hlada uzly, ktore su susedne k aktualnemu uzlu
     * @param currentNode
     * @return 
     */
    private Set<String> findAdjacentNodes(String node) {
        Set<String> adjacentNodes = new HashSet<String>();
        for(Entry<String, Integer> item : matrix.get(node).entrySet() ){
            if(item.getValue() > 0){
                adjacentNodes.add(item.getKey() );
            }
        }
        return adjacentNodes;
    }

    /**
     * 
     * @param node1 uzol 1
     * @param node2uzol 2
     * @return vzdialenost dvoch uzlov
     */
    private int distance(String node1, String node2) {
        return matrix.get(node1).get(node2);
    }
    
    public int getPossiblyBetterDistance(){
        return possiblyBetterDistance;
    }
}
