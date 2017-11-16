package tasks;

import entities.Address;
import entities.Employee;
import entities.Town;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;
import java.util.Scanner;

public class P11RemoveTowns {

    public static void main(String[] args) {
        Scanner console =  new Scanner(System.in);
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("soft_uni");
        EntityManager em = factory.createEntityManager();

        em.getTransaction().begin();
        String townName = console.nextLine();

        Town townToDelete = (Town) em.createQuery(
                "SELECT t FROM Town t WHERE t.name LIKE ?1")
                .setParameter(1, townName)
                .getSingleResult();

        List<Address> addressesToDelete = em.createQuery(
                "SELECT a FROM Address a WHERE a.town = ?1")
                .setParameter(1, townToDelete)
                .getResultList();

        for (Address address : addressesToDelete) {
            for (Employee employee : address.getEmployees()) {
                employee.setAddress(null);
            }
            em.flush();
            em.remove(address);
        }

        System.out.printf("%d address in %s deleted%n",
                addressesToDelete.size(),
                townName);

        em.remove(townToDelete);

        em.getTransaction().commit();
    }
}
