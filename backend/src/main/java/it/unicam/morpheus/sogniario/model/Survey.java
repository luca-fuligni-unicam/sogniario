package it.unicam.morpheus.sogniario.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;
import java.util.Map;

/**
 * The class aims to describe a survey.
 * In addition, it maintains a map that represents the questions and the related predefined answers that make up the survey.
 */
@Document(collection = "survey")
@NoArgsConstructor
public class Survey {

    @Id @Getter @Setter @NonNull
    private String id;

    @Getter @Setter @NonNull
    private Map<String, List<String>> questions;

    public Survey(Map<String, List<String>> questions) {
        if(questions.isEmpty()) throw new IllegalArgumentException("Questions is empty");
        this.questions = questions;
    }
}
