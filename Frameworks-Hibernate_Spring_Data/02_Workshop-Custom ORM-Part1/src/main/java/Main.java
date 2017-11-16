import entities.User;
import orm.Connector;
import orm.EntityManager;

import java.util.Scanner;

public class Main {

    public static void main(String[] args) throws Exception {

        Scanner scanner = new Scanner(System.in);
        String username = scanner.nextLine().trim();
        String password = scanner.nextLine().trim();
        String db = scanner.nextLine();
        Connector.createConnection(username, password, db);
        EntityManager<User> em = new EntityManager<>(Connector.getConnection());

        em.doDelete(User.class, "id = 2");
    }
}

