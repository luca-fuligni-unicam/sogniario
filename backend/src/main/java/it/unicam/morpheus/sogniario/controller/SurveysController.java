package it.unicam.morpheus.sogniario.controller;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Survey;

import java.io.IOException;

public interface SurveysController extends EntityController<Survey, String> {

    Survey mapReapExcelDatatoDB(String fileName) throws IOException, IdConflictException, EntityNotFoundException;
}
