package io.github.janmalch.kino.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

final class RepositoryImpl<T> implements Repository<T> {

  private EntityManagerFactory factory = Persistence.createEntityManagerFactory("kino");
  private EntityManager em = factory.createEntityManager();
  private final Class<T> entityType;

  RepositoryImpl(Class<T> entityType) {
    this.entityType = entityType;
  }

  @Override
  public void close() {
    this.em.close();
    this.factory.close();
  }

  @Override
  public Class<T> getEntityType() {
    return entityType;
  }

  @Override
  public EntityManager getEntityManager() {
    return em;
  }

  @Override
  public String toString() {
    return "RepositoryImpl{"
        + "entityType="
        + entityType
        + ", em="
        + em
        + ", em#isOpen="
        + em.isOpen()
        + ", factory="
        + factory
        + ", factory#isOpen="
        + factory.isOpen()
        + '}';
  }
}
