package it.unicam.morpheus.sogniario.repository;

import it.unicam.morpheus.sogniario.model.Nomination;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NominationsRepository extends MongoRepository<Nomination, String> {
}
