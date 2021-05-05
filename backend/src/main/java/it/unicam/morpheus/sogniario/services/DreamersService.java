package it.unicam.morpheus.sogniario.services;

import it.unicam.morpheus.sogniario.checker.CompletedSurveyChecker;
import it.unicam.morpheus.sogniario.checker.DreamerChecker;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.CompletedSurvey;
import it.unicam.morpheus.sogniario.model.Dreamer;
import it.unicam.morpheus.sogniario.repositories.DreamersRepository;
import it.unicam.morpheus.sogniario.security.UserRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

/**
 * The interface extends {@link EntityService} and adds operations to better manage instances of the {@link Dreamer} class.
 */
@Service
public class DreamersService implements EntityService<Dreamer, String> {

    private final DreamersRepository dreamersRepository;
    private final CompletedSurveyChecker completedSurveyChecker;
    private final DreamerChecker dreamerChecker;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public DreamersService(DreamersRepository dreamersRepository, CompletedSurveyChecker completedSurveyChecker, DreamerChecker dreamerChecker, PasswordEncoder passwordEncoder) {
        this.dreamersRepository = dreamersRepository;
        this.completedSurveyChecker = completedSurveyChecker;
        this.dreamerChecker = dreamerChecker;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public Dreamer getInstance(String id) throws EntityNotFoundException {
        return dreamersRepository.findById(id).orElseThrow(()->
                new EntityNotFoundException("Nessun Dreamer trovato con l'ID: "+id));
    }

    @Override
    public Dreamer create(Dreamer object) throws EntityNotFoundException, IdConflictException {
        if(exists(object.getUsername())) throw new IdConflictException("Id già presente");

        //dreamerChecker.check(object);

        return dreamersRepository.save(
                new Dreamer(
                        object.getUsername(),
                        passwordEncoder.encode(object.getPassword()),
                        UserRole.DREAMER.getGrantedAuthorities(),
                        object.getNascita(),
                        object.getSesso()
                )
        );
    }

    @Override
    public Dreamer update(Dreamer object) throws EntityNotFoundException, IdConflictException {
        if(!exists(object.getUsername()))
            throw new EntityNotFoundException("Nessun Dreamer con id: "+ object.getUsername());
        dreamerChecker.check(object);
        return dreamersRepository.save(object);
    }

    @Override
    public boolean delete(String id) {
        // TODO: 16/03/2021 implementare
        return false;
    }

    @Override
    public boolean exists(String id) {
        if(id.isBlank()) throw new IllegalArgumentException("Il campo 'ID' è vuoto");
        return dreamersRepository.existsById(id);
    }

    @Override
    public Page<Dreamer> getPage(int page, int size) throws EntityNotFoundException {
        return dreamersRepository.findAll(PageRequest.of(page, size));
    }

    public boolean addCompletedSurvey(CompletedSurvey completedSurvey, String dreamerID) throws EntityNotFoundException {
        if(dreamerID.isBlank()) throw new IllegalArgumentException("Il campo 'ID' è vuoto");

        completedSurveyChecker.check(completedSurvey);

        if(dreamersRepository.findById(dreamerID).isPresent()){
            Dreamer d = dreamersRepository.findById(dreamerID).get();
            d.addCompletedSurvey(completedSurvey);
            dreamersRepository.save(d);
        } else throw new EntityNotFoundException("Nessun Dreamer trovato con l'ID: "+dreamerID);

        return true;
    }
}
