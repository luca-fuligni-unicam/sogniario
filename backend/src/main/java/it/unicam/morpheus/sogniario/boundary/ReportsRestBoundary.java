package it.unicam.morpheus.sogniario.boundary;

import it.unicam.morpheus.sogniario.controller.ReportsController;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Report;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/reports")
public class ReportsRestBoundary implements ReportsBoundary{

    @Autowired
    private ReportsController reportsController;

    @Override
    @PreAuthorize("permitAll")
    @GetMapping("/{reportID}")
    public Report getInstance(@PathVariable String reportID) throws EntityNotFoundException {
        // TODO: 16/03/2021 implementare
        return null;
    }

    @Override
    @PreAuthorize("permitAll")
    @PostMapping(value = "/createNew", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Report create(@RequestBody Report object) throws EntityNotFoundException, IdConflictException {
        // TODO: 16/03/2021 implementare
        return null;
    }

    @Override
    @PreAuthorize("permitAll")
    @PutMapping(value = "/update", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Report update(@RequestBody Report object) throws EntityNotFoundException, IdConflictException {
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
