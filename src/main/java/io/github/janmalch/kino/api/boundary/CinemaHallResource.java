package io.github.janmalch.kino.api.boundary;

import io.github.janmalch.kino.api.ResponseResultBuilder;
import io.github.janmalch.kino.api.model.cinemahall.NewCinemaHallDto;
import io.github.janmalch.kino.control.cinemahall.CinemaHallDtoMapper;
import io.github.janmalch.kino.control.cinemahall.NewCinemaHallControl;
import io.github.janmalch.kino.control.generic.DeleteEntityControl;
import io.github.janmalch.kino.control.generic.GetEntitiesControl;
import io.github.janmalch.kino.entity.CinemaHall;
import io.github.janmalch.kino.security.Secured;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.security.RolesAllowed;
import jakarta.validation.Valid;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

@Tag(name = "cinema-hall")
@Path("cinema-hall")
public class CinemaHallResource {

  @GET
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Returns all cinema halls")
  public Response getAllCinemaHalls() {
    var control = new GetEntitiesControl<>(CinemaHall.class, new CinemaHallDtoMapper());
    return control.execute(new ResponseResultBuilder<>());
  }

  @POST
  @Secured
  @RolesAllowed("MODERATOR")
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Adds a new price category")
  public Response createCinemaHall(@Valid NewCinemaHallDto dto) {
    var control = new NewCinemaHallControl(dto);
    return control.execute(new ResponseResultBuilder<>());
  }

  @Path("{id}")
  @DELETE
  @Secured
  @RolesAllowed("MODERATOR")
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Deletes a single cinema hall")
  public Response deleteCinemaHall(@PathParam("id") long id) {
    var control = new DeleteEntityControl<>(id, CinemaHall.class);
    return control.execute(new ResponseResultBuilder<>());
  }
}
