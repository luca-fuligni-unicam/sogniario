package it.unicam.morpheus.sogniario.controllers;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Survey;
import it.unicam.morpheus.sogniario.services.SurveysService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

/**
 * The class provides Rest APIs to manage instances of the {@link Survey} class
 */
@RestController
@RequestMapping("api/surveys")
public class SurveysController {

    private final SurveysService surveysService;

    @Autowired
    public SurveysController(SurveysService surveysService) {
        this.surveysService = surveysService;
    }

    @PreAuthorize("hasAuthority('surveys:read')")
    @GetMapping("/{surveyID}")
    public Survey getInstance(@PathVariable String surveyID) throws EntityNotFoundException {
        return surveysService.getInstance(surveyID);
    }

    @PreAuthorize("hasAuthority('surveys:write')")
    @PostMapping(value ="/createNew", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Survey create(@RequestBody Survey object) throws IdConflictException, EntityNotFoundException {
        return surveysService.create(object);
    }

    @PreAuthorize("hasAuthority('surveys:write')")
    @PutMapping(value ="/update", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Survey update(@RequestBody Survey object) throws IdConflictException, EntityNotFoundException {
        return surveysService.update(object);
    }

    @PreAuthorize("hasAuthority('surveys:write')")
    @DeleteMapping("/{surveyID}")
    public boolean delete(@PathVariable String surveyID) {
        return surveysService.delete(surveyID);
    }

    @PreAuthorize("hasAuthority('surveys:read')")
    @GetMapping("/exist/{surveyID}")
    public boolean exists(@PathVariable String surveyID) {
        return surveysService.exists(surveyID);
    }

    @PreAuthorize("hasAuthority('surveys:read')")
    @GetMapping("/list/{page}/{size}")
    public Page<Survey> getPage(@PathVariable int page, @PathVariable int size) throws EntityNotFoundException {
        return surveysService.getPage(page, size);
    }

    @PreAuthorize("hasAuthority('surveys:write')")
    @PostMapping("/import/{fileName}")
    public Survey mapReapExcelDataToDB(@PathVariable String fileName) throws IdConflictException, IOException, EntityNotFoundException {
        return surveysService.mapReapExcelDataToDB(fileName);
    }
}
