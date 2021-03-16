package it.unicam.morpheus.sogniario.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;

import java.util.Calendar;

@NoArgsConstructor
public class Dream {

    @Getter @Setter @NonNull
    private String Id;

    @Getter @Setter @NonNull
    private String text;

    @Getter @Setter @NonNull
    private Calendar data;

    @Getter @Setter @NonNull
    private String reportId;

    public Dream(String text, String reportId){
        if(text.isBlank()) throw new IllegalArgumentException("The dream is blank");
        if(reportId.isBlank()) throw new IllegalArgumentException("Report Id is blank");
        this.text = text;
        this.data = Calendar.getInstance();
        this.reportId = reportId;
    }

}
