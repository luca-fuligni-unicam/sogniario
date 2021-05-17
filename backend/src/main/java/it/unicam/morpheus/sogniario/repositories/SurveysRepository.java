package it.unicam.morpheus.sogniario.repositories;

import it.unicam.morpheus.sogniario.model.Survey;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

/**
 * The interface represents the repository that will keep the {@link Survey} instances in persistence.
 */
@Repository
public interface SurveysRepository extends MongoRepository<Survey, String> {}
