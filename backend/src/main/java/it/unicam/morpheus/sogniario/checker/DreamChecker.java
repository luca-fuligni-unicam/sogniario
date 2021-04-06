package it.unicam.morpheus.sogniario.checker;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.model.Dream;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

@Validated
@Service
public class DreamChecker implements EntityChecker <Dream>{

    @Override
    public boolean check(Dream object) throws EntityNotFoundException {

        if(object.getText().isBlank())
            throw new IllegalStateException("Il text del dream è vuoto");

        // TODO: 17/03/2021 verificare la data

        return true;
    }
}
