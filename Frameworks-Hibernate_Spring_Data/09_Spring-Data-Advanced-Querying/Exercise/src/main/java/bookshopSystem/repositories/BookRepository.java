package bookshopSystem.repositories;

import bookshopSystem.enums.AgeRestriction;
import bookshopSystem.enums.EditionType;
import bookshopSystem.models.Book;
import bookshopSystem.models.ReducedBook;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;

@Repository
public interface BookRepository extends CrudRepository<Book, Long>{

    Iterable<Book> findByAgeRestriction(AgeRestriction ageRestriction);

    Iterable<Book> findByEditionTypeAndCopiesLessThan(EditionType editionType, int copies);

    Iterable<Book> findByPriceLessThanOrPriceGreaterThan(BigDecimal lower, BigDecimal higher);

    @Query("SELECT b FROM Book AS b WHERE year(b.releaseDate) IS NOT :year")
    Iterable<Book> findByReleaseDateNot(@Param("year") int date);

    Iterable<Book> findByReleaseDateBefore(Date date);

    Iterable<Book> findByTitleContaining(String string);

    Iterable<Book> findByAuthorLastNameStartingWith(String prefix);

    @Query("SELECT count(*) FROM Book AS b WHERE length(b.title) > :longerThan")
    long countByTitleLength(@Param("longerThan") int longerThan);

    @Query("SELECT new bookshopSystem.models.ReducedBook(b.title, b.editionType, b.ageRestriction, b.price) FROM Book AS b WHERE b.title = :title")
    ReducedBook findByTitle(@Param("title") String title);

    @Modifying
    @Transactional
    @Query("UPDATE Book AS b SET b.copies = b.copies + :increaseCopies WHERE b.releaseDate > :date")
    int increaseBookCopies(@Param("increaseCopies") int increaseCopies,
                           @Param("date") Date date);

    @Modifying
    @Transactional
    @Query("DELETE FROM Book WHERE copies < :lessCopies")
    int deleteBooksWithLessCopiesThan(@Param("lessCopies") int copies);
}
