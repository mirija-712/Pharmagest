package com.example.pharmagest.login.LoginModele;

import com.example.pharmagest.login.login;
import com.example.pharmagest.DatabaseConnexion.DatabaseConnection;
import javafx.scene.control.Label;
import javafx.stage.Stage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginConnexion {

    public boolean validateLogin(login user, Label loginMessageLabel, Stage stage) {
        try (Connection connectDB = new DatabaseConnection().getConnection()) {
            if (connectDB == null) {
                loginMessageLabel.setText("Connexion à la base échouée.");
                return false;
            }

            String query = "SELECT COUNT(1), \"identifiant\" FROM public.\"utilisateur\" " +
                    "WHERE \"identifiant\" = ? AND \"motdepasse\" = ? GROUP BY \"identifiant\"";

            try (PreparedStatement stmt = connectDB.prepareStatement(query)) {
                stmt.setString(1, user.getUsername());
                stmt.setString(2, user.getPassword());

                try (ResultSet result = stmt.executeQuery()) {
                    if (result.next() && result.getInt(1) == 1) {
                        loginMessageLabel.setText("Bienvenue à l'application");
                        return true;
                    }
                }
                loginMessageLabel.setText("Login invalide. Veuillez réessayer.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            loginMessageLabel.setText("Une erreur s'est produite.");
        }

        return false;
    }
}
