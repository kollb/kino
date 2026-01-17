package io.github.janmalch.kino.api.boundary;

import io.github.janmalch.kino.api.ResponseResultBuilder;
import io.github.janmalch.kino.api.model.pricecategory.PriceCategoryBaseDto;
import io.github.janmalch.kino.api.model.pricecategory.PriceCategoryDto;
import io.github.janmalch.kino.control.generic.*;
import io.github.janmalch.kino.entity.PriceCategory;
import io.github.janmalch.kino.security.Secured;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.security.RolesAllowed;
import jakarta.validation.Valid;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

@Path("price")
@Tag(name = "price")
public class PriceCategoryResource {

  @GET
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Retrieves all price categories")
  public Response getAllPriceCategories() {
    var control = new GetEntitiesControl<>(PriceCategory.class, PriceCategoryDto.class);
    return control.execute(new ResponseResultBuilder<>());
  }

  @Path("{id}")
  @GET
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Retrieves all price categories")
  public Response getPriceCategory(@PathParam("id") long id) {
    var control = new GetEntityControl<>(id, PriceCategory.class, PriceCategoryDto.class);
    return control.execute(new ResponseResultBuilder<>());
  }

  @POST
  @Secured
  @RolesAllowed("MODERATOR")
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Adds a new price category")
  public Response createPriceCategory(@Valid PriceCategoryBaseDto dto) {
    var control = new NewEntityControl<>(dto, PriceCategory.class);
    return control.execute(new ResponseResultBuilder<>());
  }

  @Path("{id}")
  @PUT
  @Secured
  @RolesAllowed("MODERATOR")
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Updates the given price category")
  public Response updatePriceCategory(@Valid PriceCategoryDto dto, @PathParam("id") long id) {
    var control = new UpdateEntityControl<>(id, dto, PriceCategory.class);
    return control.execute(new ResponseResultBuilder<>());
  }

  @Path("{id}")
  @DELETE
  @Secured
  @RolesAllowed("MODERATOR")
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Deletes the given price category")
  public Response deletePriceCategory(@PathParam("id") long id) {
    var control = new DeleteEntityControl<>(id, PriceCategory.class);
    return control.execute(new ResponseResultBuilder<>());
  }
}
