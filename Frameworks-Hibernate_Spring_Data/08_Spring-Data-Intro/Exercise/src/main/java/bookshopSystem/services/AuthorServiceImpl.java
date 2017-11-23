package bookshopSystem.services;

import bookshopSystem.models.Author;
import bookshopSystem.repositories.AuthorRepository;
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
    public Iterable<Author> getAllWithBooksBefore1990() {
        return this.authorRepository.findAllAuthorsWhereReleaseDateBefore1990();
    }

    @Override
    public Iterable<Author> authorsOrderByBooks() {
        return this.authorRepository.findAllAuthorsOrderByBooks();
    }

    @Override
    public void save(Author author) {
        authorRepository.save(author);
    }
}
