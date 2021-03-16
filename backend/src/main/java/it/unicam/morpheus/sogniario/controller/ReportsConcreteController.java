package it.unicam.morpheus.sogniario.controller;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Report;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

@Validated
@Service
public class ReportsConcreteController implements ReportsController{
    @Override
    public Report getInstance(String id) throws EntityNotFoundException {
        // TODO: 16/03/2021 implementare
        return null;
    }

    @Override
    public Report create(Report object) throws EntityNotFoundException, IdConflictException {
        // TODO: 16/03/2021 implementare
        return null;
    }

    @Override
    public Report update(Report object) throws EntityNotFoundException, IdConflictException {
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
