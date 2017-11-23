package bookshopSystem.services;

import bookshopSystem.models.Author;

public interface AuthorService {

    Iterable<Author> getAllWithBooksBefore1990();

    Iterable<Author> authorsOrderByBooks();

    void save(Author author);
}
