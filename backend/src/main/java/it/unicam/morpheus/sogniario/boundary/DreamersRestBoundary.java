package it.unicam.morpheus.sogniario.boundary;

import it.unicam.morpheus.sogniario.controller.DreamersController;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Dream;
import org.springframework.beans.factory.annotation.Autowired;
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
    public Dream getInstance(@PathVariable String dreamerID) throws EntityNotFoundException {
        return dreamersController.getInstance(dreamerID);
    }

    @Override
    @PreAuthorize("permitAll")
    @PostMapping(value = "/createNew", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Dream create(@RequestBody Dream object) throws EntityNotFoundException, IdConflictException {
        return dreamersController.create(object);
    }

    @Override
    @PreAuthorize("permitAll")
    @PutMapping(value = "/update", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Dream update(@RequestBody Dream object) throws EntityNotFoundException, IdConflictException {
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
}
