package it.unicam.morpheus.sogniario.jwt;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.http.HttpHeaders;

@NoArgsConstructor
@ConfigurationProperties(prefix = "application.jwt")
@Getter @Setter
public class JwtConfig {

    private String secretKey;

    private String tokenPrefix;

    private Integer tokenExpirationAfterDays;

    public String getAuthorizationHeader() {
        return HttpHeaders.AUTHORIZATION;
    }
}
