package it.unicam.morpheus.sogniario.controller;

import it.unicam.morpheus.sogniario.checker.ReportChecker;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Report;
import it.unicam.morpheus.sogniario.repository.ReportsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

@Validated
@Service
public class ReportsConcreteController implements ReportsController{

    @Autowired
    private ReportsRepository reportsRepository;

    @Autowired
    private ReportChecker reportChecker;

    @Override
    public Report getInstance(String id) throws EntityNotFoundException {
        return reportsRepository.findById(id).orElseThrow(()->
                new EntityNotFoundException("Nessun Report trovato con l'ID: "+id));
    }

    @Override
    public Report create(Report object) throws EntityNotFoundException, IdConflictException {
        if(exists(object.getId())) throw new IdConflictException("Id già presente");
        reportChecker.check(object);
        return reportsRepository.save(object);
    }

    @Override
    public Report update(Report object) throws EntityNotFoundException, IdConflictException {
        if(!exists(object.getId()))
            throw new EntityNotFoundException("Nessun Report con id: "+ object.getId());
        reportChecker.check(object);
        return reportsRepository.save(object);
    }

    @Override
    public boolean delete(String id) {
        // TODO: 16/03/2021 implementare
        return false;
    }

    @Override
    public boolean exists(String id) {
        if(id.isBlank()) throw new IllegalArgumentException("Il campo 'ID' è vuoto");
        return reportsRepository.existsById(id);
    }
}
