package it.unicam.morpheus.sogniario.boundary;

import it.unicam.morpheus.sogniario.controller.DreamersController;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.CompletedSurvey;
import it.unicam.morpheus.sogniario.model.Dreamer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/dreamers")
public class DreamersRestBoundary implements DreamersBoundary{

    @Autowired
    private DreamersController dreamersController;

    @Override
    @PreAuthorize("permitAll")
    @GetMapping("/{dreamerID}")
    public Dreamer getInstance(@PathVariable String dreamerID) throws EntityNotFoundException {
        return dreamersController.getInstance(dreamerID);
    }

    @Override
    @PreAuthorize("permitAll")
    @PostMapping(value = "/createNew", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Dreamer create(@RequestBody Dreamer object) throws EntityNotFoundException, IdConflictException {
        return dreamersController.create(object);
    }

    @Override
    @PreAuthorize("permitAll")
    @PutMapping(value = "/update", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Dreamer update(@RequestBody Dreamer object) throws EntityNotFoundException, IdConflictException {
        return dreamersController.update(object);
    }

    @Override
    @PreAuthorize("permitAll")
    @DeleteMapping(value = "/{dreamerID}")
    public boolean delete(@PathVariable String dreamerID) {
        return dreamersController.delete(dreamerID);
    }

    @Override
    @PreAuthorize("permitAll")
    @GetMapping("/exist/{dreamerID}")
    public boolean exists(@PathVariable String dreamerID) {
        return dreamersController.exists(dreamerID);
    }

    @Override
    @PreAuthorize("permitAll")
    @GetMapping("/list/{page}/{size}")
    public Page<Dreamer> getPage(@PathVariable int page, @PathVariable int size) throws EntityNotFoundException {
        return dreamersController.getPage(page, size);
    }

    @Override
    @PreAuthorize("permitAll")
    @PostMapping(value = "/addCompletedSurvey/{dreamerID}", consumes = MediaType.APPLICATION_JSON_VALUE)
    public boolean addCompletedSurvey(@RequestBody CompletedSurvey completedSurvey, @PathVariable String dreamerID) throws EntityNotFoundException {
        return dreamersController.addCompletedSurvey(completedSurvey, dreamerID);
    }

}
