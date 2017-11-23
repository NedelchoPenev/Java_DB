package bookshopSystem.repositories;

import bookshopSystem.models.Author;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface AuthorRepository extends JpaRepository<Author, Long> {

    Iterable<Author> findByFirstNameEndingWith(String suffix);

    @Query(value = "SELECT copies_count.id, copies_count.first_name, copies_count.last_name FROM \n" +
            "(SELECT a.id, a.first_name, a.last_name, sum(b.copies) AS total FROM authors AS a\n" +
            "INNER JOIN books AS b ON a.id = b.author_id\n" +
            "GROUP BY a.id ORDER BY total DESC) AS copies_count", nativeQuery = true)
    Iterable<Author> countBookCopiesByAuthor();

    @Procedure(name = "total_number_of_books_that_author_has_written")
    int booksAuthorWritten(@Param("first_name") String firstName, @Param("last_name") String lastName);
}
