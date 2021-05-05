package it.unicam.morpheus.sogniario.services;

import it.unicam.morpheus.sogniario.checker.ReportChecker;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Report;
import it.unicam.morpheus.sogniario.model.Survey;
import it.unicam.morpheus.sogniario.repositories.DreamersRepository;
import it.unicam.morpheus.sogniario.repositories.ReportsRepository;
import it.unicam.morpheus.sogniario.repositories.SurveysRepository;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

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

    public boolean getReportArchiveByDate(String date) throws IOException {

        LocalDate localDate;
        if(date.isBlank()) throw new IllegalArgumentException("Il campo 'date' è vuoto");
        try{ localDate = LocalDate.parse(date); }
        catch (Exception e) { throw new IllegalArgumentException("Il campo 'date' non è valido"); }

        List<Report> reportList = reportsRepository.findAll().stream().filter(r ->
                r.getDream().getData().getYear() == localDate.getYear() &&
                        r.getDream().getData().getMonth().equals(localDate.getMonth()))
                .collect(Collectors.toList());

        if(reportList.isEmpty()) return false;

        for(Report r: reportList){
            PDDocument document = new PDDocument();
            PDPage page = new PDPage();
            document.addPage(page);

            PDPageContentStream contentStream = new PDPageContentStream(document, page);

            contentStream.setFont(PDType1Font.COURIER, 12);
            contentStream.beginText();

            contentStream.showText("Dreamer ID: " + r.getDreamerId() + "\n");

            contentStream.showText("Dream:\n" + r.getDream().getText() + "\n");

            contentStream.showText("Data registrazione sogno: " + r.getDream().getData() + "\n");

            Optional<Survey> survey = surveysRepository.findById(r.getCompletedSurvey().getSurveyId());
            if(survey.isPresent()){
                contentStream.showText("Survey:\n");
                int i=0;
                for(Map.Entry<String, List<String>> e: survey.get().getQuestions().entrySet()){
                    contentStream.showText( e.getKey() + "\n" + r.getCompletedSurvey().getAnswers().get(i) + "\n");
                    i++;
                }
            }

            contentStream.endText();
            contentStream.close();

            document.save(r.getId() + ".pdf");
            document.close();
        }

        return true;
    }
}

