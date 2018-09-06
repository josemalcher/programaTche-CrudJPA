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
