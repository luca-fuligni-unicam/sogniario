package it.unicam.morpheus.sogniario.repository;

import it.unicam.morpheus.sogniario.model.Dreamer;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

/**
 * The interface represents the repository that will keep the {@link Dreamer} instances in persistence.
 */
@Repository
public interface DreamersRepository extends MongoRepository<Dreamer, String> {
}
