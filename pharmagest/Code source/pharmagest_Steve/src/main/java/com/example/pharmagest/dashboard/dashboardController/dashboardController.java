package com.example.pharmagest.dashboard.dashboardController;

import javafx.event.ActionEvent;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;
import java.util.Objects;

public class dashboardController {

    // Méthode pour changer d'utilisateur
    public void ChangerUtilisateurOnAction(ActionEvent actionEvent) throws IOException {
        // Charger la page de changement d'utilisateur
        Parent root = FXMLLoader.load(Objects.requireNonNull(getClass().getResource("/com/example/pharmagest/view-login/Login.fxml")));
        Stage stage = (Stage) ((javafx.scene.Node) actionEvent.getSource()).getScene().getWindow();
        stage.setScene(new Scene(root));
    }

    // Méthode pour rediriger vers la page Maintenance
    public void MaintenanceButtonOnAction(ActionEvent actionEvent) throws IOException {
        // Charger la page de Maintenance
        Parent root = FXMLLoader.load(Objects.requireNonNull(getClass().getResource("/com/example/pharmagest/view-maintenance/Maintenance.fxml")));
        Stage stage = (Stage) ((javafx.scene.Node) actionEvent.getSource()).getScene().getWindow();
        stage.setScene(new Scene(root));
    }

    // Méthode pour rediriger vers la page Vente
    public void VenteButtonOnAction(ActionEvent actionEvent) throws IOException {
        // Charger la page de Vente
        Parent root = FXMLLoader.load(Objects.requireNonNull(getClass().getResource("/com/example/pharmagest/view-vente/Vente.fxml")));
        Stage stage = (Stage) ((javafx.scene.Node) actionEvent.getSource()).getScene().getWindow();
        stage.setScene(new Scene(root));
    }

    // Méthode pour rediriger vers la page Caisse
    public void CaisseButtonOnAction(ActionEvent actionEvent) throws IOException {
        // Charger la page de Caisse
        Parent root = FXMLLoader.load(Objects.requireNonNull(getClass().getResource("/com/example/pharmagest/view-ligneVente/ligneVente-1.fxml")));
        Stage stage = (Stage) ((javafx.scene.Node) actionEvent.getSource()).getScene().getWindow();
        stage.setScene(new Scene(root));
    }

    // Méthode pour rediriger vers la page Commande
    public void CommandeButtonOnAction(ActionEvent actionEvent) throws IOException {
        // Charger la page de Commande
        Parent root = FXMLLoader.load(Objects.requireNonNull(getClass().getResource("/com/example/pharmagest/view-commande/Commande.fxml")));
        Stage stage = (Stage) ((javafx.scene.Node) actionEvent.getSource()).getScene().getWindow();
        stage.setScene(new Scene(root));
    }

    // Méthode pour rediriger vers la page Réception de commande
    public void ReceptionCommandeButtonOnAction(ActionEvent actionEvent) throws IOException {
        // Charger la page de Réception de commande
        Parent root = FXMLLoader.load(Objects.requireNonNull(getClass().getResource("/com/example/pharmagest/view-receptionCommande/Reception-commande.fxml")));
        Stage stage = (Stage) ((javafx.scene.Node) actionEvent.getSource()).getScene().getWindow();
        stage.setScene(new Scene(root));
    }

    public void QuitterOnClick(ActionEvent actionEvent) {
        Stage stage = (Stage) ((javafx.scene.Node) actionEvent.getSource()).getScene().getWindow();
        stage.close();
    }
}

