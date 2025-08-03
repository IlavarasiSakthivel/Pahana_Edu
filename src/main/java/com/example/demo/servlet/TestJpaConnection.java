package com.example.demo.servlet; // Or wherever your main class is located

import com.example.demo.entity.Student;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class TestJpaConnection {
    public static void main(String[] args) {
        EntityManagerFactory emf = null;
        EntityManager em = null;
        try {
            // "default" refers to the persistence-unit name in persistence.xml
            emf = Persistence.createEntityManagerFactory("default");
            em = emf.createEntityManager();

            // Begin a transaction
            em.getTransaction().begin();

            // Create a new Student
            Student student = new Student();
            student.setName("John Doe");

            // Persist the student
            em.persist(student);

            // Commit the transaction
            em.getTransaction().commit();

            System.out.println("Student saved: " + student.getId());

            // Example: Find a student
            Student foundStudent = em.find(Student.class, student.getId());
            if (foundStudent != null) {
                System.out.println("Found student: " + foundStudent.getName());
            }

        } catch (Exception e) {
            if (em != null && em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            if (em != null) {
                em.close();
            }
            if (emf != null) {
                emf.close();
            }
        }
    }
}