package tasks;

import entities.Employee;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;

public class P5_EmployeesFromDepartment {

    public static void main(String[] args) {
        EntityManagerFactory managerFactory = Persistence.createEntityManagerFactory("soft_uni");
        EntityManager em = managerFactory.createEntityManager();

        em.getTransaction().begin();

        List<Employee> employees = em.createQuery("SELECT e FROM Employee e WHERE e.department.name = 'Research and Development' ORDER BY e.salary, e.id").getResultList();

        for (Employee employee : employees) {
            System.out.printf("%s %s from Research and Development - $%.2f%n",
                    employee.getFirstName(),
                    employee.getLastName(),
                    employee.getSalary());
        }

        em.getTransaction().commit();
    }
}
