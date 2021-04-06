package it.unicam.morpheus.sogniario.boundary;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Survey;

import java.io.IOException;

/**
 * The interface extends {@link EntityBoundary} and adds operations to better manage instances of the {@link Survey} class.
 */
public interface SurveysBoundary extends EntityBoundary<Survey, String> {
    Survey mapReapExcelDatatoDB(String fileName) throws IOException, EntityNotFoundException, IdConflictException;
}
