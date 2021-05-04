package it.unicam.morpheus.sogniario.auth;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Set;

@NoArgsConstructor
@Getter @Setter @NonNull
public abstract class User implements UserDetails {

    @Id
    private String username;

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String password;

    private Set<? extends GrantedAuthority> grantedAuthorities;

    private boolean isAccountNonExpired;

    private boolean isAccountNonLocked;

    private boolean isCredentialsNonExpired;

    private boolean isEnabled;

    public User(@NonNull String username, @NonNull String password, Set<? extends GrantedAuthority> grantedAuthorities) {
        if(username.isBlank()) throw new IllegalArgumentException("The username is blank");
        this.username = username;
        if(password.isBlank()) throw new IllegalArgumentException("The password is blank");
        this.password = password;
        this.grantedAuthorities = grantedAuthorities;
        this.isAccountNonLocked = true;
        this.isAccountNonExpired = true;
        this.isCredentialsNonExpired = true;
        this.isEnabled = true;
    }
}