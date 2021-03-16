package it.unicam.morpheus.sogniario.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;

import java.util.List;

@NoArgsConstructor
public class CompletedDreamSurvey extends CompletedSurvey {

    @Getter @Setter @NonNull
    private String reportId;

    public CompletedDreamSurvey(String surveyId, List<String> answers, String reportId) {
        super(surveyId, answers);
        if(surveyId.isBlank()) throw new IllegalArgumentException("Survey Id is blank");
        this.reportId = reportId;
    }
}
