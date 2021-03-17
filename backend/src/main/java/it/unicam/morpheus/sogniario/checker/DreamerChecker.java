package it.unicam.morpheus.sogniario.checker;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.model.CompletedSurvey;
import it.unicam.morpheus.sogniario.model.Dreamer;
import it.unicam.morpheus.sogniario.repository.ReportsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

@Validated
@Service
public class DreamerChecker implements EntityChecker <Dreamer>{

    @Autowired
    private ReportsRepository reportsRepository;

    @Autowired
    private CompletedSurveyChecker completedSurveyChecker;

    @Override
    public boolean check(Dreamer object) throws EntityNotFoundException {
        if(!object.getReports().isEmpty())
            for(String s: object.getReports())
                if(!reportsRepository.existsById(s))
                    throw new EntityNotFoundException("Report Id: " + s + " non è presente");

        if(!object.getCompletedSurveys().isEmpty())
            for(CompletedSurvey c: object.getCompletedSurveys()){
                completedSurveyChecker.check(c);
                if(!c.getDreamId().equals(object.getId()))
                    throw new IllegalStateException("CompletedSurvey con Id: " + c.getId() + " non appartiene a questo Dreamer");
            }
        return true;
    }
}
