package bookshopSystem.services;

import bookshopSystem.models.Book;

public interface BookService {
    Iterable<Book> byAuthorNameOrdered();

    Iterable<Book> byYearAfter2000();

    void save(Book book);
}
