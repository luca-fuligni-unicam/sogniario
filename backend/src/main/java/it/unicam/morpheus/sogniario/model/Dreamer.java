package it.unicam.morpheus.sogniario.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;

enum Sex {MALE, FEMALE, OTHER}

@Document(collection = "dreamer")
@NoArgsConstructor
public class Dreamer {

    @Id @Getter @Setter @NonNull
    private String id;

    @Getter @Setter @NonNull
    private Set<CompletedSurvey> completedSurveys;

    @Getter @Setter @NonNull
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate nascita;

    @Getter @Setter @NonNull
    private Sex sesso;

    public Dreamer(String id, @NonNull LocalDate nascita, @NonNull Sex sesso){
        if(id.isBlank()) throw new IllegalArgumentException("Id is blank");
        this.id = id;
        this.completedSurveys = new HashSet<>();
        this.nascita = nascita;
        this.sesso = sesso;
    }

    public boolean addCompletedSurvey(@NonNull CompletedSurvey completedSurvey){
        return completedSurveys.add(completedSurvey);
    }

    public boolean removeCompletedSurvey(@NonNull CompletedSurvey completedSurvey){
        return completedSurveys.remove(completedSurvey);
    }
}
