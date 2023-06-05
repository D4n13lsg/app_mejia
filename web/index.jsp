<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registros de Usuarios</title>
    <link rel="stylesheet" href="base.css">
    
    <head>
    <title>Registros de Usuarios</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        
        h1 {
            text-align: center;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            background-color: #f2f2f2;
        }
        
        .form-container {
            max-width: 500px;
            margin: 20px auto;
            padding: 20px;
            background-color: #f2f2f2;
        }
        
        .form-container label, .form-container input[type=text] {
            display: block;
            margin-bottom: 10px;
        }
        
        .form-container input[type=text] {
            width: 100%;
            padding: 5px;
        }
        
        .form-container input[type=submit] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin-top: 10px;
            cursor: pointer;
        }
        
        .form-container input[type=submit]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h1>User Registries</h1>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Lastname</th>
            <th>Phone</th>
            <th>Acciones</th>
        </tr>
        <% 
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/crud", "root", "camilo1808");
            
            if (request.getParameter("submit") != null) {
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String celular = request.getParameter("celular");
                
                PreparedStatement stmt = con.prepareStatement("INSERT INTO usuarios (nombre, apellido, celular) VALUES (?, ?, ?)");
                stmt.setString(1, nombre);
                stmt.setString(2, apellido);
                stmt.setString(3, celular);
                stmt.executeUpdate();
                
                stmt.close();
            }
            
            if (request.getParameter("deleteId") != null) {
                int id = Integer.parseInt(request.getParameter("deleteId"));
                
                PreparedStatement stmt = con.prepareStatement("DELETE FROM usuarios WHERE id = ?");
                stmt.setInt(1, id);
                stmt.executeUpdate();
                
                stmt.close();
            }
            
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM usuarios");
            
            while (rs.next()) {
                int id = rs.getInt("id");
                String nombre = rs.getString("nombre");
                String apellido = rs.getString("apellido");
                String celular = rs.getString("celular");
        %>
        <tr>
            <td><%=id%></td>
            <td><%=nombre%></td>
            <td><%=apellido%></td>
            <td><%=celular%></td>
            <td>
                <form action="" method="post">
                    <input type="hidden" name="deleteId" value="<%=id%>">
                    <input type="submit" value="Delete">
                </form>
            </td>
        </tr>
        <% 
            }
            
            rs.close();
            stmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
    </table>
    <div class="form-container">
        <h2>User Registries</h2>
        <form action="" method="post">
            <label for="nombre">Name</label>
            <input type="text" name="nombre" id="nombre" required>
        
            <label for="apellido">LastName</label>
            <input type="text" name="apellido" id="apellido" required>
        
            <label for="celular">Phone</label>
            <input type="text" name="celular" id="celular" required>
        
            <input type="submit" name="submit" value="Agregar">
        </form>
    </div>
</body>
</html>
