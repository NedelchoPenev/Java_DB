package tasks;

import entities.Employee;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.math.BigDecimal;
import java.util.List;
import java.util.Scanner;

public class P12_FindEmployeesByFirstName {

    public static void main(String[] args) {
        Scanner console =  new Scanner(System.in);
        String nameStarWith = console.nextLine();
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("soft_uni");
        EntityManager em = factory.createEntityManager();

        em.getTransaction().begin();

        List<Employee> employees = em.createQuery(
                "SELECT e FROM Employee e " +
                        "WHERE e.firstName LIKE ?1")
                .setParameter(1, nameStarWith + "%")
                .getResultList();

        for (Employee employee : employees) {
            System.out.printf("%s %s - %s - ($%s)%n",
                    employee.getFirstName(),
                    employee.getLastName(),
                    employee.getJobTitle(),
                    employee.getSalary().setScale(2, BigDecimal.ROUND_HALF_DOWN));
        }

        em.getTransaction().commit();
    }
}
