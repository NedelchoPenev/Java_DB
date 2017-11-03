import java.sql.*;
import java.util.Properties;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) throws SQLException {
        Scanner console =  new Scanner(System.in);
        System.out.print("Enter username default (root): ");
        String user = console.nextLine();
        user = user.equals("") ? "root" : user;
        System.out.println();

        System.out.print("Enter password default (empty):");
        String password = console.nextLine().trim();
        System.out.println();

        Properties props = new Properties();
        props.setProperty("user", user);
        props.setProperty("password", password);

        Connection connection =
                DriverManager.getConnection("jdbc:mysql://localhost:3306/diablo", props);

        String query =
                "SELECT CONCAT(first_name, ' ', last_name) AS `full_name`, " +
                        "COUNT(game_id) AS `games` \n" +
                "FROM users AS u\n" +
                "\tINNER JOIN users_games AS ug ON ug.user_id = u.id\n" +
                "WHERE u.user_name = ?";

        PreparedStatement stmt =
                connection.prepareStatement(query);

        System.out.println("Searched user:");
        String username = console.nextLine().trim();
        stmt.setString(1, username);
        ResultSet result = stmt.executeQuery();

        result.next();

        if (result.getString("full_name") != null){
            System.out.printf("User: %s%n", username);
            System.out.printf("%s has played %s games",
                    result.getString("full_name"),
                    result.getString("games"));
        } else {
            System.out.println("No such user exists");
        }
    }
}
