package tasks;

import entities.Address;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;
import java.util.Scanner;

public class P7_AddressesWithEmployeeCount {

    public static void main(String[] args) {
        Scanner console = new Scanner(System.in);
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("soft_uni");
        EntityManager em = factory.createEntityManager();

        em.getTransaction().begin();

        List<Address> addresses = em.createQuery(
                "SELECT a FROM Address a " +
                        "ORDER BY a.employees.size DESC, a.town.id")
                .setMaxResults(10)
                .getResultList();

        for (Address address : addresses) {
            System.out.printf("%s, %s - %d employees%n",
                    address.getText(),
                    address.getTown().getName(),
                    address.getEmployees().size());
        }

        em.getTransaction().commit();
    }
}
