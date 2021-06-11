package it.unicam.morpheus.sogniario.controllers;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.CompletedSurvey;
import it.unicam.morpheus.sogniario.model.Dreamer;
import it.unicam.morpheus.sogniario.services.DreamersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * The class provides Rest APIs to manage instances of the {@link Dreamer} class
 */
@RestController
@RequestMapping("api/dreamers")
public class DreamersController {

    private final DreamersService dreamersService;

    @Autowired
    public DreamersController(DreamersService dreamersService) {
        this.dreamersService = dreamersService;
    }

    @PreAuthorize("hasAuthority('dreamers:read')")
    @GetMapping("/{dreamerID}")
    public Dreamer getInstance(@PathVariable String dreamerID) throws EntityNotFoundException {
        return dreamersService.getInstance(dreamerID);
    }

    @PreAuthorize("hasAuthority('dreamers:create')")
    @PostMapping(value = "/createNew", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Dreamer create(@RequestBody Dreamer object) throws EntityNotFoundException, IdConflictException {
        return dreamersService.create(object);
    }

    @PreAuthorize("hasAuthority('dreamers:write')")
    @PutMapping(value = "/update", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Dreamer update(@RequestBody Dreamer object) throws EntityNotFoundException, IdConflictException {
        return dreamersService.update(object);
    }

    @PreAuthorize("hasAuthority('dreamers:write')")
    @DeleteMapping(value = "/{dreamerID}")
    public boolean delete(@PathVariable String dreamerID) {
        return dreamersService.delete(dreamerID);
    }

    @PreAuthorize("hasAuthority('dreamers:read')")
    @GetMapping("/exist/{dreamerID}")
    public boolean exists(@PathVariable String dreamerID) {
        return dreamersService.exists(dreamerID);
    }

    @PreAuthorize("hasAuthority('dreamers:read')")
    @GetMapping("/list/{page}/{size}")
    public Page<Dreamer> getPage(@PathVariable int page, @PathVariable int size) throws EntityNotFoundException {
        return dreamersService.getPage(page, size);
    }

    @PreAuthorize("hasAuthority('dreamers:write')")
    @PostMapping(value = "/addCompletedSurvey/{dreamerID}", consumes = MediaType.APPLICATION_JSON_VALUE)
    public boolean addCompletedSurvey(@RequestBody CompletedSurvey completedSurvey, @PathVariable String dreamerID) throws EntityNotFoundException {
        return dreamersService.addCompletedSurvey(completedSurvey, dreamerID);
    }

    @PreAuthorize("hasAuthority('dreamers:read')")
    @GetMapping("/cloud/{dreamerId}")
    public Map<String, Integer> getCloud(@PathVariable String dreamerId) throws EntityNotFoundException {
        return dreamersService.getCloud(dreamerId);
    }
}
