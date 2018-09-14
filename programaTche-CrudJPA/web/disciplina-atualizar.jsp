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
