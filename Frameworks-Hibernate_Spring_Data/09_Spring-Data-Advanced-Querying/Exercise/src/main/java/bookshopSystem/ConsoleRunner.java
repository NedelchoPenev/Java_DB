package bookshopSystem;

import bookshopSystem.enums.AgeRestriction;
import bookshopSystem.models.Book;
import bookshopSystem.models.ReducedBook;
import bookshopSystem.services.api.AuthorService;
import bookshopSystem.services.api.BookService;
import bookshopSystem.services.api.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Scanner;

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
//        booksTitlesByAgeRestriction();
//        goldenBooks();
//        booksByPrice();
//        notReleasedBooks();
//        booksReleasedBeforeDate();
//        authorsSearch();
//        booksSearch();
//        bookTitlesSearch();
//        countBooks();
//        totalBookCopies();
//        reducedBook();
//        increaseBookCopies();
//        removeBooks();
//        storedProcedure();
    }

    private void storedProcedure() {
        Scanner console = new Scanner(System.in);
        System.out.print("Author names: ");
        String[] names = console.nextLine().trim().split("\\s+");
        int written = this.authorService.booksAuthorWritten(names[0], names[1]);
        System.out.println(written);
    }

    private void removeBooks() {
        Scanner console = new Scanner(System.in);
        System.out.print("Less than: ");
        int lessThan = console.nextInt();
        System.out.println(this.bookService.
                deleteBooksWithLessCopiesThan(lessThan));
    }

    private void increaseBookCopies() throws ParseException {
        Scanner console = new Scanner(System.in);
        System.out.print("Date: ");
        String dateInput = console.nextLine();
        SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy", Locale.US);
        Date date = sdf.parse(dateInput);
        System.out.print("New copies: ");
        int increaseCopies = console.nextInt();
        int increasedBooks = this.bookService
                .increaseBookCopies(increaseCopies, date);
        System.out.println(increaseCopies * increasedBooks);
    }

    private void reducedBook() {
        Scanner console = new Scanner(System.in);
        System.out.print("Title: ");
        String title = console.nextLine().trim();
        ReducedBook reducedBook = this.bookService.findByTitle(title);
        System.out.printf("%s %s %s %s%n",
                reducedBook.getTitle(),
                reducedBook.getEditionType(),
                reducedBook.getAgeRestriction(),
                reducedBook.getPrice());
    }

    private void totalBookCopies() {
        this.authorService.countBookCopiesByAuthor()
                .forEach(a -> System.out.printf("%s %s - %d%n",
                        a.getFirstName(),
                        a.getLastName(),
                        a.getBooks().stream().mapToInt(Book::getCopies).sum()));
    }

    private void countBooks() {
        Scanner console = new Scanner(System.in);
        System.out.print("Number: ");
        int number = Integer.parseInt(console.nextLine());
        System.out.printf("There are %d books with longer title than %d symbols%n",
                this.bookService.countByTitleLength(number),
                number);
    }

    private void bookTitlesSearch() {
        Scanner console = new Scanner(System.in);
        System.out.print("Prefix: ");
        String prefix = console.nextLine();
        this.bookService.findByAuthorLastNameStartingWith(prefix)
                .forEach(b -> System.out.printf("%s (%s %s)%n",
                        b.getTitle(),
                        b.getAuthor().getFirstName(),
                        b.getAuthor().getLastName()));
    }

    private void booksSearch() {
        Scanner console = new Scanner(System.in);
        System.out.print("String: ");
        String string = console.nextLine();
        this.bookService.findByTitleContaining(string)
                .forEach(b -> System.out.println(b.getTitle()));
    }

    private void authorsSearch() {
        Scanner console = new Scanner(System.in);
        System.out.print("Suffix: ");
        String suffix = console.nextLine();
        this.authorService.findByFirstNameEndingWith(suffix)
                .forEach(a -> System.out.println(
                        a.getFirstName() + " " + a.getLastName()));
    }

    private void booksReleasedBeforeDate() throws ParseException {
        Scanner console = new Scanner(System.in);
        System.out.print("Date dd-MM-yyyy: ");
        String date = console.nextLine();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        this.bookService.findByReleaseDateBefore(sdf.parse(date))
                .forEach(b -> System.out.printf("%s %s $%s%n",
                        b.getTitle(),
                        b.getEditionType(),
                        b.getPrice()));
    }

    private void notReleasedBooks() {
        Scanner console = new Scanner(System.in);
        System.out.print("Year: ");
        int year = Integer.parseInt(console.nextLine());
        this.bookService.findByReleaseDateNot(year)
                .forEach(b -> System.out.println(b.getTitle()));
    }

    private void booksByPrice() {
        this.bookService.findByPriceNotBetween()
                .forEach(b -> System.out.printf("%s - $%s%n", b.getTitle(), b.getPrice()));
    }

    private void goldenBooks() {
        this.bookService.findByEditionTypeAndCopiesLessThan()
                .forEach(b -> System.out.println(b.getTitle()));
    }

    private void booksTitlesByAgeRestriction() {
        Scanner console = new Scanner(System.in);
        System.out.print("Input: ");
        String input = console.nextLine();
        AgeRestriction ageRestriction = AgeRestriction.valueOf(input.toUpperCase());
        Iterable<Book> byAgeRestriction = this.bookService.findByAgeRestriction(ageRestriction);
        for (Book book : byAgeRestriction) {
            System.out.println(book.getTitle());
        }
    }
}
