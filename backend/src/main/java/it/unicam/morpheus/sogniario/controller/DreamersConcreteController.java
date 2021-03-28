package it.unicam.morpheus.sogniario.controller;

import it.unicam.morpheus.sogniario.checker.CompletedSurveyChecker;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.CompletedSurvey;
import it.unicam.morpheus.sogniario.model.Dreamer;
import it.unicam.morpheus.sogniario.repository.DreamersRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

@Validated
@Service
public class DreamersConcreteController implements DreamersController{

    @Autowired
    private DreamersRepository dreamersRepository;

    @Autowired
    private CompletedSurveyChecker completedSurveyChecker;

    @Override
    public Dreamer getInstance(String id) throws EntityNotFoundException {
        return dreamersRepository.findById(id).orElseThrow(()->
                new EntityNotFoundException("Nessun Dreamer trovato con l'ID: "+id));
    }

    @Override
    public Dreamer create(Dreamer object) throws EntityNotFoundException, IdConflictException {
        if(exists(object.getId())) throw new IdConflictException("Id già presente");
        return dreamersRepository.save(object);
    }

    @Override
    public Dreamer update(Dreamer object) throws EntityNotFoundException, IdConflictException {
        if(!exists(object.getId()))
            throw new EntityNotFoundException("Nessun Dreamer con id: "+ object.getId());
        return dreamersRepository.save(object);
    }

    @Override
    public boolean delete(String id) {
        // TODO: 16/03/2021 implementare
        return false;
    }

    @Override
    public boolean exists(String id) {
        if(id.isBlank()) throw new IllegalArgumentException("Il campo 'ID' è vuoto");
        return dreamersRepository.existsById(id);
    }

    @Override
    public Page<Dreamer> getPage(int page, int size) throws EntityNotFoundException {
        return dreamersRepository.findAll(PageRequest.of(page, size));
    }

    @Override
    public boolean addCompletedSurvey(CompletedSurvey completedSurvey, String dreamerID) throws EntityNotFoundException {
        if(dreamerID.isBlank()) throw new IllegalArgumentException("Il campo 'ID' è vuoto");
        if(dreamersRepository.findById(dreamerID).isEmpty()) throw new EntityNotFoundException("Nessun Dreamer trovato con l'ID: "+dreamerID);
        completedSurveyChecker.check(completedSurvey);
        return dreamersRepository.findById(dreamerID).get().addCompletedSurvey(completedSurvey);
    }
}
