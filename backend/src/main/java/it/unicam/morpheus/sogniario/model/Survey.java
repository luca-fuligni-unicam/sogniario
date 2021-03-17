package it.unicam.morpheus.sogniario.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Set;

@Document(collection = "survey")
@NoArgsConstructor
public class Survey {

    @Id @Getter @Setter @NonNull
    private String id;

    @Getter @Setter @NonNull
    private Set<String> questions;

    public Survey(Set<String> questions) {
        if(questions.isEmpty()) throw new IllegalArgumentException("Questions is empty");
        this.questions = questions;
    }
}
