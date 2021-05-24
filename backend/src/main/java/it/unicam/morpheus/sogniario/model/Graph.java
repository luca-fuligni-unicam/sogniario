package it.unicam.morpheus.sogniario.model;

import lombok.Getter;

import java.util.*;

public class Graph {

    @Getter
    private final Map<String, List<String>> adj;

    public Graph() {
        this.adj = new LinkedHashMap<>();
    }

    void addEdge(String u, String v) {

        List<String> temp;

        if(this.adj.get(u) == null)
            adj.put(u, new ArrayList<>());
        temp = adj.get(u);
        temp.add(v);
        adj.put(u, temp);

        /*
        if(this.adj.get(v) == null)
            adj.put(v, new ArrayList<>());
        temp = this.adj.get(v);
        temp.add(u);
        this.adj.put(v, temp);

         */
    }
}
