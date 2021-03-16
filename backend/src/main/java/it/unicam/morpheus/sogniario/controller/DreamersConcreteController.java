package it.unicam.morpheus.sogniario.controller;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Dream;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

@Validated
@Service
public class DreamersConcreteController implements DreamersController{
    @Override
    public Dream getInstance(String id) throws EntityNotFoundException {
        // TODO: 16/03/2021 implementare
        return null;
    }

    @Override
    public Dream create(Dream object) throws EntityNotFoundException, IdConflictException {
        // TODO: 16/03/2021 implementare
        return null;
    }

    @Override
    public Dream update(Dream object) throws EntityNotFoundException, IdConflictException {
        // TODO: 16/03/2021 implementare
        return null;
    }

    @Override
    public boolean delete(String id) {
        // TODO: 16/03/2021 implementare
        return false;
    }

    @Override
    public boolean exists(String id) {
        // TODO: 16/03/2021 implementare
        return false;
    }
}
