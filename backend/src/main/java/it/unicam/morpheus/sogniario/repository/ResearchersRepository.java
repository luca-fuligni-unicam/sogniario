package it.unicam.morpheus.sogniario.repository;

import it.unicam.morpheus.sogniario.model.Researcher;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

/**
 * The interface represents the repository that will keep the {@link Researcher} instances in persistence.
 */
@Repository
public interface ResearchersRepository extends MongoRepository<Researcher, String> {
}
