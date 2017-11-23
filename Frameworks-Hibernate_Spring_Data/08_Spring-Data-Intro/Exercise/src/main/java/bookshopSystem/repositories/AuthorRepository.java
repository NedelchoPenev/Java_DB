package bookshopSystem.repositories;

import bookshopSystem.models.Author;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface AuthorRepository extends JpaRepository<Author, Long> {
    @Query(value = "SELECT DISTINCT a.id, a.first_name, a.last_name " +
            "FROM authors AS a " +
            "INNER JOIN books AS b ON b.author_id = a.id " +
            "WHERE YEAR(b.release_date) < 1990", nativeQuery = true)
    Iterable<Author> findAllAuthorsWhereReleaseDateBefore1990();

    @Query(value = "SELECT authors.id, authors.first_name, authors.last_name FROM\n" +
            "(SELECT a.id, a.first_name, a.last_name, count(b.author_id) " +
            "as book_count " +
            "FROM authors AS a\n" +
            "INNER JOIN books AS b ON a.id = b.author_id\n" +
            "GROUP BY b.author_id\n" +
            "ORDER BY book_count DESC) AS authors", nativeQuery = true)
    Iterable<Author> findAllAuthorsOrderByBooks();
}
