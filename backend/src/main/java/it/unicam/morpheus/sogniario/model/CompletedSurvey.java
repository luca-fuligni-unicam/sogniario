package it.unicam.morpheus.sogniario.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

/**
 * The class has as its objective the description of a CompletedSurvey that keeps within it the reference to the {@link Survey} to which it is connected
 * and the list of answers given by the {@link Dreamer}.
 */
@NoArgsConstructor
@Getter @Setter @NonNull
public class CompletedSurvey {

    private List<String> answers;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime data;

    private String surveyId;

    public CompletedSurvey(@NonNull String surveyId, List<String> answers){
        if(answers.isEmpty()) throw new IllegalArgumentException("Answers is empty");
        if(surveyId.isBlank()) throw new IllegalArgumentException("Survey Id is blank");
        this.surveyId = surveyId;
        this.answers = answers;
        this.data = LocalDateTime.now();
    }

}
