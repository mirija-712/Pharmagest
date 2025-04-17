package com.example.pharmagest.fournisseurs.fournisseurController;

import com.example.pharmagest.fournisseurs.Fournisseur;
import com.example.pharmagest.fournisseurs.fournisseursModele.FournisseurModele;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Stage;
import java.io.IOException;
import java.net.URL;
import java.util.Objects;
import java.util.ResourceBundle;

public class FournisseurController implements Initializable {
    @FXML private TextField idTextField, nomFournisseurTextField, adresseFournisseurTextField, contactFournisseurTextField, newValueTextField, idDeleteTextField;
    @FXML private TableView<Fournisseur> tableView;
    @FXML private TableColumn<Fournisseur, Integer> colId;
    @FXML private TableColumn<Fournisseur, String> colNom, colAdresse, colContact;
    @FXML private MenuButton choixMenu;
    @FXML private MenuItem menuItemNom, menuItemAdresse, menuItemContact;

    private final FournisseurModele fournisseurModele = new FournisseurModele();

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // Configuration des colonnes
        colId.setCellValueFactory(new PropertyValueFactory<>("id"));
        colNom.setCellValueFactory(new PropertyValueFactory<>("nom"));
        colAdresse.setCellValueFactory(new PropertyValueFactory<>("adresse"));
        colContact.setCellValueFactory(new PropertyValueFactory<>("contact"));

        // Gestion du MenuButton
        menuItemNom.setOnAction(e -> {
            choixMenu.setText(menuItemNom.getText());
            newValueTextField.setPromptText("Nouveau nom...");
        });

        menuItemAdresse.setOnAction(e -> {
            choixMenu.setText(menuItemAdresse.getText());
            newValueTextField.setPromptText("Nouvelle adresse...");
        });

        menuItemContact.setOnAction(e -> {
            choixMenu.setText(menuItemContact.getText());
            newValueTextField.setPromptText("Nouveau contact...");
        });

        loadFournisseurs();
    }

    @FXML
    private void addButtonOnAction() {
        String nom = nomFournisseurTextField.getText();
        String adresse = adresseFournisseurTextField.getText();
        String contact = contactFournisseurTextField.getText();

        if (fournisseurModele.ajouterFournisseur(nom, adresse, contact)) {
            showAlert("Fournisseur ajouté !", Alert.AlertType.INFORMATION);
        } else {
            showAlert("Erreur d'ajout !", Alert.AlertType.ERROR);
        }
        clearAddFields();
        loadFournisseurs();
    }

    @FXML
    private void updateButtonOnAction() {
        String id = idTextField.getText();
        String champ = choixMenu.getText();
        String newValue = newValueTextField.getText();

        // Validation
        if (id.isEmpty() || champ.equals("choix menu") || newValue.isEmpty()) {
            showAlert("Veuillez remplir tous les champs !", Alert.AlertType.WARNING);
            return;
        }

        if (fournisseurModele.modifierFournisseur(id, champ.toLowerCase(), newValue)) {
            showAlert("Modification réussie !", Alert.AlertType.INFORMATION);
            clearUpdateFields();
            loadFournisseurs();
        } else {
            showAlert("Erreur lors de la modification", Alert.AlertType.ERROR);
        }
    }
    @FXML
    private void deleteButtonOnAction() {
        String id = idDeleteTextField.getText();

        if (id.isEmpty()) {
            showAlert("Veuillez saisir un ID !", Alert.AlertType.WARNING);
            return;
        }

        if (fournisseurModele.supprimerFournisseur(id)) {
            showAlert("Suppression réussie !", Alert.AlertType.INFORMATION);
        } else {
            showAlert("Erreur de suppression !", Alert.AlertType.ERROR);
        }
        clearDeleteFields();
        loadFournisseurs();
    }

    // Méthodes utilitaires
    private void loadFournisseurs() {
        tableView.setItems(fournisseurModele.getFournisseurs());
    }

    private void clearAddFields() {
        nomFournisseurTextField.clear();
        adresseFournisseurTextField.clear();
        contactFournisseurTextField.clear();
    }

    private void clearUpdateFields() {
        idTextField.clear();
        newValueTextField.clear();
        choixMenu.setText("choix menu");
    }

    private void clearDeleteFields() {
        idDeleteTextField.clear();
    }

    private void showAlert(String message, Alert.AlertType type) {
        Alert alert = new Alert(type);
        alert.setContentText(message);
        alert.show();
    }

    @FXML
    private void retourButtonOnClick() throws IOException {
        Parent root = FXMLLoader.load(Objects.requireNonNull(getClass().getResource("/com/example/pharmagest/view-maintenance/Maintenance.fxml")));
        Stage stage = (Stage) tableView.getScene().getWindow();
        stage.setScene(new Scene(root));
    }
}