package it.unicam.morpheus.sogniario.jwt;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * The class represents the request to allow authentication via username and password.
 */
@NoArgsConstructor
@Getter @Setter
public class UsernameAndPasswordAuthenticationRequest {

    private String username;
    private String password;
}
