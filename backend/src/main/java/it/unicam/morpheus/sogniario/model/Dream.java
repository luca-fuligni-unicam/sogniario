package it.unicam.morpheus.sogniario.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import edu.stanford.nlp.simple.Document;
import edu.stanford.nlp.simple.Sentence;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * The class has as its objective the description of a Dream that keeps within it the text of the dream and the date of its registration.
 */
@NoArgsConstructor
@Getter @Setter @NonNull
public class Dream {

    private String text;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime data;

    public Dream(String text){
        if(text.isBlank()) throw new IllegalArgumentException("The dream is blank");
        this.text = text;
        this.data = LocalDateTime.now();
    }

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    public Map<String, List<String>> getGraph() throws IOException {
        Graph graph = new Graph();
        List<String> wordList = new WordsFilter("graph.txt").getList();

        Document doc = new Document(this.text.toLowerCase());
        for (Sentence sent : doc.sentences()){
            for(int i=0, j=1; i < sent.words().size() ; i++, j++){
                if(!wordList.contains(sent.word(i)))
                    graph.addEdge(sent.word(i),
                            j == sent.words().size() ?
                                    null :
                                    !wordList.contains(sent.word(j)) ?
                                            sent.word(j):
                                            sent.word(j +1 )
                    );
            }
        }

        return graph.getAdj();
    }
}
