package it.unicam.morpheus.sogniario.repository;

import it.unicam.morpheus.sogniario.model.Dreamer;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DreamersRepository extends MongoRepository<Dreamer, String> {
}
