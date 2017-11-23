package bookshopSystem.services;

import bookshopSystem.models.Book;
import bookshopSystem.repositories.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import java.util.Calendar;
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
    public Iterable<Book> byAuthorNameOrdered() {
        return this.bookRepository.findBooksByAuthorFirstNameAndAuthorLastNameOrderByReleaseDateDescTitleAsc("George","Powell");
    }

    @Override
    public Iterable<Book> byYearAfter2000() {
        Calendar calendar = Calendar.getInstance();
        calendar.set(2000, 1, 1);
        Date date = calendar.getTime();
        return this.bookRepository.findByReleaseDateAfter(date);
    }

    @Override
    public void save(Book book) {
        bookRepository.save(book);
    }
}
