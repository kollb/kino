package io.github.janmalch.kino.api.boundary;

import io.github.janmalch.kino.api.ResponseResultBuilder;
import io.github.janmalch.kino.api.model.auth.LoginDto;
import io.github.janmalch.kino.api.model.auth.TokenDto;
import io.github.janmalch.kino.control.Control;
import io.github.janmalch.kino.control.auth.LogInControl;
import io.github.janmalch.kino.control.auth.LogOutControl;
import io.github.janmalch.kino.security.Secured;
import io.github.janmalch.kino.security.Token;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.security.RolesAllowed;
import jakarta.validation.Valid;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.SecurityContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Tag(name = "auth")
@Path("")
public class AuthResource {

  private Logger log = LoggerFactory.getLogger(AuthResource.class);

  @Path("login")
  @POST
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Returns a new JWT token if credentials are valid")
  public Response logIn(@Valid LoginDto loginDto) {
    log.info("------------------ BEGIN LOGIN REQUEST ------------------");
    log.info(loginDto.toString());

    Control<Token> control = new LogInControl(loginDto);
    return control.execute(new JwtResultBuilder());
  }

  @Path("logout")
  @Secured
  @RolesAllowed("CUSTOMER")
  @POST
  @Produces(MediaType.APPLICATION_JSON)
  @Operation(summary = "Returns an invalid JWT token when successfully logged out")
  public Response logOut(@Context SecurityContext securityContext) {
    log.info("------------------ BEGIN LOGOUT REQUEST ------------------");

    var logoutToken = securityContext.getUserPrincipal();

    LogOutControl control = new LogOutControl((Token) logoutToken);

    return control.execute(new JwtResultBuilder());
  }

  static class JwtResultBuilder extends ResponseResultBuilder<Token> {
    @Override
    public Response success(Token payload) {
      var dto = new TokenDto();
      dto.setToken(payload.getTokenString());
      return Response.ok(dto).build();
    }
  }
}
