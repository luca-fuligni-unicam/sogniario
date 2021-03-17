package it.unicam.morpheus.sogniario.checker;

import it.unicam.morpheus.sogniario.model.Survey;

public class SurveyChecker implements EntityChecker<Survey>{
    @Override
    public boolean check(Survey object) {

        if(object.getQuestions().isEmpty())
            throw new IllegalStateException("LA lista delle domande del Survey è vuota");

        return true;
    }
}
