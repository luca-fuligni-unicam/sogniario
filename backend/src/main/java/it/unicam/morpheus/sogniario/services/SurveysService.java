package it.unicam.morpheus.sogniario.services;

import it.unicam.morpheus.sogniario.checker.SurveyChecker;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Survey;
import it.unicam.morpheus.sogniario.repositories.SurveysRepository;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * The interface extends {@link EntityService} and adds operations to better manage instances of the {@link Survey} class.
 */
@Service
public class SurveysService implements EntityService<Survey, String> {


    private final SurveysRepository surveysRepository;
    private final SurveyChecker surveyChecker;

    @Autowired
    public SurveysService(SurveysRepository surveysRepository, SurveyChecker surveyChecker) {
        this.surveysRepository = surveysRepository;
        this.surveyChecker = surveyChecker;
    }

    @Override
    public Survey getInstance(String id) throws EntityNotFoundException {
        return surveysRepository.findById(id).orElseThrow(()->
                new EntityNotFoundException("Nessun Survey trovato con l'ID: "+id));
    }

    @Override
    public Survey create(Survey object) throws EntityNotFoundException, IdConflictException {
        if(exists(object.getId())) throw new IdConflictException("Id già presente");
        surveyChecker.check(object);
        return surveysRepository.save(object);

    }

    @Override
    public Survey update(Survey object) throws EntityNotFoundException, IdConflictException {
        if(!exists(object.getId()))
            throw new EntityNotFoundException("Nessun Survey con id: "+ object.getId());
        surveyChecker.check(object);
        return surveysRepository.save(object);
    }

    @Override
    public boolean delete(String id) {
        // TODO: 16/03/2021 implementare
        return false;
    }

    @Override
    public boolean exists(String id) {
        if(id.isBlank()) throw new IllegalArgumentException("Il campo 'ID' è vuoto");
        return surveysRepository.existsById(id);
    }

    @Override
    public Page<Survey> getPage(int page, int size) throws EntityNotFoundException {
        return surveysRepository.findAll(PageRequest.of(page, size));
    }

    public Survey mapReapExcelDataToDB(String fileName) throws IOException, IdConflictException, EntityNotFoundException {

        // TODO: 21/03/2021 rendere funzioannte con l'estensione .xlsx da usare l'intefaccia XSSF invece della HSSF
        // https://poi.apache.org/components/spreadsheet/how-to.html
        HSSFWorkbook workbook = new HSSFWorkbook(new FileInputStream(Paths.get("data", "survey", fileName).toAbsolutePath().toString()));
        HSSFSheet worksheet = workbook.getSheetAt(0);

        Survey tempSurvey = new Survey();
        // TODO: 21/03/2021 se funzionante con l'estensone .xlsx togliere 5 caratteri
        tempSurvey.setId(fileName.substring(0, fileName.length()-4));

        Map<String, List<String>> questions = new LinkedHashMap<>();
        for(int i=0; !(worksheet.getRow(i) == null || worksheet.getRow(i).getLastCellNum() <= 0); i++) {

            HSSFRow row = worksheet.getRow(i);

            List<String> answers = new ArrayList<>();

            for(int j = 1; !(row.getCell(j) == null || row.getCell(j).getCellType().equals(CellType.BLANK)); j++)
                answers.add(
                        row.getCell(j).getCellType().equals(CellType.STRING) ?
                                row.getCell(j).getStringCellValue():
                                Double.toString(row.getCell(j).getNumericCellValue())
                );

            questions.put(row.getCell(0).getStringCellValue(), answers);
        }
        tempSurvey.setQuestions(questions);

        return create(tempSurvey);
    }
}
