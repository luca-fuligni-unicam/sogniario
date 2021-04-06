package it.unicam.morpheus.sogniario.boundary;

import it.unicam.morpheus.sogniario.controller.ResearchersController;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Researcher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * The class implements the {@link ResearchersBoundary} interface so as to provide its API Rest.
 */
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
    @PreAuthorize("permitAll")
    @PostMapping(value = "/createNew", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Researcher create(@RequestBody Researcher object) throws EntityNotFoundException, IdConflictException {
        return researchersController.create(object);
    }

    @Override
    @PreAuthorize("permitAll")
    @PutMapping(value = "/update", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Researcher update(@RequestBody Researcher object) throws EntityNotFoundException, IdConflictException {
        return researchersController.update(object);
    }

    @Override
    @PreAuthorize("permitAll")
    @DeleteMapping(value = "/{researcherID}")
    public boolean delete(@PathVariable String researcherID) {
        return researchersController.delete(researcherID);
    }

    @Override
    @PreAuthorize("permitAll")
    @GetMapping("/exist/{researcherID}")
    public boolean exists(@PathVariable String researcherID) {
        return researchersController.exists(researcherID);
    }

    @Override
    @PreAuthorize("permitAll")
    @GetMapping("/list/{page}/{size}")
    public Page<Researcher> getPage(@PathVariable int page, @PathVariable int size) throws EntityNotFoundException {
        return researchersController.getPage(page, size);
    }
}
