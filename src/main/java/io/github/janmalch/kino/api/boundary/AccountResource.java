package io.github.janmalch.kino.api.boundary;

import io.github.janmalch.kino.api.ResponseResultBuilder;
import io.github.janmalch.kino.api.model.account.AccountInfoDto;
import io.github.janmalch.kino.api.model.account.SignUpDto;
import io.github.janmalch.kino.control.account.*;
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

@Path("account")
@Tag(name = "account")
public class AccountResource {

  private Logger log = LoggerFactory.getLogger(AccountResource.class);

  @POST
  @Path("sign-up")
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  public Response signUp(@Valid SignUpDto data) {
    log.info("------------------ BEGIN SIGN UP REQUEST ------------------");
    log.info(data.toString());
    var control = new SignUpControl(data);
    Response response = control.execute(new ResponseResultBuilder<>());
    log.info("sending response\n\t" + response.getEntity());
    return response;
  }

  @Path("{id}")
  @Secured
  @RolesAllowed("MODERATOR")
  @GET
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Retrieves the account for the given ID")
  public Response getAccountById(@PathParam("id") long id) {
    log.info("------------------ BEGIN GET ACCOUNT BY ID REQUEST ------------------");
    GetAccountByIdControl control = new GetAccountByIdControl(id);
    return control.execute(new ResponseResultBuilder<>());
  }

  @Secured
  @RolesAllowed("MODERATOR")
  @GET
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Retrieves all accounts")
  public Response getAllAccounts() {
    log.info("------------------ BEGIN GET ALL ACCOUNTS ------------------");
    GetAllAccountsControl control = new GetAllAccountsControl();
    return control.execute(new ResponseResultBuilder<>());
  }

  @Path("{id}")
  @Secured
  @RolesAllowed("ADMIN")
  @DELETE
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Deletes an account")
  public Response deleteAccount(@PathParam("id") long id) {
    log.info("------------------ BEGIN DELETE ACCOUNT BY ID REQUEST ------------------");
    DeleteAccountByIdControl control = new DeleteAccountByIdControl(id);
    return control.execute(new ResponseResultBuilder<>());
  }

  @Path("{id}")
  @Secured
  @RolesAllowed("ADMIN")
  @PUT
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Edit an account")
  public Response editAccountById(@PathParam("id") long id, AccountInfoDto data) {
    log.info("------------------ BEGIN EDIT ACCOUNT BY ID REQUEST ------------------");
    EditAccountById control = new EditAccountById(data);
    return control.execute(new ResponseResultBuilder<>());
  }
}
