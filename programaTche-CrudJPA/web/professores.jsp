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
                            <td><a href="professores-atualizar.jsp?siape=<%=item.getSiape()%>">Editar</a>
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
