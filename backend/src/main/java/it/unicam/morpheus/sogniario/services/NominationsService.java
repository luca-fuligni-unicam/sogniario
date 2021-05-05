package it.unicam.morpheus.sogniario.services;

import it.unicam.morpheus.sogniario.checker.NominationChecker;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Nomination;
import it.unicam.morpheus.sogniario.repositories.NominationsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

/**
 * The interface extends {@link EntityService} and adds operations to better manage instances of the {@link Nomination} class.
 */
@Service
public class NominationsService implements EntityService<Nomination, String>{

    private final NominationsRepository nominationsRepository;
    private final NominationChecker nominationChecker;

    @Autowired
    public NominationsService(NominationsRepository nominationsRepository, NominationChecker nominationChecker) {
        this.nominationsRepository = nominationsRepository;
        this.nominationChecker = nominationChecker;
    }

    @Override
    public Nomination getInstance(String id) throws EntityNotFoundException {
        return nominationsRepository.findById(id).orElseThrow(()->
                new EntityNotFoundException("Nessuna Nomination trovato con l'Email: "+id));
    }

    @Override
    public Nomination create(Nomination object) throws EntityNotFoundException, IdConflictException {
        if(exists(object.getEmail())) throw new IdConflictException("Email già presente");
        nominationChecker.check(object);
        return nominationsRepository.save(object);
    }

    @Override
    public Nomination update(Nomination object) throws EntityNotFoundException, IdConflictException {
        if(!exists(object.getEmail()))
            throw new EntityNotFoundException("Nessuna Nomination con email: "+ object.getEmail());
        nominationChecker.check(object);
        return nominationsRepository.save(object);
    }

    @Override
    public boolean delete(String id) {
        // TODO: 02/04/2021 implementare
        return false;
    }

    @Override
    public boolean exists(String id) {
        if(id.isBlank()) throw new IllegalArgumentException("Il campo 'Email' è vuoto");
        return nominationsRepository.existsById(id);
    }

    @Override
    public Page<Nomination> getPage(int page, int size) throws EntityNotFoundException {
        return nominationsRepository.findAll(PageRequest.of(page, size));
    }
}
