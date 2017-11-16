import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class Main {

    public static void main(String[] args) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("football_betting");
        EntityManager em = factory.createEntityManager();

        em.getTransaction().begin();

        em.getTransaction().commit();

        em.close();
        factory.close();
    }
}
