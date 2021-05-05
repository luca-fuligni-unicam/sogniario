package it.unicam.morpheus.sogniario.checker;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.model.Report;
import it.unicam.morpheus.sogniario.repositories.DreamersRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ReportChecker implements EntityChecker<Report> {

    private final DreamersRepository dreamersRepository;
    private final DreamChecker dreamChecker;
    private final CompletedSurveyChecker completedSurveyChecker;

    @Autowired
    public ReportChecker(DreamersRepository dreamersRepository, DreamChecker dreamChecker, CompletedSurveyChecker completedSurveyChecker) {
        this.dreamersRepository = dreamersRepository;
        this.dreamChecker = dreamChecker;
        this.completedSurveyChecker = completedSurveyChecker;
    }

    @Override
    public boolean check(Report object) throws EntityNotFoundException {
        if(!dreamersRepository.existsById(object.getDreamerId()))
            throw new EntityNotFoundException("Il Dreamer con l'Id: " + object.getDreamerId() + " non è presente");

        dreamChecker.check(object.getDream());

        completedSurveyChecker.check(object.getCompletedSurvey());

        return true;
    }
}
