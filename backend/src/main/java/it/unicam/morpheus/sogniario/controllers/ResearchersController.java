package it.unicam.morpheus.sogniario.controllers;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.services.ResearchersService;
import it.unicam.morpheus.sogniario.model.Researcher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * The class provides Rest APIs to manage instances of the {@link Researcher} class
 */
@RestController
@RequestMapping("api/researchers")
public class ResearchersController {

    private final ResearchersService researchersService;

    @Autowired
    public ResearchersController(ResearchersService researchersService) {
        this.researchersService = researchersService;
    }

    @PreAuthorize("hasAuthority('dreamers:read')")
    @GetMapping("/{researcherID}")
    public Researcher getInstance(@PathVariable String researcherID) throws EntityNotFoundException {
        return researchersService.getInstance(researcherID);
    }

    @PreAuthorize("hasAuthority('researchers:write')")
    @PostMapping(value = "/createNew/{isAdmin}", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Researcher create(@RequestBody Researcher object, @PathVariable boolean isAdmin) throws EntityNotFoundException, IdConflictException {
        return researchersService.create(object, isAdmin);
    }

    @PreAuthorize("hasAuthority('researchers:write')")
    @PutMapping(value = "/update", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Researcher update(@RequestBody Researcher object) throws EntityNotFoundException, IdConflictException {
        return researchersService.update(object);
    }

    @PreAuthorize("hasAuthority('researchers:write')")
    @DeleteMapping(value = "/{researcherID}")
    public boolean delete(@PathVariable String researcherID) {
        return researchersService.delete(researcherID);
    }

    @PreAuthorize("hasAuthority('researchers:read')")
    @GetMapping("/exist/{researcherID}")
    public boolean exists(@PathVariable String researcherID) {
        return researchersService.exists(researcherID);
    }

    @PreAuthorize("hasAuthority('researchers:read')")
    @GetMapping("/list/{page}/{size}")
    public Page<Researcher> getPage(@PathVariable int page, @PathVariable int size) throws EntityNotFoundException {
        return researchersService.getPage(page, size);
    }

}
