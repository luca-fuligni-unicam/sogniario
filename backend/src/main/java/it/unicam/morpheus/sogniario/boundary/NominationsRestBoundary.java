package it.unicam.morpheus.sogniario.boundary;

import it.unicam.morpheus.sogniario.controller.NominationsController;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Nomination;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/nominations")
public class NominationsRestBoundary implements NominationsBoundary{

    @Autowired
    NominationsController nominationsController;

    @Override
    @PreAuthorize("permitAll")
    @GetMapping("/{nominationID}")
    public Nomination getInstance(@PathVariable String nominationID) throws EntityNotFoundException {
        return nominationsController.getInstance(nominationID);
    }

    @Override
    public Nomination create(Nomination object) throws EntityNotFoundException, IdConflictException {
        // TODO: 02/04/2021 implementare
        return null;
    }

    @Override
    public Nomination update(Nomination object) throws EntityNotFoundException, IdConflictException {
        // TODO: 02/04/2021 implementare
        return null;
    }

    @Override
    public boolean delete(String nominationID) {
        // TODO: 02/04/2021 implementare
        return false;
    }

    @Override
    public boolean exists(String nominationID) {
        // TODO: 02/04/2021 implementare
        return false;
    }

    @Override
    public Page<Nomination> getPage(int page, int size) throws EntityNotFoundException {
        // TODO: 02/04/2021 implementare
        return null;
    }
}
