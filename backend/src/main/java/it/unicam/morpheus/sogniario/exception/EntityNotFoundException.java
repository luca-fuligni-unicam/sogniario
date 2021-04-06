package it.unicam.morpheus.sogniario.exception;

/**
 * The exception represents the non-presence of an entity.
 */
public class EntityNotFoundException extends Exception{
    public EntityNotFoundException(String message){
        super(message);
    }
}
