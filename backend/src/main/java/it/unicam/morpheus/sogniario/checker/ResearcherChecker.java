package it.unicam.morpheus.sogniario.checker;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.model.Researcher;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

@Validated
@Service
public class ResearcherChecker implements EntityChecker <Researcher>{
    @Override
    public boolean check(Researcher object) throws EntityNotFoundException {

        if(object.getEmail().isBlank())
            throw new IllegalStateException("L'email del Researcher è vuota");

        if(object.getName().isBlank())
            throw new IllegalStateException("Il name del Researcher è vuoto");
        return false;
    }
}
