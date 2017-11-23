package bookshopSystem;

import bookshopSystem.enums.AgeRestriction;
import bookshopSystem.enums.EditionType;
import bookshopSystem.models.Author;
import bookshopSystem.models.Book;
import bookshopSystem.models.Category;
import bookshopSystem.services.AuthorService;
import bookshopSystem.services.BookService;
import bookshopSystem.services.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@SpringBootApplication
@Component
public class ConsoleRunner implements CommandLineRunner {

    private AuthorService authorService;
    private BookService bookService;
    private CategoryService categoryService;

    @Autowired
    public ConsoleRunner(AuthorService authorService, BookService bookService, CategoryService categoryService) {
        this.authorService = authorService;
        this.bookService = bookService;
        this.categoryService = categoryService;
    }

    @Override
    public void run(String... strings) throws Exception {
        //seedDatabase();
        //task1();
        //task2();
        //task3();
        //task4();
    }

    private void task3() {
        Iterable<Author> authorsByBooksCount =
                this.authorService.authorsOrderByBooks();
        for (Author author : authorsByBooksCount) {
            System.out.println(author.getFirstName() + " " +
                author.getLastName() + " " +
                author.getBooks().size());
        }
    }

    private void task4() {
        Iterable<Book> booksByAuthor = this.bookService.byAuthorNameOrdered();
        for (Book book : booksByAuthor) {
            System.out.println(book.getTitle() + " " +
                    book.getReleaseDate() + " " +
                    book.getCopies());
        }
    }

    private void task2() {
        Iterable<Author> authorsBookBefore1990 = this.authorService.getAllWithBooksBefore1990();
        for (Author author : authorsBookBefore1990) {
            System.out.println(author.getFirstName() + " " + author.getLastName());
        }
    }

    private void task1() {
        Iterable<Book> booksAfter2000 = this.bookService.byYearAfter2000();
        for (Book book : booksAfter2000) {
            System.out.println(book.getTitle());
        }
    }

    private void seedDatabase() throws IOException, ParseException {
        List<Author> authors = new ArrayList<>();

        BufferedReader authorsReader = new BufferedReader(new FileReader("src/main/resources/authors.txt"));
        String line = authorsReader.readLine();
        while ((line = authorsReader.readLine()) != null) {
            String[] data = line.split("\\s+");
            String firstName = data[0];
            String lastName = data[1];

            Author author = new Author();
            author.setFirstName(firstName);
            author.setLastName(lastName);

            authors.add(author);

            authorService.save(author);
        }

        List<Category> categories = new ArrayList<>();

        BufferedReader categoriesReader = new BufferedReader(new FileReader("src/main/resources/categories.txt"));
        while ((line = categoriesReader.readLine()) != null) {
            if (!line.equals("")) {
                Category category = new Category();
                category.setName(line);

                categories.add(category);

                categoryService.save(category);
            }
        }

        Random random = new Random();

        BufferedReader booksReader = new BufferedReader(new FileReader("src/main/resources/books.txt"));
        line = booksReader.readLine();
        while ((line = booksReader.readLine()) != null) {
            String[] data = line.split("\\s+");

            int authorIndex = random.nextInt(authors.size());
            Author author = authors.get(authorIndex);
            EditionType editionType = EditionType.values()[Integer.parseInt(data[0])];
            SimpleDateFormat formatter = new SimpleDateFormat("d/M/yyyy");
            Date releaseDate = formatter.parse(data[1]);
            int copies = Integer.parseInt(data[2]);
            BigDecimal price = new BigDecimal(data[3]);
            AgeRestriction ageRestriction = AgeRestriction.values()[Integer.parseInt(data[4])];
            StringBuilder titleBuilder = new StringBuilder();
            for (int i = 5; i < data.length; i++) {
                titleBuilder.append(data[i]).append(" ");
            }
            titleBuilder.delete(titleBuilder.lastIndexOf(" "), titleBuilder.lastIndexOf(" "));
            String title = titleBuilder.toString();

            Book book = new Book();
            book.setAuthor(author);
            book.setEditionType(editionType);
            book.setReleaseDate(releaseDate);
            book.setCopies(copies);
            book.setPrice(price);
            book.setAgeRestriction(ageRestriction);
            book.setTitle(title);

            Set<Category> bookCategories = new HashSet<>();

            for (int i = 0; i < random.nextInt(categories.size()); i++) {
                int categoryIndex = random.nextInt(categories.size());
                bookCategories.add(categories.get(categoryIndex));
            }
            book.setCategories(bookCategories);

            bookService.save(book);
        }
    }
}
