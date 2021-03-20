package it.unicam.morpheus.sogniario.boundary;

import it.unicam.morpheus.sogniario.controller.SurveysController;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Survey;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RestController
@RequestMapping("api/survey")
public class SurveysRestBoundary implements SurveysBoundary{

    @Autowired
    private SurveysController surveysController;

    @Override
    @PreAuthorize("permitAll")
    @GetMapping("/{surveyID}")
    public Survey getInstance(@PathVariable String surveyID) throws EntityNotFoundException {
        return surveysController.getInstance(surveyID);
    }

    @Override
    @PreAuthorize("permitAll")
    @PostMapping(value = "/createNew", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Survey create(@RequestBody Survey object) throws EntityNotFoundException, IdConflictException {
        return surveysController.create(object);
    }

    @Override
    @PreAuthorize("permitAll")
    @PutMapping(value = "/update", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Survey update(@RequestBody Survey object) throws EntityNotFoundException, IdConflictException {
        return surveysController.update(object);
    }

    @Override
    @PreAuthorize("permitAll")
    @DeleteMapping(value = "/{surveyID}")
    public boolean delete(@PathVariable String surveyID) {
        return surveysController.delete(surveyID);
    }

    @Override
    @PreAuthorize("permitAll")
    @GetMapping("/exist/{surveyID}")
    public boolean exists(@PathVariable String surveyID) {
        return surveysController.exists(surveyID);
    }

    @Override
    @PreAuthorize("permitAll")
    @GetMapping("/list/{page}/{size}")
    public Page<Survey> getPage(@PathVariable int page, @PathVariable int size) throws EntityNotFoundException {
        return surveysController.getPage(page, size);
    }

    @Override
    @PreAuthorize("permitAll")
    @PostMapping(value = "/import/{reapExcelDataFile}")
    public Survey mapReapExcelDatatoDB(@PathVariable MultipartFile reapExcelDataFile) throws IOException, EntityNotFoundException, IdConflictException {
        return surveysController.mapReapExcelDatatoDB(reapExcelDataFile);
    }
}
