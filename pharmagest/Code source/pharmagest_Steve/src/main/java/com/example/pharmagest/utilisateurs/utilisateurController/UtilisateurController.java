package com.example.pharmagest.utilisateurs.utilisateurController;

import com.example.pharmagest.utilisateurs.Utilisateur;
import com.example.pharmagest.utilisateurs.utilisateurModele.UtilisateurModele;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Stage;

import java.io.IOException;
import java.util.Objects;

public class UtilisateurController {

    @FXML
    private TextField idTextField, nomTextField, prenomTextField, identifiantTextField, emailTextField, numeroTextField, newValueTextField, idDeleteTextField;

    @FXML
    private PasswordField passwordTextField, passwordDeleteField;

    @FXML
    private Button addButton, updateButton, deleteButton, retourButton;

    @FXML
    private Label errorLabel;

    @FXML
    private TableView<Utilisateur> tableView;

    @FXML
    private TableColumn<Utilisateur, Integer> colID;

    @FXML
    private TableColumn<Utilisateur, String> colNom, colPrenom, colIdentifiant, colEmail, colNumero;

    @FXML
    private MenuButton menuButton;

    @FXML
    private MenuItem menuItemNom, menuItemPrenom, menuItemIdentifiant, menuItemEmail, menuItemNumero;

    private UtilisateurModele utilisateurModele = new UtilisateurModele();

    @FXML
    public void initialize() {
        // Configuration du MenuButton pour sélectionner le champ à modifier.
        menuItemNom.setOnAction(e -> menuButton.setText("nom"));
        menuItemPrenom.setOnAction(e -> menuButton.setText("prenom"));
        menuItemIdentifiant.setOnAction(e -> menuButton.setText("identifiant"));
        menuItemEmail.setOnAction(e -> menuButton.setText("email"));
        menuItemNumero.setOnAction(e -> menuButton.setText("numero"));

        // Configuration des colonnes de la TableView.
        colID.setCellValueFactory(new PropertyValueFactory<>("id"));
        colNom.setCellValueFactory(new PropertyValueFactory<>("nom"));
        colPrenom.setCellValueFactory(new PropertyValueFactory<>("prenom"));
        colIdentifiant.setCellValueFactory(new PropertyValueFactory<>("identifiant"));
        colEmail.setCellValueFactory(new PropertyValueFactory<>("email"));
        colNumero.setCellValueFactory(new PropertyValueFactory<>("numero"));

        loadUtilisateurs();
    }

    @FXML
    public void addButtonOnAction() {
        String nom = nomTextField.getText().trim();
        String prenom = prenomTextField.getText().trim();
        String identifiant = identifiantTextField.getText().trim();
        String email = emailTextField.getText().trim();
        String numero = numeroTextField.getText().trim();
        String motDePasse = passwordTextField.getText().trim();

        // Vérification : si l'un des champs est vide, afficher un message d'erreur.
        if (nom.isEmpty() || prenom.isEmpty() || identifiant.isEmpty() || email.isEmpty() || numero.isEmpty() || motDePasse.isEmpty()) {
            errorLabel.setText("Veuillez remplir tous les champs pour l'ajout.");
            errorLabel.setStyle("-fx-text-fill: red;");
            return;
        }

        boolean success = utilisateurModele.ajouterUtilisateur(nom, prenom, identifiant, email, numero, motDePasse);

        if (success) {
            errorLabel.setText("Utilisateur ajouté avec succès !");
            errorLabel.setStyle("-fx-text-fill: green;");
        } else {
            errorLabel.setText("Erreur lors de l'ajout de l'utilisateur.");
            errorLabel.setStyle("-fx-text-fill: red;");
        }
        clearAddFields();
        loadUtilisateurs();
    }

    @FXML
    public void updateButtonOnAction() {
        String id = idTextField.getText().trim();
        String champ = menuButton.getText().trim();
        String newValue = newValueTextField.getText().trim();

        // Vérification des champs pour la modification.
        if (id.isEmpty()) {
            errorLabel.setText("Le champ ID est vide.");
            errorLabel.setStyle("-fx-text-fill: red;");
            return;
        }
        if (champ.equals("choix menu")) {
            errorLabel.setText("Veuillez choisir un champ à modifier.");
            errorLabel.setStyle("-fx-text-fill: red;");
            return;
        }
        if (newValue.isEmpty()) {
            errorLabel.setText("La nouvelle valeur est vide.");
            errorLabel.setStyle("-fx-text-fill: red;");
            return;
        }

        boolean success = utilisateurModele.modifierChampUtilisateur(id, champ, newValue);

        if (success) {
            errorLabel.setText("Utilisateur modifié avec succès !");
            errorLabel.setStyle("-fx-text-fill: green;");
        } else {
            errorLabel.setText("Erreur : ID invalide ou modification impossible.");
            errorLabel.setStyle("-fx-text-fill: red;");
        }
        clearUpdateFields();
        loadUtilisateurs();
    }

    @FXML
    public void deleteButtonOnAction() {
        String id = idDeleteTextField.getText().trim();
        String motDePasse = passwordDeleteField.getText().trim();

        // Vérification des champs pour la suppression.
        if (id.isEmpty()) {
            errorLabel.setText("Le champ ID est vide.");
            errorLabel.setStyle("-fx-text-fill: red;");
            return;
        }
        if (motDePasse.isEmpty()) {
            errorLabel.setText("Le champ mot de passe est vide.");
            errorLabel.setStyle("-fx-text-fill: red;");
            return;
        }

        boolean success = utilisateurModele.supprimerUtilisateur(id, motDePasse);

        if (success) {
            errorLabel.setText("Utilisateur supprimé avec succès !");
            errorLabel.setStyle("-fx-text-fill: green;");
        } else {
            errorLabel.setText("Erreur : ID/mot de passe invalide ou suppression impossible.");
            errorLabel.setStyle("-fx-text-fill: red;");
        }
        clearDeleteFields();
        loadUtilisateurs();
    }

    @FXML
    public void retourButtonOnClick() throws IOException {
        Parent root = FXMLLoader.load(Objects.requireNonNull(getClass().getResource("/com/example/pharmagest/view-maintenance/Maintenance.fxml")));
        Stage stage = (Stage) retourButton.getScene().getWindow();
        stage.setScene(new Scene(root));
    }

    private void clearAddFields() {
        nomTextField.clear();
        prenomTextField.clear();
        identifiantTextField.clear();
        emailTextField.clear();
        numeroTextField.clear();
        passwordTextField.clear();
    }

    private void clearUpdateFields() {
        idTextField.clear();
        newValueTextField.clear();
        menuButton.setText("choix menu");
    }

    private void clearDeleteFields() {
        idDeleteTextField.clear();
        passwordDeleteField.clear();
    }

    private void loadUtilisateurs() {
        tableView.setItems(utilisateurModele.getUtilisateurs());
    }
}
