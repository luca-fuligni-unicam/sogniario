package it.unicam.morpheus.sogniario.controller;

import it.unicam.morpheus.sogniario.checker.SurveyChecker;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Survey;
import it.unicam.morpheus.sogniario.repository.SurveysRepository;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.*;

@Validated
@Service
public class SurveysConcreteController implements SurveysController{

    @Autowired
    private SurveysRepository surveysRepository;

    @Autowired
    private SurveyChecker surveyChecker;

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

    @Override
    public Survey mapReapExcelDatatoDB(MultipartFile reapExcelDataFile) throws IOException, IdConflictException, EntityNotFoundException {
        HSSFWorkbook workbook = new HSSFWorkbook((reapExcelDataFile.getInputStream()));

        HSSFSheet worksheet = workbook.getSheetAt(0);

        Survey tempSurvey = new Survey();
        tempSurvey.setId(Objects.requireNonNull(reapExcelDataFile.getOriginalFilename()));

        Map<String, Set<String>> questions = new HashMap<>();
        for(int i=1; i<worksheet.getPhysicalNumberOfRows(); i++) {

            HSSFRow row = worksheet.getRow(i);

            Set<String> answers = new HashSet<>();

            for(int j = 2; !row.getCell(j).getStringCellValue().isBlank(); j++)
                answers.add(row.getCell(j).getStringCellValue());

            questions.put(row.getCell(1).getStringCellValue(), answers);
        }
        tempSurvey.setQuestions(questions);

        return create(tempSurvey);
    }
}
