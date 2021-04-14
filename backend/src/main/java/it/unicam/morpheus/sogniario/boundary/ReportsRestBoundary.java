package it.unicam.morpheus.sogniario.boundary;

import it.unicam.morpheus.sogniario.controller.ReportsController;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Report;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

/**
 * The class implements the {@link ReportsBoundary} interface so as to provide its API Rest.
 */
@RestController
@RequestMapping("api/reports")
public class ReportsRestBoundary implements ReportsBoundary{

    @Autowired
    private ReportsController reportsController;

    @Override
    @PreAuthorize("permitAll")
    @GetMapping("/{reportID}")
    public Report getInstance(@PathVariable String reportID) throws EntityNotFoundException {
        return reportsController.getInstance(reportID);
    }

    @Override
    @PreAuthorize("permitAll")
    @PostMapping(value = "/createNew", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Report create(@RequestBody Report object) throws EntityNotFoundException, IdConflictException {
        return reportsController.create(object);
    }

    @Override
    @PreAuthorize("permitAll")
    @PutMapping(value = "/update", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Report update(@RequestBody Report object) throws EntityNotFoundException, IdConflictException {
        return reportsController.update(object);
    }

    @Override
    @PreAuthorize("permitAll")
    @DeleteMapping(value = "/{reportID}")
    public boolean delete(@PathVariable String reportID) {
        return reportsController.delete(reportID);
    }

    @Override
    @PreAuthorize("permitAll")
    @GetMapping("/exist/{reportID}")
    public boolean exists(@PathVariable String reportID) {
        return reportsController.exists(reportID);
    }

    @Override
    @PreAuthorize("permitAll")
    @GetMapping("/list/{page}/{size}")
    public Page<Report> getPage(@PathVariable int page, @PathVariable int size) throws EntityNotFoundException {
        return reportsController.getPage(page, size);
    }

    @Override
    @PreAuthorize("permitAll")
    @GetMapping("/listById/{page}/{size}/{dreamerID}")
    public Page<Report> getPageByDreamerId(@PathVariable int page, @PathVariable int size, @PathVariable String dreamerID) throws EntityNotFoundException {
        return reportsController.getPageByDreamerId(page, size, dreamerID);
    }

    @Override
    @PreAuthorize("permitAll")
    @GetMapping("/listByIdAndData/{dreamerID}/{data}")
    public List<Report> getByDreamerIdAndDate(@PathVariable String dreamerID, @PathVariable String data) throws EntityNotFoundException {
        return reportsController.getByDreamerIdAndDate(dreamerID, data);
    }

    @Override
    @PreAuthorize("permitAll")
    @GetMapping("/dreamNumberOfWord/{reportID}")
    public int getDreamNumberOfWord(@PathVariable String reportID) throws EntityNotFoundException {
        return reportsController.getDreamNumberOfWord(reportID);
    }

    @Override
    @PreAuthorize("permitAll")
    @GetMapping("/reportArchiveByDate/{date}")
    public boolean getReportArchiveByDate(@PathVariable String date) throws IOException {
        return reportsController.getReportArchiveByDate(date);
    }
}
