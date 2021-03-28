package it.unicam.morpheus.sogniario.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.HashSet;
import java.util.Set;

@Document(collection = "dreamer")
@NoArgsConstructor
public class Dreamer {

    @Id @Getter @Setter @NonNull
    private String id;

    @Getter @Setter @NonNull
    private Set<CompletedSurvey> completedSurveys;

    public Dreamer(String id){
        if(id.isBlank()) throw new IllegalArgumentException("Id is blank");
        this.id = id;
        completedSurveys = new HashSet<>();
    }

    public boolean addCompletedSurvey(@NonNull CompletedSurvey completedSurvey){
        return completedSurveys.add(completedSurvey);
    }

    public boolean removeCompletedSurvey(@NonNull CompletedSurvey completedSurvey){
        return completedSurveys.remove(completedSurvey);
    }
}
