package it.unicam.morpheus.sogniario.exception;

/**
 * The exception represents the presence of a conflict of Id.
 */
public class IdConflictException extends Exception{
    public IdConflictException(String message){
        super(message);
    }
}
