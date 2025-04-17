package com.example.pharmagest.utilisateurs.utilisateurModele;

import com.example.pharmagest.DatabaseConnexion.DatabaseConnection;
import com.example.pharmagest.utilisateurs.Utilisateur;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UtilisateurModele {

    public boolean ajouterUtilisateur(String nom, String prenom, String identifiant, String email, String numero, String motDePasse) {
        String query = "INSERT INTO utilisateur (nom, prenom, identifiant, email, numero, motdepasse) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, nom);
            pstmt.setString(2, prenom);
            pstmt.setString(3, identifiant);
            pstmt.setString(4, email);
            pstmt.setString(5, numero);
            pstmt.setString(6, motDePasse);

            int rowsInserted = pstmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean modifierChampUtilisateur(String id, String champ, String newValue) {
        int userId;
        try {
            userId = Integer.parseInt(id);
        } catch (NumberFormatException e) {
            return false;
        }

        if (!champ.equals("nom") && !champ.equals("prenom") && !champ.equals("identifiant") &&
                !champ.equals("email") && !champ.equals("numero")) {
            return false;
        }
        String query = "UPDATE utilisateurs SET " + champ + " = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, newValue);
            pstmt.setInt(2, userId);

            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean supprimerUtilisateur(String id, String motDePasse) {
        int userId;
        try {
            userId = Integer.parseInt(id);
        } catch (NumberFormatException e) {
            return false;
        }

        String query = "DELETE FROM utilisateurs WHERE id = ? AND motdepasse = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, userId);
            pstmt.setString(2, motDePasse);

            int rowsDeleted = pstmt.executeUpdate();
            return rowsDeleted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public ObservableList<Utilisateur> getUtilisateurs() {
        ObservableList<Utilisateur> list = FXCollections.observableArrayList();
        String query = "SELECT id, nom, prenom, identifiant, email, numero FROM utilisateur";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String nom = rs.getString("nom");
                String prenom = rs.getString("prenom");
                String identifiant = rs.getString("identifiant");
                String email = rs.getString("email");
                String numero = rs.getString("numero");
                // Le mot de passe n'est pas affiché dans la table
                list.add(new Utilisateur(id, nom, prenom, identifiant, email, numero, ""));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
