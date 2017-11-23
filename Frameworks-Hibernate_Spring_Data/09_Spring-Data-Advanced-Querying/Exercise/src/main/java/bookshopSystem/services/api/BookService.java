package bookshopSystem.services.api;

import bookshopSystem.enums.AgeRestriction;
import bookshopSystem.models.Book;
import bookshopSystem.models.ReducedBook;

import java.util.Date;

public interface BookService {
    Iterable<Book> findByAgeRestriction(AgeRestriction ageRestriction);

    Iterable<Book> findByEditionTypeAndCopiesLessThan();

    Iterable<Book> findByPriceNotBetween();

    Iterable<Book> findByReleaseDateNot(int date);

    Iterable<Book> findByReleaseDateBefore(Date date);

    Iterable<Book> findByTitleContaining(String string);

    Iterable<Book> findByAuthorLastNameStartingWith(String prefix);

    long countByTitleLength(int longerThan);

    ReducedBook findByTitle(String title);

    int increaseBookCopies(int increaseCopies, Date date);

    int deleteBooksWithLessCopiesThan(int copies);
}
