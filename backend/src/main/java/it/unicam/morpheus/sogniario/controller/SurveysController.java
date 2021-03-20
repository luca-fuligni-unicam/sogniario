package it.unicam.morpheus.sogniario.controller;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Survey;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public interface SurveysController extends EntityController<Survey, String> {

    Survey mapReapExcelDatatoDB(MultipartFile reapExcelDataFile) throws IOException, IdConflictException, EntityNotFoundException;
}
