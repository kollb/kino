package io.github.janmalch.kino.api.boundary;

import io.github.janmalch.kino.api.model.PingDto;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Path("ping")
@Tag(name = "ping")
public class PingResource {

  private Logger log = LoggerFactory.getLogger(PingResource.class);

  @GET
  @Produces(MediaType.APPLICATION_JSON)
  public PingDto ping() {
    log.info("new ping received");
    return new PingDto();
  }
}
