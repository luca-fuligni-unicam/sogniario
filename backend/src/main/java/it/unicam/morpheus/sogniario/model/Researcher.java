package it.unicam.morpheus.sogniario.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "researcher")
@NoArgsConstructor
public class Researcher {

    @Id @Getter @Setter @NonNull
    private String email;

    @Getter @Setter @NonNull
    private String name;

    @Getter @Setter
    private boolean isAdministrator;

    public Researcher(String email, @NonNull String name){
        if(email.isBlank()) throw new IllegalArgumentException("The email is blank");
        this.email = email;
        if(name.isBlank()) throw new IllegalArgumentException("The name is blank");
        this.name = name;
        this.isAdministrator = false;
    }
}
