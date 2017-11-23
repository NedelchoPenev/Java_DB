package bookshopSystem.services.impl;

import bookshopSystem.enums.AgeRestriction;
import bookshopSystem.enums.EditionType;
import bookshopSystem.models.Book;
import bookshopSystem.models.ReducedBook;
import bookshopSystem.repositories.BookRepository;
import bookshopSystem.services.api.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;

@Service
@Primary
public class BookServiceImpl implements BookService {

    private BookRepository bookRepository;

    @Autowired
    public BookServiceImpl(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    @Override
    public Iterable<Book> findByAgeRestriction(AgeRestriction ageRestriction) {
        return this.bookRepository.findByAgeRestriction(ageRestriction);
    }

    @Override
    public Iterable<Book> findByEditionTypeAndCopiesLessThan() {
        EditionType gold = EditionType.GOLD;
        int copies = 5000;

        return this.bookRepository.findByEditionTypeAndCopiesLessThan(gold, copies);
    }

    @Override
    public Iterable<Book> findByPriceNotBetween() {
        BigDecimal lower = new BigDecimal(5);
        BigDecimal higher = new BigDecimal(40);
        return this.bookRepository.findByPriceLessThanOrPriceGreaterThan(lower, higher);
    }

    @Override
    public Iterable<Book> findByReleaseDateNot(int year) {
        return this.bookRepository.findByReleaseDateNot(year);
    }

    @Override
    public Iterable<Book> findByReleaseDateBefore(Date date) {
        return this.bookRepository.findByReleaseDateBefore(date);
    }

    @Override
    public Iterable<Book> findByTitleContaining(String string) {
        return this.bookRepository.findByTitleContaining(string);
    }

    @Override
    public Iterable<Book> findByAuthorLastNameStartingWith(String prefix) {
        return this.bookRepository.findByAuthorLastNameStartingWith(prefix);
    }

    @Override
    public long countByTitleLength(int longerThan) {
        return this.bookRepository.countByTitleLength(longerThan);
    }

    @Override
    public ReducedBook findByTitle(String title) {
        return this.bookRepository.findByTitle(title);
    }

    @Override
    public int increaseBookCopies(int increaseCopies, Date date) {
        return this.bookRepository.increaseBookCopies(increaseCopies, date);
    }

    @Override
    public int deleteBooksWithLessCopiesThan(int copies) {
        return this.bookRepository.deleteBooksWithLessCopiesThan(copies);
    }
}
