package it.unicam.morpheus.sogniario.checker;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.model.Report;
import it.unicam.morpheus.sogniario.repository.DreamersRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

@Validated
@Service
public class ReportChecker implements EntityChecker<Report> {

    @Autowired
    private DreamersRepository dreamersRepository;

    @Autowired
    private DreamChecker dreamChecker;

    @Autowired
    private CompletedSurveyChecker completedSurveyChecker;

    @Override
    public boolean check(Report object) throws EntityNotFoundException {
        if(!dreamersRepository.existsById(object.getDreamerId()))
            throw new EntityNotFoundException("Il Dreamer con l'Id: " + object.getDreamerId() + " non è presente");

        dreamChecker.check(object.getDream());

        completedSurveyChecker.check(object.getCompletedSurvey());

        return true;
    }
}
