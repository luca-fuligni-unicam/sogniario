package it.unicam.morpheus.sogniario.controllers;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import java.io.FileNotFoundException;

/**
 * The class takes care of managing the handlers for shared exceptions between the various Boundary interfaces.
 */
@ControllerAdvice
public class ExceptionController extends ResponseEntityExceptionHandler {

    @ExceptionHandler(EntityNotFoundException.class)
    protected ResponseEntity<String> entityNotFoundHandler(EntityNotFoundException e){
        return new ResponseEntity<>(e.getLocalizedMessage(), HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(IllegalArgumentException.class)
    protected ResponseEntity<String> illegalArgumentHandler(IllegalArgumentException e){
        return new ResponseEntity<>(e.getLocalizedMessage(), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(IdConflictException.class)
    protected ResponseEntity<String> idConflictHandler(IdConflictException e){
        return new ResponseEntity<>(e.getLocalizedMessage(), HttpStatus.CONFLICT);
    }

    @ExceptionHandler(NullPointerException.class)
    protected ResponseEntity<String> nullHandler(NullPointerException e){
        return new ResponseEntity<>(e.getLocalizedMessage(), HttpStatus.PARTIAL_CONTENT);
    }

    @ExceptionHandler(FileNotFoundException.class)
    protected ResponseEntity<String> FileNotFoundHandler(FileNotFoundException e){
        return new ResponseEntity<>(e.getLocalizedMessage(), HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(UsernameNotFoundException.class)
    protected ResponseEntity<String> UsernameNotFoundHandler(UsernameNotFoundException e){
        return new ResponseEntity<>(e.getLocalizedMessage(), HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(AccessDeniedException.class)
    protected ResponseEntity<String> AccessDeniedHandler(AccessDeniedException e){
        return new ResponseEntity<>(e.getLocalizedMessage(), HttpStatus.FORBIDDEN);
    }

    @ExceptionHandler(IllegalStateException.class)
    protected ResponseEntity<String> IllegalStateHandler(IllegalStateException e){
        return new ResponseEntity<>(e.getLocalizedMessage(), HttpStatus.BAD_REQUEST);
    }
}

