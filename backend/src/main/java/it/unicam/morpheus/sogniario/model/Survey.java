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
    private String Id;

    @Getter @Setter @NonNull
    private Set<String> questions;

    public Survey(Set<String> questions) {
        this.questions = questions;
    }
}
