package it.unicam.morpheus.sogniario.boundary;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.model.Report;
import org.springframework.data.domain.Page;

import java.io.IOException;
import java.util.List;

/**
 * The interface extends {@link EntityBoundary} and adds operations to better manage instances of the {@link Report} class.
 */
public interface ReportsBoundary extends EntityBoundary<Report, String> {

    Page<Report> getPageByDreamerId(int page, int size, String dreamerID) throws EntityNotFoundException;

    List<Report> getByDreamerIdAndDate(String dreamerID, String data) throws EntityNotFoundException;

    int getDreamNumberOfWord(String reportID) throws EntityNotFoundException;

    boolean getReportArchiveByDate(String date) throws IOException;

    // TODO: 17/03/2021 getDreamGraph

}
