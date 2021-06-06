package it.unicam.morpheus.sogniario.services;

import it.unicam.morpheus.sogniario.checker.ReportChecker;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.CompletedSurvey;
import it.unicam.morpheus.sogniario.model.Dreamer;
import it.unicam.morpheus.sogniario.model.Report;
import it.unicam.morpheus.sogniario.model.Survey;
import it.unicam.morpheus.sogniario.repositories.DreamersRepository;
import it.unicam.morpheus.sogniario.repositories.ReportsRepository;
import it.unicam.morpheus.sogniario.repositories.SurveysRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * The interface extends {@link EntityService} and adds operations to better manage instances of the {@link Report} class.
 */
@Service
public class ReportsService implements EntityService<Report, String>{

    private final ReportsRepository reportsRepository;
    private final ReportChecker reportChecker;
    private final DreamersRepository dreamersRepository;
    private final SurveysRepository surveysRepository;

    @Autowired
    public ReportsService(ReportsRepository reportsRepository, ReportChecker reportChecker, DreamersRepository dreamersRepository, SurveysRepository surveysRepository) {
        this.reportsRepository = reportsRepository;
        this.reportChecker = reportChecker;
        this.dreamersRepository = dreamersRepository;
        this.surveysRepository = surveysRepository;
    }


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

    public Page<Report> getPageByDreamerId(int page, int size, String dreamerID) throws EntityNotFoundException {
        if(dreamerID.isBlank()) throw new IllegalArgumentException("Il campo 'dreamerID' è vuoto");
        if(!dreamersRepository.existsById(dreamerID))
            throw new EntityNotFoundException("Nessun dreamer con id: "+ dreamerID);
        return new PageImpl<>(
                reportsRepository.findAll(PageRequest.of(page, size))
                        .stream().filter(r -> r.getDreamerId().equals(dreamerID))
                        .collect(Collectors.toList()));
    }

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

    public int getDreamNumberOfWord(String reportID) throws EntityNotFoundException {
        if(!reportsRepository.existsById(reportID))
            throw new EntityNotFoundException("Nessun report con id: "+ reportID);
        // TODO: 17/03/2021 da implementare
        return 0;
    }

    public ResponseEntity<byte[]> getReportArchiveByYearAndSemester(int year, int semester) throws IllegalStateException, IOException {

        if(semester <1 || semester > 2) throw new IllegalArgumentException("Semester must be between 1 and 2");

        List<Report> reportList = reportsRepository.findAll().stream()
                .filter(r -> r.getDream().getData().getYear() == year && (semester == 1) == (r.getDream().getData().getMonth().getValue() <= 6))
                //.filter(r -> r.getDream().getData().getYear() == year && (semester == 1 ? r.getDream().getData().getMonth().getValue() <= 6 : r.getDream().getData().getMonth().getValue() > 6))
                .collect(Collectors.toList());

        if(reportList.isEmpty()) throw new IllegalStateException("There are no reports for this semester of this year");

        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        ZipOutputStream zos = new ZipOutputStream(bos);

        for(Report r: reportList){

            String report = "";
            report = report.concat("Dreamer ID: " + r.getDreamerId() + "\n");
            report = report.concat("Dream:" + r.getDream().getText() + "\n");
            report = report.concat("Data registrazione sogno: " + r.getDream().getData() + "\n");

            Optional<Survey> survey = surveysRepository.findById(r.getCompletedSurvey().getSurveyId());
            if(survey.isPresent()){
                report = report.concat("Survey:\n");
                List<String> quest = new ArrayList<>(survey.get().getQuestions().keySet());
                for(int i=0; i <= r.getCompletedSurvey().getAnswers().size() -1; i++)
                    report = report.concat( quest.get(i) + "\n" + r.getCompletedSurvey().getAnswers().get(i) + "\n");
            }

            ZipEntry e = new ZipEntry(r.getDreamerId() + "/Report/" + r.getId() + ".txt");
            zos.putNextEntry(e);
            byte[] data = report.getBytes();
            zos.write(data, 0, data.length);
            zos.closeEntry();
        }

        for(Dreamer d: dreamersRepository.findAll()){
            for(CompletedSurvey c: d.getCompletedSurveys().stream().filter(c -> c.getData().getYear() == year && (semester == 1) == (c.getData().getMonth().getValue() <= 6)).collect(Collectors.toSet())){
                Optional<Survey> survey = surveysRepository.findById(c.getSurveyId());
                String completedSurvey = "";
                if(survey.isPresent()){
                    List<String> quest = new ArrayList<>(survey.get().getQuestions().keySet());
                    for(int i=0; i <= c.getAnswers().size() -1; i++)
                        completedSurvey = completedSurvey.concat( quest.get(i) + "\n" + c.getAnswers().get(i) + "\n");
                }
                ZipEntry e = new ZipEntry(d.getUsername() + "/" + c.getSurveyId()+ "/" + c.getData() + ".txt");
                zos.putNextEntry(e);
                byte[] data = completedSurvey.getBytes();
                zos.write(data, 0, data.length);
                zos.closeEntry();
            }
        }

        zos.close();

        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.set(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_OCTET_STREAM_VALUE);
        httpHeaders.set(HttpHeaders.CONTENT_DISPOSITION, ContentDisposition.attachment().filename(year + (semester == 1 ? "First" : "Second") + "Semester.zip").build().toString());
        return ResponseEntity.ok().headers(httpHeaders).body(bos.toByteArray());
    }

    public ResponseEntity<byte[]> getReportArchiveBetweenTwoDates(String date1, String date2) throws IllegalStateException, IOException {

        LocalDate localDate1;
        if(date1.isBlank()) throw new IllegalArgumentException("Il campo 'data1' è vuoto");
        try{ localDate1 = LocalDate.parse(date1); }
        catch (Exception e) { throw new IllegalArgumentException("Il campo 'data1' non è valido"); }

        LocalDate localDate2;
        if(date2.isBlank()) throw new IllegalArgumentException("Il campo 'data2' è vuoto");
        try{ localDate2 = LocalDate.parse(date2); }
        catch (Exception e) { throw new IllegalArgumentException("Il campo 'data2' non è valido"); }

        List<Report> reportList = reportsRepository.findAll().stream()
                .filter( r -> r.getDream().getData().toLocalDate().isAfter(localDate1) && r.getDream().getData().toLocalDate().isBefore(localDate2))
                .collect(Collectors.toList());

        if(reportList.isEmpty()) throw new IllegalStateException("There are no reports between this two dates");

        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        ZipOutputStream zos = new ZipOutputStream(bos);

        for(Report r: reportList){

            String report = "";
            report = report.concat("Dreamer ID: " + r.getDreamerId() + "\n");
            report = report.concat("Dream:" + r.getDream().getText() + "\n");
            report = report.concat("Data registrazione sogno: " + r.getDream().getData() + "\n");

            Optional<Survey> survey = surveysRepository.findById(r.getCompletedSurvey().getSurveyId());
            if(survey.isPresent()){
                report = report.concat("Survey:\n");
                List<String> quest = new ArrayList<>(survey.get().getQuestions().keySet());
                for(int i=0; i <= r.getCompletedSurvey().getAnswers().size() -1; i++)
                    report = report.concat( quest.get(i) + "\n" + r.getCompletedSurvey().getAnswers().get(i) + "\n");
            }

            ZipEntry e = new ZipEntry(r.getDreamerId() + "/Report/" + r.getId() + ".txt");
            zos.putNextEntry(e);
            byte[] data = report.getBytes();
            zos.write(data, 0, data.length);
            zos.closeEntry();
        }

        for(Dreamer d: dreamersRepository.findAll()){
            for(CompletedSurvey c: d.getCompletedSurveys().stream().filter(c -> c.getData().toLocalDate().isAfter(localDate1) && c.getData().toLocalDate().isBefore(localDate2)).collect(Collectors.toSet())){
                Optional<Survey> survey = surveysRepository.findById(c.getSurveyId());
                String completedSurvey = "";
                if(survey.isPresent()){
                    List<String> quest = new ArrayList<>(survey.get().getQuestions().keySet());
                    for(int i=0; i <= c.getAnswers().size() -1; i++)
                        completedSurvey = completedSurvey.concat( quest.get(i) + "\n" + c.getAnswers().get(i) + "\n");
                }
                ZipEntry e = new ZipEntry(d.getUsername() + "/" + c.getSurveyId()+ "/" + c.getData() + ".txt");
                zos.putNextEntry(e);
                byte[] data = completedSurvey.getBytes();
                zos.write(data, 0, data.length);
                zos.closeEntry();
            }
        }

        zos.close();

        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.set(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_OCTET_STREAM_VALUE);
        httpHeaders.set(HttpHeaders.CONTENT_DISPOSITION, ContentDisposition.attachment().filename(date1 + "_to_" + date2 +".zip").build().toString());
        return ResponseEntity.ok().headers(httpHeaders).body(bos.toByteArray());
    }

    public Map<String, List<String>> getGraph(String reportId) throws IOException, EntityNotFoundException {

        if(reportsRepository.findById(reportId).isEmpty()) throw new EntityNotFoundException("Report not exist");
        return reportsRepository.findById(reportId).get().getDream().getGraph();
    }
}

