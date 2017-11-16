package app.services;

import app.models.Account;
import app.models.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import app.repositories.AccountRepository;

import java.math.BigDecimal;

@Service
@Primary
public class AccountServiceImpl implements AccountService {

    private AccountRepository accountRepository;

    @Autowired
    public AccountServiceImpl(AccountRepository accountRepository) {
        this.accountRepository = accountRepository;
    }

    @Override
    public void withdrawMoney(BigDecimal money, Long id) {
        Account searchedAccount = accountRepository.findOne(id);
        User userOfAccount = searchedAccount.getUser();
        BigDecimal balance = searchedAccount.getBalance();
        if (userOfAccount != null && balance.compareTo(money) > 0 &&
                money.compareTo(BigDecimal.ZERO) > 0) {
            searchedAccount.setBalance(balance.subtract(money));
            accountRepository.save(searchedAccount);
        }

    }

    @Override
    public void transferMoney(BigDecimal money, Long id) {
        Account searchedAccount = accountRepository.findOne(id);
        User userOfAccount = searchedAccount.getUser();
        BigDecimal balance = searchedAccount.getBalance();
        if (userOfAccount != null && money.compareTo(BigDecimal.ZERO) > 0){
            searchedAccount.setBalance(balance.add(money));
            accountRepository.save(searchedAccount);
        }

    }
}
