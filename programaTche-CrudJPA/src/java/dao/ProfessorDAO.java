/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.TypedQuery;
import model.Professor;

/**
 *
 * @author josemalcher
 */
public class ProfessorDAO{
    EntityManager em;
    
    public ProfessorDAO() throws Exception {
        EntityManagerFactory emf;
        emf = Conexao.getConexao();
        em = emf.createEntityManager();
    }
    
    public void incluir(Professor obj) throws Exception {
        try {
            em.getTransaction().begin();
            em.persist(obj);
            em.getTransaction().commit();
        } catch (RuntimeException e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
            
        }
        
    }

    public List<Professor> listar() throws Exception {
        return em.createNamedQuery("Professor.findAll").getResultList();
    }
    
    public List<Professor> listar(String nome) throws Exception {
        // Passa o parametro para query
        TypedQuery<Professor> query = em.createNamedQuery("Professor.findByName", Professor.class);
        //seta o parametro
        //query.setParameter("nome", nome);
        query.setParameter("nome",'%'+ nome+ '%');
        // retorna a lista
        return query.getResultList();
    }
    
    public void alterar(Professor obj) throws Exception {
        
        try {
            em.getTransaction().begin();
            em.merge(obj);
            em.getTransaction().commit();
        } catch (RuntimeException e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
    
    public void excluir(Professor obj) throws Exception {
        
        try {
            em.getTransaction().begin();
            em.remove(obj);
            em.getTransaction().commit();
        } catch (RuntimeException e) {
            em.getTransaction().rollback();
        } finally {
            em.close();
        }
    }
    
    public Professor buscaPorChavePrimaria(String chave){
        return em.find(Professor.class, chave);
    }

    public void fechaEmf() {
        Conexao.closeConexao();
    }
}
