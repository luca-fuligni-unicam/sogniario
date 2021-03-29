package it.unicam.morpheus.sogniario.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;

import java.time.LocalDateTime;

@NoArgsConstructor
public class Dream {

    @Getter @Setter @NonNull
    private String text;

    @Getter @Setter @NonNull
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime data;

    public Dream(String text){
        if(text.isBlank()) throw new IllegalArgumentException("The dream is blank");
        this.text = text;
        this.data = LocalDateTime.now();
    }

}
