package it.unicam.morpheus.sogniario.security;

import com.google.common.collect.Sets;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.util.Set;
import java.util.stream.Collectors;

import static it.unicam.morpheus.sogniario.security.UserPermission.*;

/**
 * The enumeration is responsible for managing the roles within the system.
 * Each role is assigned one or more permissions defined within the {@link UserPermission} enumeration.
 */
public enum UserRole {

    ADMIN(Sets.newHashSet(
            SURVEYS_READ, SURVEYS_WRITE,
            REPORTS_READ, REPORTS_WRITE,
            NOMINATIONS_READ, NOMINATIONS_WRITE,
            RESEARCHERS_READ, RESEARCHERS_WRITE,
            DREAMERS_READ, DREAMERS_WRITE, DREAMERS_CREATE
    )),
    RESEARCHER(Sets.newHashSet(
            SURVEYS_READ,
            REPORTS_READ,
            RESEARCHERS_READ
    )),
    DREAMER(Sets.newHashSet(
            SURVEYS_READ,
            REPORTS_READ, REPORTS_WRITE,
            DREAMERS_READ, DREAMERS_WRITE
    )),
    GUEST_DREAMER(Sets.newHashSet(
            DREAMERS_CREATE
    )),
    GUEST_RESEARCHER(Sets.newHashSet(
            NOMINATIONS_READ, NOMINATIONS_WRITE
    ));

    private final Set<UserPermission> permissions;

    UserRole(Set<UserPermission> permissions) {
        this.permissions = permissions;
    }

    public Set<UserPermission> getPermissions() {
        return permissions;
    }

    public Set<SimpleGrantedAuthority> getGrantedAuthorities() {
        Set<SimpleGrantedAuthority> permissions = getPermissions().stream()
                .map(permission -> new SimpleGrantedAuthority(permission.getPermission()))
                .collect(Collectors.toSet());
        permissions.add(new SimpleGrantedAuthority("ROLE_" + this.name()));
        return permissions;
    }
}

