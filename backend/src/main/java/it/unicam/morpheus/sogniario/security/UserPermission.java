package it.unicam.morpheus.sogniario.security;

/**
 * The enumeration has the task of managing the permissions within the system.
 */
public enum UserPermission {

    //API researchers
    RESEARCHERS_READ("researchers:read"),
    RESEARCHERS_WRITE("researchers:write"),

    //API nominations
    NOMINATIONS_READ("nominations:read"),
    NOMINATIONS_WRITE("nominations:write"),

    //API dreamers
    DREAMERS_READ("dreamers:read"),
    DREAMERS_WRITE("dreamers:write"),
    DREAMERS_CREATE("dreamers:create"),

    //API reports
    REPORTS_READ("reports:read"),
    REPORTS_WRITE("reports:write"),

    //API surveys
    SURVEYS_READ("surveys:read"),
    SURVEYS_WRITE("surveys:write");

    private final String permission;

    UserPermission(String permission) {
        this.permission = permission;
    }

    public String getPermission() {
        return permission;
    }
}
