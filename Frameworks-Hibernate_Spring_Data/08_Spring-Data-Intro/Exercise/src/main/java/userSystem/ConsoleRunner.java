package userSystem;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Component;
import userSystem.services.UserService;

@SpringBootApplication
@Component
public class ConsoleRunner implements CommandLineRunner {

    @Autowired
    private UserService userService;

    public ConsoleRunner(UserService userService) {
        this.userService = userService;
    }

    @Override
    public void run(String... strings) throws Exception {

    }
}
