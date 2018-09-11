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
