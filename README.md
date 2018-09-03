# ProgramaTche-JSP/JPA

https://www.youtube.com/playlist?list=PLuK0q1zy2dBy8CxFP0OLiF31xmjnaVupj

---

## <a name="indice">Índice</a>

- [Aula 01 - requisitos e configurações do projeto](#parte1)   
- [Aula 02 - Criação das classes de modelo / DAO e incorporação do JSP básico](#parte2)   
- [Aula 03 - inserindo e listando](#parte3)   
- [Aula 04 - excluindo](#parte4)   
- [Aula 05 - alterando](#parte5)   
- [Aula 06 - filtrando registros](#parte6)   
- [Relacionamento 1 pra N - Aula 1](#parte7)   
- [Relacionamento 1 pra N - Aula 2](#parte8)   
- [N pra N - Parte 1](#parte9)   

---

## <a name="parte1">Aula 01 - requisitos e configurações do projeto</a>

- NetBeans
- https://jdbc.postgresql.org/download.html

```
<?xml version="1.0" encoding="UTF-8"?>
<persistence version="2.1" xmlns="http://xmlns.jcp.org/xml/ns/persistence" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/persistence http://xmlns.jcp.org/xml/ns/persistence/persistence_2_1.xsd">
  <persistence-unit name="programaTche-CrudJPAPU" transaction-type="RESOURCE_LOCAL">
    <provider>org.eclipse.persistence.jpa.PersistenceProvider</provider>
    <class>model.Professor</class>
    <class>model.Disciplina</class>
    <class>model.Aluno</class>
    <class>model.Curso</class>
    <exclude-unlisted-classes>false</exclude-unlisted-classes>
    <properties>
      <property name="javax.persistence.jdbc.url" value="jdbc:postgresql://localhost:5432/ProgramaTche_JSPJPA"/>
      <property name="javax.persistence.jdbc.user" value="postgres"/>
      <property name="javax.persistence.jdbc.driver" value="org.postgresql.Driver"/>
      <property name="javax.persistence.jdbc.password" value="mal369"/>
    </properties>
  </persistence-unit>
</persistence>

```


[Voltar ao Índice](#indice)

---

## <a name="parte2">Aula 02 - Criação das classes de modelo / DAO e incorporação do JSP básico</a>


[Voltar ao Índice](#indice)

---

## <a name="parte3">Aula 03 - inserindo e listando</a>


[Voltar ao Índice](#indice)

---

## <a name="parte4">Aula 04 - excluindo</a>


[Voltar ao Índice](#indice)

---

## <a name="parte5">Aula 05 - alterando</a>


[Voltar ao Índice](#indice)

---

## <a name="parte6">Aula 06 - filtrando registros</a>


[Voltar ao Índice](#indice)

---

## <a name="parte7">Relacionamento 1 pra N - Aula 1</a>


[Voltar ao Índice](#indice)

---

## <a name="parte8">Relacionamento 1 pra N - Aula 2</a>


[Voltar ao Índice](#indice)

---

## <a name="parte9">N pra N - Parte 1</a>


[Voltar ao Índice](#indice)

---

