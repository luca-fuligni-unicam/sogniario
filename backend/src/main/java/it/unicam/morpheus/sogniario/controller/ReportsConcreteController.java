package it.unicam.morpheus.sogniario.controller;

import it.unicam.morpheus.sogniario.checker.ReportChecker;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Report;
import it.unicam.morpheus.sogniario.repository.DreamersRepository;
import it.unicam.morpheus.sogniario.repository.ReportsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Validated
@Service
public class ReportsConcreteController implements ReportsController{

    @Autowired
    private ReportsRepository reportsRepository;

    @Autowired
    private ReportChecker reportChecker;

    @Autowired
    private DreamersRepository dreamersRepository;

    @Override
    public Report getInstance(String id) throws EntityNotFoundException {
        return reportsRepository.findById(id).orElseThrow(()->
                new EntityNotFoundException("Nessun Report trovato con l'ID: "+id));
    }

    @Override
    public Report create(Report object) throws EntityNotFoundException, IdConflictException {
        reportChecker.check(object);
        return reportsRepository.save(object);
    }

    @Override
    public Report update(Report object) throws EntityNotFoundException, IdConflictException {
        if(!exists(object.getId()))
            throw new EntityNotFoundException("Nessun Report con id: "+ object.getId());
        reportChecker.check(object);
        return reportsRepository.save(object);
    }

    @Override
    public boolean delete(String id) {
        // TODO: 16/03/2021 implementare
        return false;
    }

    @Override
    public boolean exists(String id) {
        if(id.isBlank()) throw new IllegalArgumentException("Il campo 'ID' è vuoto");
        return reportsRepository.existsById(id);
    }

    @Override
    public Page<Report> getPage(int page, int size) throws EntityNotFoundException {
        return reportsRepository.findAll(PageRequest.of(page, size));
    }

    @Override
    public Page<Report> getPageByDreamerId(int page, int size, String dreamerID) throws EntityNotFoundException {
        if(dreamerID.isBlank()) throw new IllegalArgumentException("Il campo 'dreamerID' è vuoto");
        if(!dreamersRepository.existsById(dreamerID))
            throw new EntityNotFoundException("Nessun dreamer con id: "+ dreamerID);
        return new PageImpl<>(
                reportsRepository.findAll(PageRequest.of(page, size))
                        .stream().filter(r -> r.getDreamerId().equals(dreamerID))
                        .collect(Collectors.toList()));
    }

    @Override
    public List<Report> getByDreamerIdAndDate(String dreamerID, String data) throws EntityNotFoundException {
        if(dreamerID.isBlank()) throw new IllegalArgumentException("Il campo 'dreamerID' è vuoto");
        if(!dreamersRepository.existsById(dreamerID))
            throw new EntityNotFoundException("Nessun dreamer con id: "+ dreamerID);
        LocalDate localDate;
        if(data.isBlank()) throw new IllegalArgumentException("Il campo 'data' è vuoto");
        try{ localDate = LocalDate.parse(data); }
        catch (Exception e) { throw new IllegalArgumentException("Il campo 'data' non è valido"); }

        return reportsRepository.findByDreamerId(dreamerID).stream().filter(r ->
                        r.getDream().getData().getYear() == localDate.getYear() &&
                        r.getDream().getData().getMonth().equals(localDate.getMonth()) &&
                        r.getDream().getData().getDayOfMonth() == localDate.getDayOfMonth())
                .collect(Collectors.toList());
    }

    @Override
    public int getDreamNumberOfWord(String reportID) throws EntityNotFoundException {
        if(!reportsRepository.existsById(reportID))
            throw new EntityNotFoundException("Nessun report con id: "+ reportID);
        // TODO: 17/03/2021 da implementare
        return 0;
    }
}
