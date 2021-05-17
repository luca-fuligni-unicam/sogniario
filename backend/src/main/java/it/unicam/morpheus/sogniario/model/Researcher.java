package it.unicam.morpheus.sogniario.model;

import it.unicam.morpheus.sogniario.auth.User;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;
import java.util.Set;

/**
 * The class has the objective of representing a Researcher,
 * the class extends the {@link User} class from which it derives the properties for authentication.
 * in addition, the class adds the name of the Researcher to better identify it.
 */
@Document(collection = "researcher")
@NoArgsConstructor
@Getter @Setter @NonNull
public class Researcher extends User {

    private String name;

    public Researcher(String username, String password, Set<? extends GrantedAuthority> grantedAuthorities, String name) {
        super(username, password, grantedAuthorities);
        if(name.isBlank()) throw new IllegalArgumentException("The name is blank");
        this.name = name;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return this.getGrantedAuthorities();
    }
}
