package it.unicam.morpheus.sogniario.controller;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.model.Report;
import org.springframework.data.domain.Page;

import java.util.List;

/**
 * The interface extends {@link EntityController} and adds operations to better manage instances of the {@link Report} class.
 */
public interface ReportsController extends EntityController<Report, String> {

    Page<Report> getPageByDreamerId(int page, int size, String dreamerID) throws EntityNotFoundException;

    List<Report> getByDreamerIdAndDate(String dreamerID, String data) throws EntityNotFoundException;

    int getDreamNumberOfWord(String reportID) throws EntityNotFoundException;

}
