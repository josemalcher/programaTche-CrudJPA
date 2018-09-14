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
             <%=msg%><br />
             <a href="disciplinas.jsp">Voltar para Listagem</a>
         </div>
    </body>
</html>
