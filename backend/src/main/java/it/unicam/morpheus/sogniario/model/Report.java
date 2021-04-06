package it.unicam.morpheus.sogniario.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 * The class has as its objective the description of a report that keeps within it the references to its {@link Dream} and {@link CompletedSurvey}.
 * In addition, it keeps the date of the registration of the report and the ID of the {@link Dreamer} who registered it.
 */
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
