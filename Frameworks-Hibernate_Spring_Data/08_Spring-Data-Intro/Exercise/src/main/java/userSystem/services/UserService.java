package userSystem.services;

import userSystem.models.User;

import java.util.List;

public interface UserService {

    User findByID(Long id);

    void remove(User user);

    List<User> findAll();

    void save(User user);
}
