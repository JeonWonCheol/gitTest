<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %> 
<%
//JDBC ����̹��� �ε��Ѵ�.
Class.forName("com.mysql.cj.jdbc.Driver");

String host   = "jdbc:mysql://127.0.0.1:3306/yore";
host += "?useUnicode=true&characterEncoding=utf-8";
host += "&serverTimezone=UTC";
String userid = "root";
String passwd = "ezen";
Connection conn = null;
//�����ͺ��̽��� �����Ѵ�.
conn = DriverManager.getConnection(host,userid,passwd);

//�۾� ó���� Ŭ������ �Ҵ� �޴´�.
Statement stmt = conn.createStatement();
%>
