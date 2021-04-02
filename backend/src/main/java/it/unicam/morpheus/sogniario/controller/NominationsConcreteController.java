package it.unicam.morpheus.sogniario.controller;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Nomination;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

@Validated
@Service
public class NominationsConcreteController implements NominationsController{
    @Override
    public Nomination getInstance(String id) throws EntityNotFoundException {
        // TODO: 02/04/2021 implementare
        return null;
    }

    @Override
    public Nomination create(Nomination object) throws EntityNotFoundException, IdConflictException {
        // TODO: 02/04/2021 implementare
        return null;
    }

    @Override
    public Nomination update(Nomination object) throws EntityNotFoundException, IdConflictException {
        // TODO: 02/04/2021 implementare
        return null;
    }

    @Override
    public boolean delete(String id) {
        // TODO: 02/04/2021 implementare
        return false;
    }

    @Override
    public boolean exists(String id) {
        // TODO: 02/04/2021 implementare
        return false;
    }

    @Override
    public Page<Nomination> getPage(int page, int size) throws EntityNotFoundException {
        // TODO: 02/04/2021 implementare
        return null;
    }
}
