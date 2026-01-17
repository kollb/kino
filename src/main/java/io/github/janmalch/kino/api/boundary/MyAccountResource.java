package io.github.janmalch.kino.api.boundary;

import io.github.janmalch.kino.api.ResponseResultBuilder;
import io.github.janmalch.kino.api.model.account.SignUpDto;
import io.github.janmalch.kino.control.myaccount.DeleteMyAccountControl;
import io.github.janmalch.kino.control.myaccount.EditMyAccountControl;
import io.github.janmalch.kino.control.myaccount.GetMyAccountControl;
import io.github.janmalch.kino.security.Secured;
import io.github.janmalch.kino.security.Token;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.security.RolesAllowed;
import jakarta.validation.Valid;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.SecurityContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Path("my-account")
@Tag(name = "my-account")
public class MyAccountResource {
  private Logger log = LoggerFactory.getLogger(AccountResource.class);

  @Secured
  @RolesAllowed("CUSTOMER")
  @GET
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Returns own profile")
  public Response getMyAccount(@Context SecurityContext securityContext) {
    log.info("------------------ BEGIN GET MY-ACCOUNT REQUEST ------------------");

    var myAccountToken = securityContext.getUserPrincipal();

    GetMyAccountControl control = new GetMyAccountControl(myAccountToken.getName());

    return control.execute(new ResponseResultBuilder<>());
  }

  @Secured
  @RolesAllowed("CUSTOMER")
  @PUT
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Updates own profile")
  public Response editMyAccount(@Valid SignUpDto data, @Context SecurityContext securityContext) {
    log.info("------------------ BEGIN EDIT MY-ACCOUNT REQUEST ------------------");
    log.info(data.toString());
    var myAccountToken = securityContext.getUserPrincipal();

    EditMyAccountControl control = new EditMyAccountControl((Token) myAccountToken, data);
    return control.execute(new AuthResource.JwtResultBuilder());
  }

  @Secured
  @RolesAllowed("CUSTOMER")
  @DELETE
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Deletes own profile and returns an invalid Cookie")
  public Response deleteMyAccount(@Context SecurityContext securityContext) {
    log.info("------------------ BEGIN DELETE MY-ACCOUNT REQUEST ------------------");
    var myAccountToken = securityContext.getUserPrincipal();

    DeleteMyAccountControl control = new DeleteMyAccountControl((Token) myAccountToken);

    return control.execute(new AuthResource.JwtResultBuilder());
  }
}
