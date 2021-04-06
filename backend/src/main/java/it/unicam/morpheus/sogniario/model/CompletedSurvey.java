package it.unicam.morpheus.sogniario.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import org.springframework.data.annotation.Id;

import java.util.List;

/**
 * The class has as its objective the description of a CompletedSurvey that keeps within it the reference to the {@link Survey} to which it is connected
 * and the list of answers given by the {@link Dreamer}.
 */
@NoArgsConstructor
public class CompletedSurvey {

    @Getter @Setter @NonNull
    private List<String> answers;

    @Getter @Setter @NonNull
    private String surveyId;

    public CompletedSurvey(String surveyId, List<String> answers){
        if(answers.isEmpty()) throw new IllegalArgumentException("Answers is empty");
        if(surveyId.isBlank()) throw new IllegalArgumentException("Survey Id is blank");
        this.surveyId = surveyId;
        this.answers = answers;
    }

}
