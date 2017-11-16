package tasks;

import entities.Department;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.math.BigDecimal;
import java.util.List;

public class P13_EmployeesMaximumSalaries {

    public static void main(String[] args) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("soft_uni");
        EntityManager em = factory.createEntityManager();

        em.getTransaction().begin();

        List<Department> departments = em.createQuery(
                "SELECT d FROM Department d").getResultList();

        for (Department department : departments) {
            BigDecimal maxSalary = (BigDecimal) em.createQuery(
                    "SELECT e.salary FROM Employee e " +
                            "WHERE e.department = ?1" +
                            " ORDER BY e.salary DESC")
                    .setMaxResults(1)
                    .setParameter(1, department)
                    .getSingleResult();
            if (maxSalary.compareTo(new BigDecimal(30000)) < 0 ||
                    maxSalary.compareTo(new BigDecimal(70000)) > 0){
                System.out.printf("%s - %s%n",
                        department.getName(),
                        maxSalary.setScale(2, BigDecimal.ROUND_HALF_DOWN));
            }
        }

        em.getTransaction().commit();
    }
}
