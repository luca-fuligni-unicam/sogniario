package it.unicam.morpheus.sogniario.controllers;

import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Graph;
import it.unicam.morpheus.sogniario.model.Report;
import it.unicam.morpheus.sogniario.services.ReportsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

/**
 * The class provides Rest APIs to manage instances of the {@link Report} class
 */
@RestController
@RequestMapping("api/reports")
public class ReportsController {

    private final ReportsService reportsService;

    @Autowired
    public ReportsController(ReportsService reportsService) {
        this.reportsService = reportsService;
    }

    @PreAuthorize("hasAuthority('reports:read')")
    @GetMapping("/{reportID}")
    public Report getInstance(@PathVariable String reportID) throws EntityNotFoundException {
        return reportsService.getInstance(reportID);
    }

    @PreAuthorize("hasAuthority('reports:write')")
    @PostMapping(value = "/createNew", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Report create(@RequestBody Report object) throws EntityNotFoundException, IdConflictException {
        return reportsService.create(object);
    }

    @PreAuthorize("hasAuthority('reports:write')")
    @PutMapping(value = "/update", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Report update(@RequestBody Report object) throws EntityNotFoundException, IdConflictException {
        return reportsService.update(object);
    }

    @PreAuthorize("hasAuthority('reports:write')")
    @DeleteMapping(value = "/{reportID}")
    public boolean delete(@PathVariable String reportID) {
        return reportsService.delete(reportID);
    }

    @PreAuthorize("hasAuthority('reports:read')")
    @GetMapping("/exist/{reportID}")
    public boolean exists(@PathVariable String reportID) {
        return reportsService.exists(reportID);
    }

    @PreAuthorize("hasAuthority('reports:read')")
    @GetMapping("/list/{page}/{size}")
    public Page<Report> getPage(@PathVariable int page, @PathVariable int size) throws EntityNotFoundException {
        return reportsService.getPage(page, size);
    }

    @PreAuthorize("hasAuthority('reports:read')")
    @GetMapping("/listById/{page}/{size}/{dreamerID}")
    public Page<Report> getPageByDreamerId(@PathVariable int page, @PathVariable int size, @PathVariable String dreamerID) throws EntityNotFoundException {
        return reportsService.getPageByDreamerId(page, size, dreamerID);
    }

    @PreAuthorize("hasAuthority('reports:read')")
    @GetMapping("/listByIdAndData/{dreamerID}/{data}")
    public List<Report> getByDreamerIdAndDate(@PathVariable String dreamerID, @PathVariable String data) throws EntityNotFoundException {
        return reportsService.getByDreamerIdAndDate(dreamerID, data);
    }

    @PreAuthorize("hasAuthority('reports:read')")
    @GetMapping("/dreamNumberOfWord/{reportID}")
    public int getDreamNumberOfWord(@PathVariable String reportID) throws EntityNotFoundException {
        return reportsService.getDreamNumberOfWord(reportID);
    }

    @PreAuthorize("hasAuthority('reports:read')")
    @GetMapping("/reportArchiveByYearAndSemester/{year}/{semester}")
    public ResponseEntity<byte[]> getReportArchiveByYearAndSemester(@PathVariable int year, @PathVariable int semester) throws IllegalStateException, IOException {
        return reportsService.getReportArchiveByYearAndSemester(year, semester);
    }

    @PreAuthorize("hasAuthority('reports:read')")
    @GetMapping("/getReportArchiveBetweenTwoDates/{date1}/{date2}")
    public ResponseEntity<byte[]> getReportArchiveBetweenTwoDates(@PathVariable LocalDate date1, @PathVariable LocalDate date2) throws IllegalStateException, IOException {
        return reportsService.getReportArchiveBetweenTwoDates(date1, date2);
    }

    @PreAuthorize("hasAuthority('reports:read')")
    @GetMapping("/getGraph/{reportId}")
    public Map<String, List<String>> getGraph(@PathVariable String reportId) throws IOException, EntityNotFoundException {
        return reportsService.getGraph(reportId);
    }

}
