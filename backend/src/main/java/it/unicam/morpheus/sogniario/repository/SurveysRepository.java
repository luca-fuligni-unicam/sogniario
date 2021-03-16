package it.unicam.morpheus.sogniario.repository;

import it.unicam.morpheus.sogniario.model.Survey;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SurveysRepository extends MongoRepository<Survey, String> {
}
