package userSystem.validators;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class EmailValidator implements ConstraintValidator<Email, String> {

    @Override
    public void initialize(Email constraintAnnotation) {

    }

    @Override
    public boolean isValid(String email, ConstraintValidatorContext context) {
        return email.matches("^[A-Za-z][A-Za-z.-_]*[A-Za-z]@\\w+\\..+[A-Za-z]$");
    }
}
