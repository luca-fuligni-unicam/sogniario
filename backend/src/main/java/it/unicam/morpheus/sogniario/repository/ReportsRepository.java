package it.unicam.morpheus.sogniario.repository;

import it.unicam.morpheus.sogniario.model.Report;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * The interface represents the repository that will keep the {@link Report} instances in persistence.
 */
@Repository
public interface ReportsRepository extends MongoRepository<Report, String> {
    List<Report> findByDreamerId(String dreamerId);
}
