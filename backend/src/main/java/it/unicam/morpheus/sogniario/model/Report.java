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
    private String Id;

    @Getter @Setter @NonNull
    private String dreamerId;

    @Getter @Setter @NonNull
    private Dream dream;

    @Getter @Setter @NonNull
    private CompletedDreamSurvey completedDreamSurvey;

    public Report(String dreamerId, Dream dream, CompletedDreamSurvey completedDreamSurvey){
        // TODO: 16/03/2021 verificare che dream e completedDreamSurvey siano validi
        if(dreamerId.isBlank()) throw new IllegalArgumentException("Dreamer Id is blank");
        this.dream = dream;
        this.completedDreamSurvey = completedDreamSurvey;
    }

}
