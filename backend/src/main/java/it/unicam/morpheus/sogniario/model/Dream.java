package it.unicam.morpheus.sogniario.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;

import java.time.LocalDateTime;

/**
 * The class has as its objective the description of a Dream that keeps within it the text of the dream and the date of its registration.
 */
@NoArgsConstructor
@Getter @Setter @NonNull
public class Dream {

    private String text;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime data;

    public Dream(String text){
        if(text.isBlank()) throw new IllegalArgumentException("The dream is blank");
        this.text = text;
        this.data = LocalDateTime.now();
    }

}
