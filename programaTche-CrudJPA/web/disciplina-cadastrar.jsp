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
