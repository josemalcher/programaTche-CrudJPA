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
