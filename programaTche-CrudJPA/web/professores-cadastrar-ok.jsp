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
