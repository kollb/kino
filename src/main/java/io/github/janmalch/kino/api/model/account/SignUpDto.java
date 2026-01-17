package io.github.janmalch.kino.api.model.account;

import jakarta.json.bind.annotation.JsonbDateFormat;
import java.time.LocalDate;

public class SignUpDto extends AbstractAccountDto {

  private String password;

  @JsonbDateFormat(value = "yyyy-MM-dd", locale = "de-DE")
  private LocalDate birthday;

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public LocalDate getBirthday() {
    return birthday;
  }

  public void setBirthday(LocalDate birthday) {
    this.birthday = birthday;
  }

  @Override
  public String toString() {
    return "SignUpDto{"
        + "firstName='"
        + firstName
        + '\''
        + ", lastName='"
        + lastName
        + '\''
        + ", password='"
        + password
        + '\''
        + ", email='"
        + email
        + '\''
        + ", birthday="
        + birthday
        + '}';
  }
}
