package it.unicam.morpheus.sogniario.boundary;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.CompletedSurvey;
import it.unicam.morpheus.sogniario.model.Dreamer;

public interface DreamersBoundary extends EntityBoundary<Dreamer, String> {

    boolean addCompletedSurvey(CompletedSurvey completedSurvey, String dreamerID) throws EntityNotFoundException;
}
