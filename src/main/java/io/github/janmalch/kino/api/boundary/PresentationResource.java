package io.github.janmalch.kino.api.boundary;

import io.github.janmalch.kino.api.ResponseResultBuilder;
import io.github.janmalch.kino.api.model.presentation.NewPresentationDto;
import io.github.janmalch.kino.control.generic.*;
import io.github.janmalch.kino.control.presentation.NewPresentationDtoMapper;
import io.github.janmalch.kino.control.presentation.PresentationWithSeatsDtoMapper;
import io.github.janmalch.kino.entity.Presentation;
import io.github.janmalch.kino.security.Secured;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.security.RolesAllowed;
import jakarta.validation.Valid;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

@Tag(name = "presentation")
@Path("presentation")
public class PresentationResource {

  @Path("{id}")
  @GET
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Returns presentation for given ID")
  public Response getPresentation(@PathParam("id") long id) {
    var control =
        new GetEntityControl<>(id, Presentation.class, new PresentationWithSeatsDtoMapper());
    return control.execute(new ResponseResultBuilder<>());
  }

  @GET
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Returns all presentations")
  public Response getAllPresentations() {
    var control =
        new GetEntitiesControl<>(Presentation.class, new PresentationWithSeatsDtoMapper());
    return control.execute(new ResponseResultBuilder<>());
  }

  @POST
  @Secured
  @RolesAllowed("MODERATOR")
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Creates a new presentation")
  public Response newPresentation(@Valid NewPresentationDto dto) {
    var control = new NewEntityControl<>(dto, Presentation.class, new NewPresentationDtoMapper());
    return control.execute(new ResponseResultBuilder<>());
  }

  @Path("{id}")
  @PUT
  @Secured
  @RolesAllowed("MODERATOR")
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Updates the presentation for the given ID")
  public Response updatePresentation(@Valid NewPresentationDto dto, @PathParam("id") long id) {
    var control =
        new UpdateEntityControl<>(id, dto, Presentation.class, new NewPresentationDtoMapper());
    return control.execute(new ResponseResultBuilder<>());
  }

  @Path("{id}")
  @DELETE
  @Secured
  @RolesAllowed("MODERATOR")
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Deletes the presentation for the given ID")
  public Response deletePresentation(@PathParam("id") long id) {
    var control = new DeleteEntityControl<>(id, Presentation.class);
    return control.execute(new ResponseResultBuilder<>());
  }
}
