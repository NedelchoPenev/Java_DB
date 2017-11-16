package tasks;

import entities.Employee;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.math.BigDecimal;
import java.util.List;

public class P10_IncreaseSalaries {

    public static void main(String[] args) {
        EntityManagerFactory factory =
                Persistence.createEntityManagerFactory("soft_uni");
        EntityManager em = factory.createEntityManager();

        em.getTransaction().begin();

        List<Employee> employees = em.createQuery(
                "SELECT e FROM Employee e " +
                        "WHERE e.department.name = 'Engineering' OR e.department.name = 'Tool Design' OR e.department.name = 'Marketing' OR e.department.name = 'Information Services'").getResultList();

        for (Employee employee : employees) {
            BigDecimal newSalary = employee.getSalary().add(employee.getSalary()
                    .multiply(new BigDecimal(0.12)));
            employee.setSalary(newSalary);
            System.out.printf("%s %s ($%s)%n",
                    employee.getFirstName(),
                    employee.getLastName(),
                    employee.getSalary().setScale(2, BigDecimal.ROUND_HALF_UP));
        }
        
        em.getTransaction().commit();
    }
}
