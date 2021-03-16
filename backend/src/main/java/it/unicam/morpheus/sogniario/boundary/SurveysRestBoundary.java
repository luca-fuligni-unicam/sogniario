package it.unicam.morpheus.sogniario.boundary;

import it.unicam.morpheus.sogniario.controller.SurveysController;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Survey;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/survey")
public class SurveysRestBoundary implements SurveysBoundary{

    @Autowired
    private SurveysController surveysController;

    @Override
    @PreAuthorize("permitAll")
    @GetMapping("/{surveyID}")
    public Survey getInstance(@PathVariable String surveyID) throws EntityNotFoundException {
        // TODO: 16/03/2021 implementare
        return null;
    }

    @Override
    @PreAuthorize("permitAll")
    @PostMapping(value = "/createNew", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Survey create(@RequestBody Survey object) throws EntityNotFoundException, IdConflictException {
        // TODO: 16/03/2021 implementare
        return null;
    }

    @Override
    @PreAuthorize("permitAll")
    @PutMapping(value = "/update", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Survey update(@RequestBody Survey object) throws EntityNotFoundException, IdConflictException {
        // TODO: 16/03/2021 implementare
        return null;
    }

    @Override
    @PreAuthorize("permitAll")
    @DeleteMapping(value = "/{reportID}")
    public boolean delete(@PathVariable String reportID) {
        // TODO: 16/03/2021 implementare
        return false;
    }

    @Override
    @PreAuthorize("permitAll")
    @GetMapping("/exist/{reportID}")
    public boolean exists(@PathVariable String reportID) {
        // TODO: 16/03/2021 implementare
        return false;
    }
}
