package it.unicam.morpheus.sogniario.auth;

import java.util.Optional;

public interface UserDao {

    Optional<User> selectUserByUsername(String username);
}
