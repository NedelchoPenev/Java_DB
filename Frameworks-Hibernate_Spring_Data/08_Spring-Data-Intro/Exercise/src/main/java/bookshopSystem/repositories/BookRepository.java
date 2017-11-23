package bookshopSystem.repositories;

import bookshopSystem.models.Book;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Date;

@Repository
public interface BookRepository extends CrudRepository<Book, Long>{
    Iterable<Book> findByReleaseDateAfter(Date date);

    Iterable<Book> findBooksByAuthorFirstNameAndAuthorLastNameOrderByReleaseDateDescTitleAsc(String authorFirstName, String authorLastName);
}
