package it.unicam.morpheus.sogniario.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;

import java.util.Calendar;

@NoArgsConstructor
public class Dream {

    @Getter @Setter @NonNull
    private String id;

    @Getter @Setter @NonNull
    private String text;

    @Getter @Setter @NonNull
    private Calendar data;

    public Dream(String text){
        if(text.isBlank()) throw new IllegalArgumentException("The dream is blank");
        this.text = text;
        this.data = Calendar.getInstance();
    }

}
