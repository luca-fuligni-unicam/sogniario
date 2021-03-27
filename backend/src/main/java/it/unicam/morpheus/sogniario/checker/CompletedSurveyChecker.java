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
            // TODO: 20/03/2021 controllare che la risposta sia una di quelle messe a disposizione
            /*
            for(int i = 0; i<= object.getAnswers().size(); i++){

                if(Arrays.stream(surveysRepository.findById(object.getSurveyId()).get().getQuestions().entrySet().)

                for(Map.Entry<String, Set<String>> a: surveysRepository.findById(object.getSurveyId()).get().getQuestions().entrySet()){
                    if(a.getValue().contains(s))
                }


            }
            */

        }

        return true;
    }
}
