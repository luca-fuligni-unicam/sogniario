package it.unicam.morpheus.sogniario.controller;

import it.unicam.morpheus.sogniario.checker.SurveyChecker;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Survey;
import it.unicam.morpheus.sogniario.repository.SurveysRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

@Validated
@Service
public class SurveysConcreteController implements SurveysController{

    @Autowired
    private SurveysRepository surveysRepository;

    @Autowired
    private SurveyChecker surveyChecker;

    @Override
    public Survey getInstance(String id) throws EntityNotFoundException {
        return surveysRepository.findById(id).orElseThrow(()->
                new EntityNotFoundException("Nessun Survey trovato con l'ID: "+id));
    }

    @Override
    public Survey create(Survey object) throws EntityNotFoundException, IdConflictException {
        if(exists(object.getId())) throw new IdConflictException("Id già presente");
        surveyChecker.check(object);
        return surveysRepository.save(object);
    }

    @Override
    public Survey update(Survey object) throws EntityNotFoundException, IdConflictException {
        if(!exists(object.getId()))
            throw new EntityNotFoundException("Nessun Survey con id: "+ object.getId());
        surveyChecker.check(object);
        return surveysRepository.save(object);
    }

    @Override
    public boolean delete(String id) {
        // TODO: 16/03/2021 implementare
        return false;
    }

    @Override
    public boolean exists(String id) {
        if(id.isBlank()) throw new IllegalArgumentException("Il campo 'ID' è vuoto");
        return surveysRepository.existsById(id);
    }
}
