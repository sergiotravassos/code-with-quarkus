package org.acme;

import jakarta.ws.rs.container.ContainerRequestContext;
import jakarta.ws.rs.ext.Provider;
import org.jboss.logging.Logger;
import org.jboss.resteasy.reactive.server.ServerRequestFilter;

@Provider
public class LoggingFilter {

    private static final Logger LOG = Logger.getLogger(LoggingFilter.class);

    @ServerRequestFilter
    public void filter(ContainerRequestContext requestContext) {
        LOG.info("Request received: " + requestContext.getMethod() + " " + requestContext.getUriInfo().getRequestUri());
    }
}
