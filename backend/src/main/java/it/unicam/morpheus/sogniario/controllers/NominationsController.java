package it.unicam.morpheus.sogniario.controllers;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Nomination;
import it.unicam.morpheus.sogniario.model.Researcher;
import it.unicam.morpheus.sogniario.services.NominationsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * The class provides Rest APIs to manage instances of the {@link Nomination} class
 */
@RestController
@RequestMapping("api/nominations")
public class NominationsController {

    private final NominationsService nominationsService;

    @Autowired
    public NominationsController(NominationsService nominationsService) {
        this.nominationsService = nominationsService;
    }

    @PreAuthorize("hasAuthority('nominations:read')")
    @GetMapping("/{nominationID}")
    public Nomination getInstance(@PathVariable String nominationID) throws EntityNotFoundException {
        return nominationsService.getInstance(nominationID);
    }

    @PreAuthorize("hasAuthority('nominations:write')")
    @PostMapping(value = "/createNew", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Nomination create(@RequestBody Nomination object) throws EntityNotFoundException, IdConflictException {
        return nominationsService.create(object);
    }

    @PreAuthorize("hasAuthority('nominations:write')")
    @PutMapping(value = "/update", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Nomination update(@RequestBody Nomination object) throws EntityNotFoundException, IdConflictException {
        return nominationsService.update(object);
    }

    @PreAuthorize("hasAuthority('nominations:write')")
    @DeleteMapping(value = "/{nominationID}")
    public boolean delete(@PathVariable String nominationID) {
        return nominationsService.delete(nominationID);
    }

    @PreAuthorize("hasAuthority('nominations:read')")
    @GetMapping("/exist/{nominationID}")
    public boolean exists(@PathVariable String nominationID) {
        return nominationsService.exists(nominationID);
    }

    @PreAuthorize("hasAuthority('nominations:read')")
    @GetMapping("/list/{page}/{size}")
    public Page<Nomination> getPage(@PathVariable int page, @PathVariable int size) throws EntityNotFoundException {
        return nominationsService.getPage(page, size);
    }

    @PreAuthorize("hasAuthority('nominations:write')")
    @PostMapping("/acceptNomination/{nominationID}")
    public Researcher acceptNomination(@PathVariable String nominationID) throws EntityNotFoundException{
        return nominationsService.acceptNomination(nominationID);
    }

    @PreAuthorize("hasAuthority('nominations:write')")
    @PostMapping("/rejectNomination/{nominationID}")
    public void rejectNomination(@PathVariable String nominationID) throws EntityNotFoundException{
        nominationsService.rejectNomination(nominationID);
    }
}
