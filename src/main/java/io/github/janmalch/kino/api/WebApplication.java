package io.github.janmalch.kino.api;

import io.github.janmalch.kino.api.boundary.*;
import io.github.janmalch.kino.security.AuthorizationFilter;
import io.github.janmalch.kino.security.RefreshTokenResponseFilter;
import jakarta.ws.rs.ApplicationPath;
import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.server.filter.RolesAllowedDynamicFeature;

@ApplicationPath("api")
public class WebApplication extends ResourceConfig {

  public WebApplication() {
    register(AccountResource.class);
    register(AuthResource.class);
    register(AuthorizationFilter.class);
    register(RefreshTokenResponseFilter.class);
    register(CinemaHallResource.class);
    register(MovieResource.class);
    register(MyAccountResource.class);
    register(PresentationResource.class);
    register(PriceCategoryResource.class);
    register(PingResource.class);
    register(RolesAllowedDynamicFeature.class);
    register(ValidationExceptionMapper.class);
    register(new CORSFilter());
  }
}
