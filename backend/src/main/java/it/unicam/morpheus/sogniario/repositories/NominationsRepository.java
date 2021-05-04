package it.unicam.morpheus.sogniario.repositories;

import it.unicam.morpheus.sogniario.model.Nomination;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

/**
 * The interface represents the repository that will keep the {@link Nomination} instances in persistence.
 */
@Repository
public interface NominationsRepository extends MongoRepository<Nomination, String> {}
