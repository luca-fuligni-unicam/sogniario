package it.unicam.morpheus.sogniario.model;

import lombok.Getter;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

/**
 * The class takes care of maintaining and loading a word list from txt file.
 */
@Getter
public class WordsFilter {

    private final List<String> list;

    public WordsFilter(String filename) {

        list = new ArrayList<>();

        try (FileReader fr = new FileReader("data/graphAndCloud/" + filename); BufferedReader in = new BufferedReader(fr)) {
            String str;
            while ((str = in.readLine()) != null) {
                list.add(str);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
