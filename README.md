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

```java
package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import model.Disciplina;

/**
 *
 * @author josemalcher
 */
public class DisciplinaDAO {
    EntityManager em;
    
    public DisciplinaDAO() throws Exception {
        EntityManagerFactory emf;
        emf = Conexao.getConexao();
        em = emf.createEntityManager();
    }
    
    public void incluir(Disciplina obj) throws Exception {
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

    public List<Disciplina> listar() throws Exception {
        return em.createNamedQuery("Disciplina.findAll").getResultList();
    }
    
    public void alterar(Disciplina obj) throws Exception {
        
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
    
    public void excluir(Disciplina obj) throws Exception {
        
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

```java
package dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import model.Curso;

/**
 *
 * @author josemalcher
 */
public class CursoDAO {
    EntityManager em;
    
    public CursoDAO() throws Exception {
        EntityManagerFactory emf;
        emf = Conexao.getConexao();
        em = emf.createEntityManager();
    }
    
    public void incluir(Curso obj) throws Exception {
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

    public List<Curso> listar() throws Exception {
        return em.createNamedQuery("Curso.findAll").getResultList();
    }
    
    public void alterar(Curso obj) throws Exception {
        
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
    
    public void excluir(Curso obj) throws Exception {
        
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

```jsp
<%@page import="java.util.List"%>
<%@page import="model.Disciplina"%>
<%@page import="dao.DisciplinaDAO"%>
<%@include file="cabecalho.jsp"%>
<%
DisciplinaDAO dao = new DisciplinaDAO();
List<Disciplina> lista = dao.listar();

%>


        <div>
            <h1 class="centro">Disciplina</h1>
            
            <div>
                +<a href="disciplina-cadastrar.jsp">Nova Disciplina</a><br />
                <form>
                    <input type="text" />
                    <input type="submit" value="Pesquisar"/><br />
                    <table>
                        <tr>
                            <th>Código</th>
                            <th>Nome</th>
                            <th>Curso</th>
                            <th>Semestre</th>
                            <th>Professor</th>
                            <th>Ações</th>
                        </tr>
                        <%
                        for(Disciplina obj : lista){
                        %>
                        <tr>
                            <td><%=obj.getCodigo()%></td>
                            <td><%=obj.getNome()%></td>
                            <td><%=obj.getCurso()%></td>
                            <td><%=obj.getSemestre()%></td>
                            <td><a href="curso-atualizar.jsp?codigo=<%=obj.getCodigo()%>">Editar</a>
                                <a href="curso-excluir-ok.jsp?codigo=<%=obj.getCodigo()%>">Excluir</a>
                            </td>
                            
                        </tr>
                        <%
                        }
                        %>
                        
                    </table>
                    
                </form>
            </div>
        </div>
    </body>
</html>

```

```jsp
<%@page import="model.Professor"%>
<%@page import="dao.ProfessorDAO"%>
<%@page import="model.Curso"%>
<%@page import="java.util.List"%>
<%@page import="dao.CursoDAO"%>
<%@include file="cabecalho.jsp"%>
<%
//Listagem de cursos
    CursoDAO cDAO = new CursoDAO();
    List<Curso> cLista = cDAO.listar();

// Listagem de professores
    ProfessorDAO pDAO = new ProfessorDAO();
    List<Professor> pLista = pDAO.listar();

%>


<div>
    <h1 class="centro">Cadastro de Disciplinas</h1>

    <div>

        <form action="disciplina-cadastrar-ok.jsp" method="post">
            <label>Código</label>
            <input type="text" name="txtcodigo" /><br />
            <label>Nome:</label>
            <input type="text" name="txtnome" /><br />
            <label>Semestre</label>
            <input type="text" name="txtsemestre" /><br />
            <label>Curso</label>
            <!--            <input type="text" name="txtcurso" /><br />-->
            <select name="selcurso">
                <option value="">Selecione</option>
                <%                    // percorrer a lista
                    for (Curso c : cLista) {
                %>
                <option value="<%=c.getCodigo()%>"><%=c%></option>
                <%}%>
            </select><br>
            <label>professor</label>
            <!--            <input type="text" name="txtprofessor" /><br />-->
            <select name="selprofessor">
                <option value="" >Selecione</option>
                <%
                    // percorrer a lista
                    for (Professor p : pLista) {
                %>
                <option value="<%=p.getSiape()%>"><%=p%></option>
                <%}%>
            </select>
            <br>
            <input type="reset" value="Limpar" />
            <input type="submit" value="Cadastrar" />
        </form>
    </div>
</div>

</body>
</html>

```

```jsp
<%@page import="model.Curso"%>
<%@page import="model.Professor"%>
<%@page import="model.Disciplina"%>
<%@page import="dao.DisciplinaDAO"%>
<%@include file="cabecalho.jsp"%>
<%
//txtnome é o NAME que eu coloquei no input na tela 
//anterior
String codigo = request.getParameter("txtcodigo");
String nome = request.getParameter("txtnome");
String codigocurso = request.getParameter("selcurso");//chave
String semestre = request.getParameter("txtsemestre");
String siapeprofessor = request.getParameter("selprofessor"); //chave

DisciplinaDAO dao = new DisciplinaDAO();
Disciplina obj = new Disciplina();

// Monta as FK
Professor objProf = new Professor();
objProf.setSiape(siapeprofessor);

Curso objCurso = new Curso();
objCurso.setCodigo(Integer.parseInt(codigocurso));

//populando o obj disciplina
obj.setCodigo(Integer.parseInt(codigo));
obj.setCurso(objCurso);
obj.setNome(nome);
obj.setProfessor(objProf);
obj.setSemestre(Integer.parseInt(semestre));

dao.incluir(obj);



%>
         <h1 class="centro">Cadastro de Curso</h1>
            
         <div>
             Registro cadastrado com sucesso.<br />
             <a href="disciplinas.jsp">Voltar para Listagem</a>
         </div>
    </body>
</html>

```


[Voltar ao Índice](#indice)

---

## <a name="parte8">Relacionamento 1 pra N - Aula 2</a>


```jsp
<%@page import="model.Professor"%>
<%@page import="java.util.List"%>
<%@page import="model.Curso"%>
<%@page import="dao.CursoDAO"%>
<%@page import="dao.ProfessorDAO"%>
<%@page import="model.Disciplina"%>
<%@page import="dao.DisciplinaDAO"%>
<%@include file="cabecalho.jsp"%>
<%
    // receber achave primaria
    // buscar o reguistro correspondente a C.p.
    // excluir o registro
    if(request.getParameter("codigo")== null){
        response.sendRedirect("disciplinas.jsp");
        return;
    }
    Integer codigo = Integer.parseInt(request.getParameter("codigo"));
    DisciplinaDAO dao = new DisciplinaDAO();
    Disciplina obj  = dao.buscaPorChavePrimaria(codigo);

    // Achou a disciplina, se não volta para lista
    if(obj == null){
        response.sendRedirect("disciplinas.jsp");
        return;
    }
    
//Listagem de cursos
    CursoDAO cDAO = new CursoDAO();
    List<Curso> cLista = cDAO.listar();

    // Listagem de professores
    ProfessorDAO pDAO = new ProfessorDAO();
    List<Professor> pLista = pDAO.listar();

%>
         <h1 class="centro">Exclusão de Alunos</h1>
            
         <div>
             <br />
             <a href="disciplinas.jsp">Voltar para Listagem</a>
         </div>
    </body>
</html>


```

```jsp
<%@page import="model.Disciplina"%>
<%@page import="dao.DisciplinaDAO"%>
<%@page import="model.Professor"%>
<%@page import="dao.ProfessorDAO"%>
<%@page import="model.Curso"%>
<%@page import="java.util.List"%>
<%@page import="dao.CursoDAO"%>
<%@include file="cabecalho.jsp"%>
<%
    
    if(request.getParameter("codigo")== null){
        response.sendRedirect("disciplina.jsp");
        return;
    }
    
    Integer codigo = Integer.parseInt(request.getParameter("codigo"));
    DisciplinaDAO dao = new DisciplinaDAO();
    Disciplina obj = dao.buscaPorChavePrimaria(codigo);
    String msg = "";
    
//Listagem de cursos
    CursoDAO cDAO = new CursoDAO();
    List<Curso> cLista = cDAO.listar();

// Listagem de professores
    ProfessorDAO pDAO = new ProfessorDAO();
    List<Professor> pLista = pDAO.listar();

%>


<div>
    <h1 class="centro">Atualização de Disciplinas</h1>

    <div>

        <form action="disciplina-atualizar-ok.jsp" method="post">
            <label>Código</label>
            <input type="text" name="txtcodigo" value="<%=obj.getCodigo()%>" /><br />
            <label>Nome:</label>
            <input type="text" name="txtnome" value="<%=obj.getNome()%>" /><br />
            <label>Semestre</label>
            <input type="text" name="txtsemestre" value="<%=obj.getSemestre()%>" /><br />
            <label>Curso</label>
            <!--            <input type="text" name="txtcurso" /><br />-->
            <select name="selcurso">
                <option value="">Selecione</option>
                <%                    // percorrer a lista
                    String selected = "";
                    for (Curso c : cLista) {
                        if(c.getCodigo() == obj.getCurso().getCodigo()){
                            selected = "selected";
                        }
                %>
                <option value="<%=c.getCodigo()%>" <%=selected%> ><%=c%></option>
                <% selected = ""; 
                    }
                %>
            </select><br>
            <label>professor</label>
            <!--            <input type="text" name="txtprofessor" /><br />-->
            <select name="selprofessor">
                <option value="" >Selecione</option>
                <%
                    selected = "";
                    for (Professor p : pLista) {
                        if(p.getSiape() == obj.getProfessor().getSiape()){
                            selected = "selected";
                        }
                %>
                <option value="<%=p.getSiape()%>"   <%=selected%>  ><%=p%></option>
                <% selected = ""; 
                    }
                %>
            </select>
            <br>
          
            <input type="submit" value="Atualizar" />
        </form>
    </div>
</div>

</body>
</html>

```

```jsp
<%@page import="model.Curso"%>
<%@page import="model.Professor"%>
<%@page import="model.Disciplina"%>
<%@page import="dao.DisciplinaDAO"%>
<%@include file="cabecalho.jsp"%>
<%
//txtnome é o NAME que eu coloquei no input na tela 
//anterior
String codigo = request.getParameter("txtcodigo");
String nome = request.getParameter("txtnome");
String codigocurso = request.getParameter("selcurso");//chave
String semestre = request.getParameter("txtsemestre");
String siapeprofessor = request.getParameter("selprofessor"); //chave

DisciplinaDAO dao = new DisciplinaDAO();
//Disciplina obj = new Disciplina();
Disciplina obj = dao.buscaPorChavePrimaria(Integer.parseInt(codigo));

// Monta as FK
Professor objProf = new Professor();
objProf.setSiape(siapeprofessor);

Curso objCurso = new Curso();
objCurso.setCodigo(Integer.parseInt(codigocurso));

//populando o obj disciplina
//obj.setCodigo(Integer.parseInt(codigo));
obj.setCurso(objCurso);
obj.setNome(nome);
obj.setProfessor(objProf);
obj.setSemestre(Integer.parseInt(semestre));

//dao.incluir(obj); // igual ao cadastrar!
dao.alterar(obj);



%>

         <h1 class="centro">Atualização de Disicplina</h1>
            
         <div>
             Registro alterado com sucesso.<br />
             <a href="disciplinas.jsp">Voltar para Listagem</a>
         </div>
    </body>
</html>

```


[Voltar ao Índice](#indice)

---

## <a name="parte9">N pra N - Parte 1</a>


[Voltar ao Índice](#indice)

---

