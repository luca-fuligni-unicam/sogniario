package it.unicam.morpheus.sogniario.checker;

import it.unicam.morpheus.sogniario.model.Survey;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import java.util.List;
import java.util.Map;

@Validated
@Service
public class SurveyChecker implements EntityChecker<Survey>{
    @Override
    public boolean check(Survey object) {

        if(object.getQuestions().isEmpty())
            throw new IllegalStateException("La lista delle domande del Survey è vuota");

        for(Map.Entry<String, List<String>> a: object.getQuestions().entrySet()) {
            if (a.getKey().isBlank())
                throw new IllegalStateException("Una domanda del Survey è vuota");
            if (a.getValue().isEmpty())
                throw new IllegalStateException("Una domanda del Survey posside una lista delle risposte vuota");
            for(String s: a.getValue())
                if (s.isBlank()) throw new IllegalStateException("Una domanda del Survey posside una risposta vuota");
        }

        return true;
    }
}
