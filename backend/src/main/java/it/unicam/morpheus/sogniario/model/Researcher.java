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
 * The class has as its objective the description of a researcher,
 * who is represented through an emal that acts as an Id,
 * the name of the resarcher and a flag indicating the possession of administrator permissions
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
