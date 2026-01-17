package io.github.janmalch.kino.api.boundary;

import io.github.janmalch.kino.api.ResponseResultBuilder;
import io.github.janmalch.kino.api.model.movie.MovieDto;
import io.github.janmalch.kino.api.model.movie.NewMovieDto;
import io.github.janmalch.kino.control.Control;
import io.github.janmalch.kino.control.generic.GetEntitiesControl;
import io.github.janmalch.kino.control.generic.GetEntityControl;
import io.github.janmalch.kino.control.movie.*;
import io.github.janmalch.kino.entity.Movie;
import io.github.janmalch.kino.security.Secured;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.security.RolesAllowed;
import jakarta.validation.Valid;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Path("movie")
@Tag(name = "movie")
public class MovieResource {

  private Logger log = LoggerFactory.getLogger(MovieResource.class);

  @GET
  @Secured
  @RolesAllowed("MODERATOR")
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Returns the list of all movies")
  public Response getAllMovies() {
    var control = new GetEntitiesControl<>(Movie.class, new MovieDtoMapper());
    return control.execute(new ResponseResultBuilder<>());
  }

  @POST
  @Secured
  @RolesAllowed("MODERATOR")
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Returns the ID for the newly created movie")
  public Response newMovie(@Valid NewMovieDto movieDto) {
    log.info(movieDto.toString());
    Control<Long> control = new NewMovieControl(movieDto);
    return control.execute(new ResponseResultBuilder<>());
  }

  @Path("{id}")
  @DELETE
  @Secured
  @RolesAllowed("MODERATOR")
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Deletes the movie for the given ID")
  public Response deleteMovie(@PathParam("id") long id) {
    var control = new RemoveMovieControl(id);
    return control.execute(new ResponseResultBuilder<>());
  }

  @Path("{id}")
  @GET
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Retrieves the movie for the given ID")
  public Response getMovie(@PathParam("id") long id) {
    var control = new GetEntityControl<>(id, Movie.class, new MovieDtoMapper());
    return control.execute(new ResponseResultBuilder<>());
  }

  @Path("{id}")
  @PUT
  @Secured
  @RolesAllowed("MODERATOR")
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Partially updates the movie for the given ID")
  public Response updateMovie(MovieDto movieDto, @PathParam("id") long id) {
    var control = new UpdateMovieControl(movieDto, id);
    return control.execute(new ResponseResultBuilder<>());
  }

  @Path("current")
  @GET
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Returns the list of all running movies")
  public Response getCurrentMovies() {
    var control = new GetCurrentMoviesControl();
    return control.execute(new ResponseResultBuilder<>());
  }
}
