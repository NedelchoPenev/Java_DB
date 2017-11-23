package bookshopSystem.services.api;

import bookshopSystem.models.Author;

public interface AuthorService {

    Iterable<Author> findByFirstNameEndingWith(String suffix);

    Iterable<Author> countBookCopiesByAuthor();

    int booksAuthorWritten(String firstName, String lastName);
}
