package it.unicam.morpheus.sogniario.controller;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import org.springframework.data.domain.Page;

/**
 * The interface represents the controller to manage a generic entity with its related methods of creation, update, and delete.
 * @param <T>   The class of the entity.
 * @param <I>   The class of Id.
 */
public interface EntityController<T, I>{

    T getInstance(I id) throws EntityNotFoundException;

    T create(T object) throws EntityNotFoundException, IdConflictException;

    T update(T object) throws EntityNotFoundException, IdConflictException;

    boolean delete(I id);

    boolean exists(I id);

    Page<T> getPage(int page, int size) throws EntityNotFoundException;
}
