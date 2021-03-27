package it.unicam.morpheus.sogniario.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "report")
@NoArgsConstructor
public class Report {

    @Id @Getter @Setter @NonNull
    private String id;

    @Getter @Setter @NonNull
    private String dreamerId;

    @Getter @Setter @NonNull
    private Dream dream;

    @Getter @Setter @NonNull
    private CompletedSurvey completedSurvey;

    public Report(String dreamerId, Dream dream, CompletedSurvey completedSurvey){
        // TODO: 16/03/2021 verificare che dream e completedDreamSurvey siano validi
        if(dreamerId.isBlank()) throw new IllegalArgumentException("Dreamer Id is blank");
        this.dream = dream;
        this.completedSurvey = completedSurvey;
    }

}
