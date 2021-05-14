package it.unicam.morpheus.sogniario.services;

import it.unicam.morpheus.sogniario.checker.NominationChecker;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Nomination;
import it.unicam.morpheus.sogniario.model.Researcher;
import it.unicam.morpheus.sogniario.repositories.NominationsRepository;
import it.unicam.morpheus.sogniario.repositories.ResearchersRepository;
import it.unicam.morpheus.sogniario.security.UserRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Set;
import java.util.stream.Collectors;

/**
 * The interface extends {@link EntityService} and adds operations to better manage instances of the {@link Nomination} class.
 */
@Service
public class NominationsService implements EntityService<Nomination, String>{

    private final NominationsRepository nominationsRepository;
    private final NominationChecker nominationChecker;
    private final ResearchersRepository researchersRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public NominationsService(NominationsRepository nominationsRepository, NominationChecker nominationChecker, ResearchersRepository researchersRepository, PasswordEncoder passwordEncoder) {
        this.nominationsRepository = nominationsRepository;
        this.nominationChecker = nominationChecker;
        this.researchersRepository = researchersRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public Nomination getInstance(String id) throws EntityNotFoundException {
        return nominationsRepository.findById(id).orElseThrow(()->
                new EntityNotFoundException("Nessuna Nomination trovato con l'Email: "+id));
    }

    @Override
    public Nomination create(Nomination object) throws EntityNotFoundException, IdConflictException {
        if(researchersRepository.existsById(object.getEmail())) throw new IdConflictException("Email già presente nel sistema");
        if(exists(object.getEmail())) throw new IdConflictException("Email già presente");
        //nominationChecker.check(object);
        return nominationsRepository.save(
                new Nomination(
                        object.getEmail(),
                        passwordEncoder.encode( object.getPassword()),
                        object.getName(),
                        object.getMotivazione()
                )
        );
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

    public Researcher acceptNomination(String nominationID) throws EntityNotFoundException, IdConflictException {
        checkNominationId(nominationID);

        if(researchersRepository.existsById(nominationID)) throw new IdConflictException("Email già presente nel sistema");

        Nomination nomination = nominationsRepository.findById(nominationID).get();
        nomination.acceptNomination();
        nominationsRepository.save(nomination);

        return researchersRepository.save(new Researcher(nomination.getEmail(), nomination.getPassword(), UserRole.RESEARCHER.getGrantedAuthorities(), nomination.getName()));
    }

    public void rejectNomination(String nominationID) throws EntityNotFoundException {
        checkNominationId(nominationID);

        Nomination nomination = nominationsRepository.findById(nominationID).get();
        nomination.rejectNomination();
        nominationsRepository.save(nomination);
    }

    private void checkNominationId(String nominationID) throws EntityNotFoundException {
        if (nominationID.isBlank()) throw new IllegalArgumentException("Il campo nominationId è vuoto");
        if (nominationsRepository.findById(nominationID).isEmpty())
            throw new EntityNotFoundException("nomination not Exist");
        if (!nominationsRepository.findById(nominationID).get().isPendente())
            throw new IllegalStateException("lo status della nomination è già determinato");
    }


    public Set<Nomination> getNominationPendenti(){
        return nominationsRepository.findAll().stream().filter(Nomination::isPendente).collect(Collectors.toSet());
    }
}
