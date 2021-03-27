package it.unicam.morpheus.sogniario.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import org.springframework.data.annotation.Id;

import java.util.List;

@NoArgsConstructor
public class CompletedSurvey {

    @Id @Getter @Setter @NonNull
    private String id;

    @Getter @Setter @NonNull
    private List<String> answers;

    @Getter @Setter @NonNull
    private String surveyId;

    @Getter @Setter @NonNull
    private String dreamId;

    public CompletedSurvey(String surveyId, List<String> answers){
        if(answers.isEmpty()) throw new IllegalArgumentException("Answers is empty");
        if(surveyId.isBlank()) throw new IllegalArgumentException("Survey Id is blank");
        this.surveyId = surveyId;
        this.answers = answers;
    }

}
