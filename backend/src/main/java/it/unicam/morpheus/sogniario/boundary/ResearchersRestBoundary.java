package it.unicam.morpheus.sogniario.boundary;

import it.unicam.morpheus.sogniario.controller.ResearchersController;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Researcher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/researchers")
public class ResearchersRestBoundary implements ResearchersBoundary{

    @Autowired
    private ResearchersController researchersController;

    @Override
    @PreAuthorize("permitAll")
    @GetMapping("/{researcherID}")
    public Researcher getInstance(@PathVariable String researcherID) throws EntityNotFoundException {
        return researchersController.getInstance(researcherID);
    }

    @Override
    public Researcher create(Researcher object) throws EntityNotFoundException, IdConflictException {
        // TODO: 02/04/2021 implementare
        return null;
    }

    @Override
    public Researcher update(Researcher object) throws EntityNotFoundException, IdConflictException {
        // TODO: 02/04/2021 implementare
        return null;
    }

    @Override
    public boolean delete(String researcherID) {
        // TODO: 02/04/2021 implementare
        return false;
    }

    @Override
    public boolean exists(String researcherID) {
        // TODO: 02/04/2021 implementare
        return false;
    }

    @Override
    public Page<Researcher> getPage(int page, int size) throws EntityNotFoundException {
        // TODO: 02/04/2021 implementare
        return null;
    }
}
