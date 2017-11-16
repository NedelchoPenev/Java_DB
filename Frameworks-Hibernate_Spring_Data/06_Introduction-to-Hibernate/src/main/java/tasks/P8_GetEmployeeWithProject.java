package tasks;

import entities.Employee;
import entities.Project;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.Comparator;
import java.util.Scanner;
import java.util.Set;
import java.util.stream.Collectors;

public class P8_GetEmployeeWithProject {

    public static void main(String[] args) {
        Scanner console =  new Scanner(System.in);
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("soft_uni");
        EntityManager em = factory.createEntityManager();

        em.getTransaction().begin();

        int searchedId = Integer.parseInt(console.nextLine());
        Employee employee = (Employee) em.createQuery(
                "SELECT e FROM Employee e WHERE e.id = ?")
                .setParameter(0, searchedId)
                .getSingleResult();

        Set<Project> projects = employee.getProjects()
                .stream()
                .sorted(Comparator.comparing(Project::getName))
                .collect(Collectors.toSet());

        System.out.printf("%s %s - %s%n",
                employee.getFirstName(),
                employee.getLastName(),
                employee.getJobTitle());

        for (Project project : projects) {
            System.out.printf("\t%s%n", project.getName());
        }

        em.getTransaction().commit();
    }
}
