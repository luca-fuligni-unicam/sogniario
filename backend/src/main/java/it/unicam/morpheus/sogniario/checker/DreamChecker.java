package it.unicam.morpheus.sogniario.checker;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.model.Dream;
import it.unicam.morpheus.sogniario.repository.ReportsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

@Validated
@Service
public class DreamChecker implements EntityChecker <Dream>{

    @Autowired
    private ReportsRepository reportsRepository;

    @Override
    public boolean check(Dream object) throws EntityNotFoundException {
        if(reportsRepository.existsById(object.getReportId()))
            throw new EntityNotFoundException("Il Report con l'Id: " + object.getReportId() + "non è presente");

        if(object.getText().isBlank())
            throw new IllegalStateException("Il text del dream è vuoto");

        // TODO: 17/03/2021 verificare la data

        return true;
    }
}
