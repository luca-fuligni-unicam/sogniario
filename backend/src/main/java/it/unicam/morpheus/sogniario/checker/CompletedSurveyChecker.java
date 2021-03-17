package it.unicam.morpheus.sogniario.checker;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.model.CompletedSurvey;
import it.unicam.morpheus.sogniario.repository.DreamersRepository;
import it.unicam.morpheus.sogniario.repository.SurveysRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

@Validated
@Service
public class CompletedSurveyChecker implements EntityChecker<CompletedSurvey> {

    @Autowired
    private SurveysRepository surveysRepository;

    @Autowired
    private DreamersRepository dreamersRepository;

    @Override
    public boolean check(CompletedSurvey object) throws EntityNotFoundException {
        if(!dreamersRepository.existsById(object.getDreamId())) throw new EntityNotFoundException("CompletedSurvey con Id: " + object.getId() + " non è collegato a un Dreamer esistente");
        if(!surveysRepository.existsById(object.getSurveyId())) throw new EntityNotFoundException("CompletedSurvey con Id: " + object.getId() + " non è collegato a un Survey esistente");
        else {
            if(object.getAnswers().size() != surveysRepository.findById(object.getSurveyId()).get().getQuestions().size())
                throw new IllegalStateException("CompletedSurvey con Id: " + object.getId() + " ha un numero di risposte non corrispondente al numero di domande del corrispettivo Survey");
        }

        return true;
    }
}
