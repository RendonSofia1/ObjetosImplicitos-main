<%-- 
    Document   : autobus
    Created on : 04-nov-2024, 20:03:56
    Author     : rendo
--%>

<%@ page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    // Inicializar listas de asientos y pasajeros
    ArrayList<String> asientosDisponibles = (ArrayList<String>) session.getAttribute("asientosDisponibles");
    ArrayList<String> pasajeros = (ArrayList<String>) session.getAttribute("pasajeros");

    // Verificar si las listas son nulas y inicializarlas
    if (asientosDisponibles == null) {
        asientosDisponibles = new ArrayList<>();
        for (int i = 1; i <= 20; i++) {  
            asientosDisponibles.add("Asiento " + i);
        }
        session.setAttribute("asientosDisponibles", asientosDisponibles);
    }

    if (pasajeros == null) {
        pasajeros = new ArrayList<>();
        session.setAttribute("pasajeros", pasajeros);
    }

    // Procesar el formulario
    String nombre = request.getParameter("nombre");
    String asientoSeleccionado = request.getParameter("asiento");

    if (nombre != null && asientoSeleccionado != null) {
        pasajeros.add(nombre + " - " + asientoSeleccionado);
        asientosDisponibles.remove(asientoSeleccionado);
        session.setAttribute("asientosDisponibles", asientosDisponibles);
        session.setAttribute("pasajeros", pasajeros);

        
        response.sendRedirect("autobus.jsp");
        return;  
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Asignación de Asientos</title>
</head>
<body>
    <h1>Asignar Asiento</h1>
    <form method="post">
        <label for="nombre">Nombre del pasajero:</label>
        <input type="text" id="nombre" name="nombre" required><br><br>

        <label for="asiento">Asiento disponible:</label>
        <select id="asiento" name="asiento" required>
            <% for (String asiento : asientosDisponibles) { %>
                <option value="<%= asiento %>"><%= asiento %></option>
            <% } %>
        </select><br><br>

        <button type="submit">Asignar Asiento</button>
    </form>

    <h2>Pasajeros Registrados</h2>
    <ul>
        <% for (String pasajero : pasajeros) { %>
            <li><%= pasajero %></li>
        <% } %>
    </ul>
</body>
</html>