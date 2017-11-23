package bookshopSystem.services.impl;

import bookshopSystem.models.Author;
import bookshopSystem.repositories.AuthorRepository;
import bookshopSystem.services.api.AuthorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

@Service
@Primary
public class AuthorServiceImpl implements AuthorService {

    private AuthorRepository authorRepository;

    @Autowired
    public AuthorServiceImpl(AuthorRepository authorRepository) {
        this.authorRepository = authorRepository;
    }

    @Override
    public Iterable<Author> findByFirstNameEndingWith(String suffix) {
        return this.authorRepository.findByFirstNameEndingWith(suffix);
    }

    @Override
    public Iterable<Author> countBookCopiesByAuthor() {
        return this.authorRepository.countBookCopiesByAuthor();
    }

    @Override
    public int booksAuthorWritten(String firstName, String lastName) {
        return this.authorRepository.booksAuthorWritten(firstName, lastName);
    }
}
