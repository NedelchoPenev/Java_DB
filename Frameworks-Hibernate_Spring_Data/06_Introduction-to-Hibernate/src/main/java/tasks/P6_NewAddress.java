package tasks;

import entities.Address;
import entities.Employee;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.Scanner;

public class P6_NewAddress {

    public static void main(String[] args) {
        Scanner console =  new Scanner(System.in);
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("soft_uni");
        EntityManager em = factory.createEntityManager();

        em.getTransaction().begin();

        Address newAddress = new Address();
        newAddress.setText("Vitoshka 15");
        em.persist(newAddress);

        String lastName = console.nextLine();

        Employee employee = (Employee) em.createQuery("SELECT e FROM Employee e WHERE e.lastName = ?")
                .setParameter(0, lastName)
                .setMaxResults(1)
                .getSingleResult();

        employee.setAddress(newAddress);

        em.getTransaction().commit();
    }
}
