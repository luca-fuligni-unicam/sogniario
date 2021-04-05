package it.unicam.morpheus.sogniario.boundary;

import it.unicam.morpheus.sogniario.controller.NominationsController;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Nomination;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

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
    @PreAuthorize("permitAll")
    @PostMapping(value = "/createNew", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Nomination create(@RequestBody Nomination object) throws EntityNotFoundException, IdConflictException {
        return nominationsController.create(object);
    }

    @Override
    @PreAuthorize("permitAll")
    @PutMapping(value = "/update", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Nomination update(@RequestBody Nomination object) throws EntityNotFoundException, IdConflictException {
        return nominationsController.update(object);
    }

    @Override
    @PreAuthorize("permitAll")
    @DeleteMapping(value = "/{nominationID}")
    public boolean delete(@PathVariable String nominationID) {
        return nominationsController.delete(nominationID);
    }

    @Override
    @PreAuthorize("permitAll")
    @GetMapping("/exist/{nominationID}")
    public boolean exists(@PathVariable String nominationID) {
        return nominationsController.exists(nominationID);
    }

    @Override
    @PreAuthorize("permitAll")
    @GetMapping("/list/{page}/{size}")
    public Page<Nomination> getPage(@PathVariable int page, @PathVariable int size) throws EntityNotFoundException {
        return nominationsController.getPage(page, size);
    }
}
