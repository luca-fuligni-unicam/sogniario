package it.unicam.morpheus.sogniario.checker;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.model.CompletedSurvey;
import it.unicam.morpheus.sogniario.repositories.SurveysRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

@Component
public class CompletedSurveyChecker implements EntityChecker<CompletedSurvey> {

    private final SurveysRepository surveysRepository;

    @Autowired
    public CompletedSurveyChecker(SurveysRepository surveysRepository) {
        this.surveysRepository = surveysRepository;
    }

    @Override
    public boolean check(CompletedSurvey object) throws EntityNotFoundException {
        if(!surveysRepository.existsById(object.getSurveyId())) throw new EntityNotFoundException("CompletedSurvey non è collegato a un Survey esistente");
        // TODO: 29/03/2021 verificare che le risposte siano contenute nelle risposte predefinite dal survey
        // else{ }

        return true;
    }
}