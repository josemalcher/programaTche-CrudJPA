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
