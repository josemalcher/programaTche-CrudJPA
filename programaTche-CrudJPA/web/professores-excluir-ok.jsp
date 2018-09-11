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
