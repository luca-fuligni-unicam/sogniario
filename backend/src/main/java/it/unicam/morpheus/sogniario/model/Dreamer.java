package it.unicam.morpheus.sogniario.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import it.unicam.morpheus.sogniario.auth.User;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.security.core.GrantedAuthority;

import java.time.LocalDate;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

enum Sex {MALE, FEMALE, OTHER}

/**
 * The class has the objective of representing a Researcher, the class extends the {@link User} class from which it derives the properties for authentication.
 * in addition, the class adds the date of birth, the {@link Sex} of the Dreamer and the reference to the {@link CompletedSurvey} he has compiled.
 */
@Document(collection = "dreamer")
@NoArgsConstructor
@Getter @Setter @NonNull
public class Dreamer extends User {

    private Set<CompletedSurvey> completedSurveys;

    //@JsonFormat(pattern = "yyyy-MM-dd")
    //private LocalDate nascita;
    private int eta;

    private Sex sesso;

    //public Dreamer(String username, String password, Set<? extends GrantedAuthority> grantedAuthorities, @NonNull LocalDate nascita, @NonNull Sex sesso) {
    public Dreamer(String username, String password, Set<? extends GrantedAuthority> grantedAuthorities, int eta, @NonNull Sex sesso) {
        super(username, password, grantedAuthorities);
        this.completedSurveys = new HashSet<>();
        //this.nascita = nascita;
        this.eta = eta;
        this.sesso = sesso;
    }

    public boolean addCompletedSurvey(@NonNull CompletedSurvey completedSurvey){
        return completedSurveys.add(completedSurvey);
    }

    public boolean removeCompletedSurvey(@NonNull CompletedSurvey completedSurvey){
        return completedSurveys.remove(completedSurvey);
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return this.getGrantedAuthorities();
    }
}
