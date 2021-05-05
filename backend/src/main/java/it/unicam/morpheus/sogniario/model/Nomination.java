package it.unicam.morpheus.sogniario.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;

enum NominationStatus{PENDENTE, ACCEPTED, REJECTED}

/**
 * The class has as its objective the description of a nomination that keeps within it the email that acts as an Id,
 * the name of the person who requested it, the date of request, the motivation and the relative {@link NominationStatus}.
 */
@Document(collection = "nomination")
@NoArgsConstructor
@Getter @Setter @NonNull
public class Nomination {

    @Id
    private String email;

    private String name;

    private String motivazione;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime data;

    private NominationStatus status;

    public Nomination(String email, @NonNull String name, @NonNull String motivazione){
        if(email.isBlank()) throw new IllegalArgumentException("The email is blank");
        this.email = email;
        if(motivazione.isBlank()) throw new IllegalArgumentException("The motivazione is blank");
        this.motivazione = motivazione;
        if(name.isBlank()) throw new IllegalArgumentException("The name is blank");
        this.name = name;
        this.data = LocalDateTime.now();
        this.status = NominationStatus.PENDENTE;
    }
}

