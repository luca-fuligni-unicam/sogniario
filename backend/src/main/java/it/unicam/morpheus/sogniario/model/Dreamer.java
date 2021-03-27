package it.unicam.morpheus.sogniario.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "dreamer")
@NoArgsConstructor
public class Dreamer {

    @Id @Getter @Setter @NonNull
    private String id;

    public Dreamer(String id){
        if(id.isBlank()) throw new IllegalArgumentException("Id is blank");
        this.id = id;
    }

}
