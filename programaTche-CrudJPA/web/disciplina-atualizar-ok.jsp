<%@page import="model.Curso"%>
<%@page import="model.Professor"%>
<%@page import="model.Disciplina"%>
<%@page import="dao.DisciplinaDAO"%>
<%@include file="cabecalho.jsp"%>
<%
//txtnome é o NAME que eu coloquei no input na tela 
//anterior
String codigo = request.getParameter("txtcodigo");
String nome = request.getParameter("txtnome");
String codigocurso = request.getParameter("selcurso");//chave
String semestre = request.getParameter("txtsemestre");
String siapeprofessor = request.getParameter("selprofessor"); //chave

DisciplinaDAO dao = new DisciplinaDAO();
//Disciplina obj = new Disciplina();
Disciplina obj = dao.buscaPorChavePrimaria(Integer.parseInt(codigo));

// Monta as FK
Professor objProf = new Professor();
objProf.setSiape(siapeprofessor);

Curso objCurso = new Curso();
objCurso.setCodigo(Integer.parseInt(codigocurso));

//populando o obj disciplina
//obj.setCodigo(Integer.parseInt(codigo));
obj.setCurso(objCurso);
obj.setNome(nome);
obj.setProfessor(objProf);
obj.setSemestre(Integer.parseInt(semestre));

//dao.incluir(obj); // igual ao cadastrar!
dao.alterar(obj);



%>

         <h1 class="centro">Atualização de Disicplina</h1>
            
         <div>
             Registro alterado com sucesso.<br />
             <a href="disciplinas.jsp">Voltar para Listagem</a>
         </div>
    </body>
</html>
