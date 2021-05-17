package it.unicam.morpheus.sogniario.auth;

import java.util.Optional;

/**
 * The interface declares a service to retrieve system users from
 */
public interface UserDao {

    Optional<User> selectUserByUsername(String username);
}
