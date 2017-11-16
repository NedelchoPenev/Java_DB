package tasks;

import entities.Employee;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;
import java.util.Scanner;

public class P3_ContainsEmployee {
    public static void main(String[] args) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("soft_uni");
        EntityManager em = factory.createEntityManager();

        em.getTransaction().begin();

        Scanner console =  new Scanner(System.in);
        String[] input = console.nextLine().split("\\s+");
        String firstName = input[0];
        String lastName = input[1];

        List<Employee> employeeList = em.createQuery("SELECT e FROM Employee e WHERE e.firstName = ? AND e.lastName = ?")
                .setParameter(0, firstName)
                .setParameter(1, lastName)
                .getResultList();

        if (employeeList.size() == 0){
            System.out.println("No");
        } else {
            System.out.println("Yes");
        }

        em.getTransaction().commit();
    }
}
