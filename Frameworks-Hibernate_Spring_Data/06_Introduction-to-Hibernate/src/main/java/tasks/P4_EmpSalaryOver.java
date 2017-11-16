package tasks;

import entities.Employee;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;

public class P4_EmpSalaryOver {

    public static void main(String[] args) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("soft_uni");
        EntityManager em = factory.createEntityManager();

        em.getTransaction().begin();

        List<Employee> employees = em.createQuery("SELECT e FROM Employee e WHERE e.salary > 50000").getResultList();

        for (Employee employee : employees) {
            System.out.println(employee.getFirstName());
        }

        em.getTransaction().commit();
    }
}
