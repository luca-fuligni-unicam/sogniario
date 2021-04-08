package it.unicam.morpheus.sogniario.controller;

import it.unicam.morpheus.sogniario.checker.ResearcherChecker;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Researcher;
import it.unicam.morpheus.sogniario.repository.ResearchersRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

/**
 * The class implements the {@link ResearchersController} interface
 */
@Validated
@Service
public class ResearchersConcreteController implements ResearchersController{

    @Autowired
    private ResearchersRepository researchersRepository;

    @Autowired
    private ResearcherChecker researcherChecker;

    @Override
    public Researcher getInstance(String id) throws EntityNotFoundException {
        return researchersRepository.findById(id).orElseThrow(()->
                new EntityNotFoundException("Nessun Researcher trovato con l'ID: "+id));
    }

    @Override
    public Researcher create(Researcher object) throws EntityNotFoundException, IdConflictException {
        if(exists(object.getEmail())) throw new IdConflictException("Email già presente");
        researcherChecker.check(object);
        return researchersRepository.save(object);
    }

    @Override
    public Researcher update(Researcher object) throws EntityNotFoundException, IdConflictException {
        if(!exists(object.getEmail()))
            throw new EntityNotFoundException("Nessun Researcher con email: "+ object.getEmail());
        researcherChecker.check(object);
        return researchersRepository.save(object);
    }

    @Override
    public boolean delete(String id) {
        // TODO: 02/04/2021 implementare
        return false;
    }

    @Override
    public boolean exists(String id) {
        if(id.isBlank()) throw new IllegalArgumentException("Il campo 'Email' è vuoto");
        return researchersRepository.existsById(id);
    }

    @Override
    public Page<Researcher> getPage(int page, int size) throws EntityNotFoundException {
        return researchersRepository.findAll(PageRequest.of(page, size));
    }
}
