package it.unicam.morpheus.sogniario.checker;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.model.Nomination;
import org.springframework.stereotype.Component;

@Component
public class NominationChecker implements EntityChecker<Nomination>{
    @Override
    public boolean check(Nomination object) throws EntityNotFoundException {

        if(object.getEmail().isBlank())
            throw new IllegalStateException("L'email del Researcher è vuota");

        if(object.getName().isBlank())
            throw new IllegalStateException("Il name della nomination è vuoto");

        if(object.getMotivazione().isBlank())
            throw new IllegalStateException("La motivazione della nomination è vuoto");

        // TODO: 02/04/2021 controllare la data

        // TODO: 02/04/2021 controllare lo status
        return false;
    }
}
