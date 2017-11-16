import java.sql.*;

public class P02_GetVillainsNames {

    // JDBC driver name and database URL
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost/minionsdb";

    //  Database credentials
    static final String USER = "root";
    static final String PASS = "1234";

    public static void main(String[] args) throws SQLException {
        Connection connection = DriverManager.getConnection(DB_URL, USER, PASS);

        String query = "SELECT v.name, COUNT(minion_id) as `count`\n" +
                "FROM villains v\n" +
                "JOIN minions_villains mv ON v.id = mv.villain_id\n" +
                "GROUP BY villain_id\n" +
                "HAVING COUNT(minion_id) > 3";

        Statement statement = connection.createStatement();
        ResultSet villainsNames = statement.executeQuery(query);

        while (villainsNames.next()){
            System.out.println(villainsNames.getString("name") +
                    " " +
                    villainsNames.getInt("count"));
        }

        villainsNames.close();
        statement.close();
        connection.close();
    }
}

