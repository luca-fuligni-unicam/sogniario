package it.unicam.morpheus.sogniario.checker;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;

public interface EntityChecker <T> {

    public boolean check(T object) throws EntityNotFoundException;

}
