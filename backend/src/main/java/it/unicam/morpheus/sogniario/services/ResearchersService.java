package it.unicam.morpheus.sogniario.services;

import it.unicam.morpheus.sogniario.checker.ResearcherChecker;
import it.unicam.morpheus.sogniario.exception.EntityNotFoundException;
import it.unicam.morpheus.sogniario.exception.IdConflictException;
import it.unicam.morpheus.sogniario.model.Researcher;
import it.unicam.morpheus.sogniario.repositories.ResearchersRepository;
import it.unicam.morpheus.sogniario.security.UserRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

/**
 * The interface extends {@link EntityService} and adds operations to better manage instances of the {@link Researcher} class.
 */
@Service
public class ResearchersService implements EntityService<Researcher, String>{

    private final ResearchersRepository researchersRepository;
    private final ResearcherChecker researcherChecker;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public ResearchersService(ResearchersRepository researchersRepository, ResearcherChecker researcherChecker, PasswordEncoder passwordEncoder) {
        this.researchersRepository = researchersRepository;
        this.researcherChecker = researcherChecker;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public Researcher getInstance(String id) throws EntityNotFoundException {
        return researchersRepository.findById(id).orElseThrow(()->
                new EntityNotFoundException("Nessun Researcher trovato con l'ID: "+id));
    }

    @Override
    public Researcher create(Researcher object) throws EntityNotFoundException, IdConflictException {
        // TODO: 03/05/21 da togliere in caso
        return null;
    }

    public Researcher create(Researcher object, boolean isAdmin) throws EntityNotFoundException, IdConflictException {
        if(exists(object.getUsername())) throw new IdConflictException("Email già presente");

        researcherChecker.check(object);

        return researchersRepository.save(
                new Researcher(
                        object.getUsername(),
                        passwordEncoder.encode(object.getPassword()),
                        (isAdmin) ? UserRole.ADMIN.getGrantedAuthorities() : UserRole.RESEARCHER.getGrantedAuthorities(),
                        object.getName()
                )
        );
    }

    @Override
    public Researcher update(Researcher object) throws EntityNotFoundException, IdConflictException {
        if(!exists(object.getUsername()))
            throw new EntityNotFoundException("Nessun Researcher con email: "+ object.getUsername());
        researcherChecker.check(object);
        return researchersRepository.save(object);
    }

    @Override
    public boolean delete(String id) {
        // TODO: 02/04/2021 implementare
        return false;
    }

    @Override
    public boolean exists(String id) {
        if(id.isBlank()) throw new IllegalArgumentException("Il campo 'Email' è vuoto");
        return researchersRepository.existsById(id);
    }

    @Override
    public Page<Researcher> getPage(int page, int size) throws EntityNotFoundException {
        return researchersRepository.findAll(PageRequest.of(page, size));
    }
}

