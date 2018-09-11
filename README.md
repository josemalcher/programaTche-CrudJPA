# ProgramaTche-JSP/JPA

https://www.youtube.com/playlist?list=PLuK0q1zy2dBy8CxFP0OLiF31xmjnaVupj

---

## <a name="indice">Índice</a>

- [Aula 01 - requisitos e configurações do projeto](#parte1)   
- [Aula 02 - Criação das classes de modelo / DAO e incorporação do JSP básico](#parte2)   
- [Aula 03 - inserindo e listando](#parte3)   
- [Aula 04 - excluindo](#parte4)   
- [Aula 05 - alterando](#parte5)   
- [Aula 06 - filtrando registros](#parte6)   
- [Relacionamento 1 pra N - Aula 1](#parte7)   
- [Relacionamento 1 pra N - Aula 2](#parte8)   
- [N pra N - Parte 1](#parte9)   

---

## <a name="parte1">Aula 01 - requisitos e configurações do projeto</a>

- NetBeans
- https://jdbc.postgresql.org/download.html

```
<?xml version="1.0" encoding="UTF-8"?>
<persistence version="2.1" xmlns="http://xmlns.jcp.org/xml/ns/persistence" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/persistence http://xmlns.jcp.org/xml/ns/persistence/persistence_2_1.xsd">
  <persistence-unit name="programaTche-CrudJPAPU" transaction-type="RESOURCE_LOCAL">
    <provider>org.eclipse.persistence.jpa.PersistenceProvider</provider>
    <class>model.Professor</class>
    <class>model.Disciplina</class>
    <class>model.Aluno</class>
    <class>model.Curso</class>
    <exclude-unlisted-classes>false</exclude-unlisted-classes>
    <properties>
      <property name="javax.persistence.jdbc.url" value="jdbc:postgresql://localhost:5432/ProgramaTche_JSPJPA"/>
      <property name="javax.persistence.jdbc.user" value="postgres"/>
      <property name="javax.persistence.jdbc.driver" value="org.postgresql.Driver"/>
      <property name="javax.persistence.jdbc.password" value="mal369"/>
    </properties>
  </persistence-unit>
</persistence>

```


[Voltar ao Índice](#indice)

---

## <a name="parte2">Aula 02 - Criação das classes de modelo / DAO e incorporação do JSP básico</a>


- \programaTche-CrudJPA\src\java\dao\ProfessorDAO.java
  
```java
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
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

    public void fechaEmf() {
        Conexao.closeConexao();
    }
}

```

- programaTche-CrudJPA\web\professores-cadastrar-ok.jsp

```html
<%@include file="cabecalho.jsp"%>
<%
    String siape = request.getParameter("txtSiape");
    String nome = request.getParameter("txtNome");
    // chamar a inclusão da DAO
%>

         <h1 class="centro">Cadastro de Professores</h1>
            
         <div>
             Registro cadastrado com sucesso.<br />
             <a href="professores.jsp">Voltar para Listagem</a>
             
         </div>
    </body>
</html>

```

[Voltar ao Índice](#indice)

---

## <a name="parte3">Aula 03 - inserindo e listando</a>

```java
<%@page import="model.Professor"%>
<%@page import="dao.ProfessorDAO"%>
<%@include file="cabecalho.jsp"%>
<%
    String msg = "";
    
    if(request.getParameter("txtSiape") == null || request.getParameter("txtNome")==null){
        response.sendRedirect("professores.jsp");
    }
    
    String siape = request.getParameter("txtSiape");
    String nome = request.getParameter("txtNome");
    // chamar a inclusão da DAO
    ProfessorDAO dao = new ProfessorDAO();
    Professor obj = new Professor();
    obj.setNome(nome);
    obj.setSiape(siape);
    
    try {
            dao.incluir(obj);
            msg = "Registro cadastrado com sucesso";
        } catch (Exception e) {
            msg = "Erro ao cadastrar!";
        }
    
    
%>

         <h1 class="centro">Cadastro de Professores</h1>
            
         <div>
             <%=msg%><br />
             <a href="professores.jsp">Voltar para Listagem</a>
             
         </div>
    </body>
</html>

```

```jsp
<%@page import="model.Professor"%>
<%@page import="java.util.List"%>
<%@page import="dao.ProfessorDAO"%>
<%@include file="cabecalho.jsp"%>
<%
ProfessorDAO dao = new ProfessorDAO();
List<Professor> lista = dao.listar();

%>
        <div>
            <h1 class="centro">Professores</h1>
            
            <div>
                +<a href="professores-cadastrar.jsp">Novo Professor</a><br />
                <form>
                    <input type="text" />
                    <input type="submit" value="Pesquisar"/><br />
                    <table>
                        <tr>
                            <th>Siape</th>
                            <th>Nome</th>
                            
                            <th>Ações</th>
                        </tr>
                        <%for(Professor item:lista){%>
                        <tr>
                            <td><%=item.getSiape()%></td>
                            <td><%=item.getNome()%></td>
                            <td><a href="professores-editar.jsp?siape=<%=item.getSiape()%>">Editar</a>
                                <a href="professores-excluir-ok.jsp?siape=<%=item.getSiape()%>">Excluir</a>
                            </td>
                        </tr>
                        <%}%>
<!--                        <tr>
                            <td>999</td>
                            <td>Marcelo</td>
                            <td><a href="professres-editar.jsp">Editar</a>
                                <a href="professores-excluir-ok.jsp?siape=999">Excluir</a>
                            </td>
                            
                        </tr>
                        <tr>
                            <td>9</td>
                            <td>xxxxxx</td>
                            <td><a href="professres-editar.jsp">Editar</a>
                                <a href="professores-excluir.jsp">Excluir</a>
                            </td>
                            
                        </tr>
                        <tr>
                            <td>9</td>
                            <td>xxxxxx</td>
                            <td><a href="professres-editar.jsp">Editar</a>
                                <a href="professores-excluir.jsp">Excluir</a>
                            </td>
                            
                        </tr>-->
                    </table>
                    
                </form>
            </div>
        </div>
    </body>
</html>

```


[Voltar ao Índice](#indice)

---

## <a name="parte4">Aula 04 - excluindo</a>

- ...\programaTche-CrudJPA\web\professores-excluir-ok.jsp
```jsp
<%@page import="dao.ProfessorDAO"%>
<%@page import="model.Professor"%>
<%@include file="cabecalho.jsp"%>
<%
    String msg = "";
    if (request.getParameter("siape") == null) {
        response.sendRedirect("professores.jsp");
    } else {
        String siape = request.getParameter("siape");
        // buscar registro no base de dados
        // e ele ficará presente n aminha Entidade gerenciadora
        // EntityManager)
        ProfessorDAO dao = new ProfessorDAO();
        Professor obj = dao.buscaPorChavePrimaria(siape);
        if(obj != null){
            dao.excluir(obj);
            msg = "Registro exluído com sucesso";
        }else{
            msg = "Registro não encontrado";
        }
    }

%>
<h1 class="centro">Exclusão de Professores</h1>

<div>
    <%=msg%><br />
    <a href="professores.jsp">Voltar para Listagem</a>
</div>
</body>
</html>

```

- ...\programaTche-CrudJPA\src\java\dao\ProfessorDAO.java

```java
public Professor buscaPorChavePrimaria(String chave){
        return em.find(Professor.class, chave);
    }

```

[Voltar ao Índice](#indice)

---

## <a name="parte5">Aula 05 - alterando</a>


- ...\programaTche-CrudJPA\web\professores-atualizar.jsp
  
```jsp
<%@page import="model.Professor"%>
<%@page import="dao.ProfessorDAO"%>
<%@include file="cabecalho.jsp"%>
<%
    if (request.getParameter("siape") == null) {
        response.sendRedirect("professores.jsp");
        return;
    }
    // busca o registro (professor) a partir da sua chave
    // primaria, nesse caso o SIAPE
    ProfessorDAO dao = new ProfessorDAO();
    String siape = request.getParameter("siape");
    Professor obj = dao.buscaPorChavePrimaria(siape);
    // Verificar se o registro existe
    if (obj == null) {
        response.sendRedirect("professores.jsp");
        return;
    }

%>
<div>
    <h1 class="centro">Atualização de Professores</h1>

    <div>

        <form action="professores-atualizar-ok.jsp" method="post">
            <label>SIAPE: </label>
            <input type="text" name="txtSiape" value="<%=obj.getSiape()%>" readonly="readonly"/><br />
            <label>NOME: </label>
            <input type="text" name="txtNome" value="<%=obj.getNome()%>" /><br />
            <input type="submit" value="Atualizar" />
        </form>
    </div>
</div>
</body>
</html>

```

- ...\programaTche-CrudJPA\web\professores-atualizar-ok.jsp

```jsp
<%@page import="model.Professor"%>
<%@page import="dao.ProfessorDAO"%>
<%@include file="cabecalho.jsp"%>
<%
if(request.getParameter("txtNome") == null || request.getParameter("txtSiape") == null){
    response.sendRedirect("professores.jsp");
    return;
}

String txtSiape = request.getParameter("txtSiape");
String txtNome =  request.getParameter("txtNome");

// Buscar o registro pela chave primaria
// Alterar os demais valores (nesse caso apenas o Nome)
// mandar alterar

ProfessorDAO dao = new ProfessorDAO();
Professor obj = dao.buscaPorChavePrimaria(txtSiape);
if(obj == null){
    response.sendRedirect("professores.jsp");
    return;
}

// atualizar as informações
obj.setNome(txtNome);
dao.alterar(obj);
%>

         <h1 class="centro">Atualização de Professores</h1>
            
         <div>
             Registro alterado com sucesso.<br />
             <a href="professores.jsp">Voltar para Listagem</a>
         </div>
    </body>
</html>

```

[Voltar ao Índice](#indice)

---

## <a name="parte6">Aula 06 - filtrando registros</a>

- ...\programaTche-CrudJPA\src\java\model\Professor.java

```java
@Entity
@Table(name = "professor")
@NamedQueries({
    @NamedQuery(name = "Professor.findAll", query = "SELECT p FROM Professor p"),
    //@NamedQuery(name = "Professor.findByName", query = "SELECT p FROM Professor p WHERE p.nome=:nome")
    @NamedQuery(name = "Professor.findByName", query = "SELECT p FROM Professor p WHERE p.nome like :nome")
})
```

- ...\programaTche-CrudJPA\src\java\dao\ProfessorDAO.java

```java
 public List<Professor> listar(String nome) throws Exception {
        // Passa o parametro para query
        TypedQuery<Professor> query = em.createNamedQuery("Professor.findByName", Professor.class);
        //seta o parametro
        //query.setParameter("nome", nome);
        query.setParameter("nome",'%'+ nome+ '%');
        // retorna a lista
        return query.getResultList();
    }
```

```jsp
<%@page import="model.Professor"%>
<%@page import="java.util.List"%>
<%@page import="dao.ProfessorDAO"%>
<%@include file="cabecalho.jsp"%>
<%
ProfessorDAO dao = new ProfessorDAO();
List<Professor> lista;

//Verificar se veio algo do filtro;
// se vier eu filtro por nome;
// caso contrário eu trago todos os professores
if(request.getParameter("txtFiltro") != null && request.getParameter("txtFiltro") != ""){
    String txtFiltro = request.getParameter("txtFiltro");
    lista = dao.listar(txtFiltro);
}else{
    lista = dao.listar();
}


%>
        <div>
            <h1 class="centro">Professores</h1>
            
            <div>
                +<a href="professores-cadastrar.jsp">Novo Professor</a><br />
                <form action="professores.jsp" method="post">
                    <input type="text" name="txtFiltro" />
                    <input type="submit" value="Pesquisar"/><br />
                </form>
                    <table>
                        <tr>
                            <th>Siape</th>
                            <th>Nome</th>
                            <th>Ações</th>
                        </tr>
                        <%for(Professor item:lista){%>
                        <tr>
                            <td><%=item.getSiape()%></td>
                            <td><%=item.getNome()%></td>
                            <td><a href="professores-atualizar.jsp?siape=<%=item.getSiape()%>">Editar</a>
                                <a href="professores-excluir-ok.jsp?siape=<%=item.getSiape()%>">Excluir</a>
                            </td>
                        </tr>
                        <%}%>
                    </table>
            </div>
        </div>
    </body>
</html>

```

[Voltar ao Índice](#indice)

---

## <a name="parte7">Relacionamento 1 pra N - Aula 1</a>


[Voltar ao Índice](#indice)

---

## <a name="parte8">Relacionamento 1 pra N - Aula 2</a>


[Voltar ao Índice](#indice)

---

## <a name="parte9">N pra N - Parte 1</a>


[Voltar ao Índice](#indice)

---

