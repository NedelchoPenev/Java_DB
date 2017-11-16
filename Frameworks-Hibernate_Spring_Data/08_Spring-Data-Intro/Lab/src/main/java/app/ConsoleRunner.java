package app;

import app.models.Account;
import app.models.User;
import app.services.AccountServiceImpl;
import app.services.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;

@SpringBootApplication
@Component
public class ConsoleRunner implements CommandLineRunner {

    private AccountServiceImpl accountService;
    private UserServiceImpl userService;

    @Autowired
    public ConsoleRunner(AccountServiceImpl accountService, UserServiceImpl userService) {
        this.accountService = accountService;
        this.userService = userService;
    }

    @Override
    public void run(String... strings) throws Exception {
        User example = new User();
        example.setUsername("example");
        example.setAge(20);

        Account account = new Account();
        account.setBalance(new BigDecimal(25000));
        account.setUser(example);

        example.getAccounts().add(account);

        userService.registerUser(example);

        accountService.withdrawMoney(new BigDecimal(20000), 1L);
        accountService.transferMoney(new BigDecimal(20000), 2L);
    }
}
