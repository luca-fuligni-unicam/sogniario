package it.unicam.morpheus.sogniario.checker;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.model.CompletedSurvey;
import it.unicam.morpheus.sogniario.model.Dreamer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

@Validated
@Service
public class DreamerChecker implements EntityChecker <Dreamer>{

    @Autowired
    private CompletedSurveyChecker completedSurveyChecker;

    @Override
    public boolean check(Dreamer object) throws EntityNotFoundException {

        for(CompletedSurvey c: object.getCompletedSurveys())
            completedSurveyChecker.check(c);

        // TODO: 02/04/2021 controllare nascita

        // TODO: 02/04/2021 controllora sesso

        return false;
    }
}
