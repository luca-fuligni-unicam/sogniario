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
    private String Id;

    @Getter @Setter @NonNull
    private Set<String> reports;

    @Getter @Setter @NonNull
    private Set<CompletedSurvey> completedSurveys;

    public Dreamer(String id){
        if(id.isBlank()) throw new IllegalArgumentException("Id is blank");
        this.Id = id;
        reports = new HashSet<>();
        completedSurveys = new HashSet<>();
    }

    public boolean addReport(@NonNull String reportId){
        if(reportId.isBlank()) throw new IllegalArgumentException("Report Id is blank");
        return reports.add(reportId);
    }

    public boolean removeReport(@NonNull String reportId){
        if(reportId.isBlank()) throw new IllegalArgumentException("Report Id is blank");
        return reports.remove(reportId);
    }

    public boolean addcompletedSurvey(@NonNull CompletedSurvey completedSurvey){
        // TODO: 16/03/2021 verificare che completedSurvey sia valido
        return completedSurveys.add(completedSurvey);
    }

    public boolean removecompletedSurvey(@NonNull CompletedSurvey completedSurvey){
        // TODO: 16/03/2021 verificare che completedSurvey sia valido
        return completedSurveys.remove(completedSurvey);
    }

}
