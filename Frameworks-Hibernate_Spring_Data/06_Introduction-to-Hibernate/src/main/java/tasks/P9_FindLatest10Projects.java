package tasks;

import entities.Project;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

public class P9_FindLatest10Projects {

    public static void main(String[] args) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("soft_uni");
        EntityManager em = factory.createEntityManager();

        em.getTransaction().begin();

        List<Project> projects = em.createQuery(
                "SELECT p FROM Project p " +
                        "ORDER BY p.startDate DESC")
                .setMaxResults(10)
                .getResultList();

        for (Project project : projects.stream().sorted(Comparator.comparing(Project::getName)).collect(Collectors.toList())) {
            System.out.printf("Project name: %s%n", project.getName());
            System.out.printf("\tProject Description: %s%n",
                    project.getDescription());
            System.out.printf("\tProject Start Date: %s%n",
                    project.getStartDate());
            System.out.printf("\tProject End Date: %s%n", project.getEndDate());
        }

        em.getTransaction().commit();
    }
}
