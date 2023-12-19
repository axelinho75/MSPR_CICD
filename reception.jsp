<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Réception des Données</title>
</head>
<body>

<%
    // Récupération des données du formulaire
    String annee = request.getParameter("annee");

    // Validation et traitement des données
    if (annee != null && !annee.isEmpty()) {
        // Configuration de la source de données (à adapter en fonction de votre configuration)
        String jdbcResource = "jdbc/NomDeVotreDataSource"; // Remplacez par le nom de votre source de données JNDI
        Context context = new InitialContext();
        DataSource dataSource = (DataSource) context.lookup(jdbcResource);

        // Connexion à la base de données
        try (Connection connection = dataSource.getConnection()) {
            // Exécution de la requête SQL pour insérer les données dans la base de données
            String sql = "INSERT INTO VotreTable (annee) VALUES (?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setInt(1, Integer.parseInt(annee));
                preparedStatement.executeUpdate();
            } catch (SQLException e) {
                out.println("Erreur lors de l'exécution de la requête : " + e.getMessage());
            }

            out.println("<h2>Données enregistrées avec succès !</h2>");
        } catch (SQLException e) {
            out.println("Erreur lors de la connexion à la base de données : " + e.getMessage());
        }
    } else {
        out.println("<h2>Erreur : Champ 'annee' vide</h2>");
    }
%>

</body>
</html>
