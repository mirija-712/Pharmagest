package com.example.pharmagest.vente.venteController;

import com.example.pharmagest.vente.vente;
import com.example.pharmagest.vente.venteModele.venteModele;
import com.example.pharmagest.medicaments.Medicament;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Stage;

import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Objects;

public class venteController {

    // TableView pour afficher les ventes
    @FXML
    private TableView<vente> venteTableView;

    // TableView pour afficher les médicaments
    @FXML
    private TableView<Medicament> medicamentsTableView;
    @FXML
    private TableColumn<Medicament, String> colMedicament;
    @FXML
    private TableColumn<Medicament, Integer> colQuantite;  // Ici on utilise "stock" comme quantité
    @FXML
    private TableColumn<Medicament, Double> colPrixUnitaire;

    // Labels pour afficher la facture
    @FXML
    private Label numFactureLabel;
    @FXML
    private Label dateFactureLabel;
    @FXML
    private Label prixTotalLabel;
    @FXML
    private TextField montantRecuTextField;
    @FXML
    private Label montantRenduLabel;
    @FXML
    private TableColumn<vente, Integer> colNoVente;
    @FXML
    private TableColumn<vente, Date> colDate;
    @FXML
    private TableColumn<vente, String> colTypeVente;
    @FXML
    private TableColumn<vente, Double> colPrixTotal;
    @FXML
    private TableColumn<vente, String> colStatut;
    @FXML
    private TableColumn<vente, Integer> colVendeur;


    // Modèle de données
    private venteModele venteModele = new venteModele();

    // Méthode d'initialisation appelée après le chargement du FXML
    @FXML
    public void initialize() {
        // Configuration des colonnes pour la table des ventes
        colNoVente.setCellValueFactory(new PropertyValueFactory<>("noVente"));
        colDate.setCellValueFactory(new PropertyValueFactory<>("dateVente"));
        colTypeVente.setCellValueFactory(new PropertyValueFactory<>("typeVente"));
        colPrixTotal.setCellValueFactory(new PropertyValueFactory<>("prixTotal"));
        colStatut.setCellValueFactory(new PropertyValueFactory<>("statutVente"));
        colVendeur.setCellValueFactory(new PropertyValueFactory<>("utilisateurId"));

        // Charger la liste des ventes dans la TableView
        ObservableList<vente> ventes = venteModele.getAllVentes();
        venteTableView.setItems(ventes);

        // Configuration des colonnes pour la TableView des médicaments (déjà existante)
        colMedicament.setCellValueFactory(new PropertyValueFactory<>("nom"));
        colQuantite.setCellValueFactory(new PropertyValueFactory<>("stock"));
        colPrixUnitaire.setCellValueFactory(new PropertyValueFactory<>("prixVente"));

        // Initialisation des labels de la facture
        numFactureLabel.setText("");
        dateFactureLabel.setText("");
        prixTotalLabel.setText("");
        montantRecuTextField.clear();
        montantRenduLabel.setText("");

        // Listener sur la sélection d'une vente pour mettre à jour la facture et afficher les médicaments associés
        venteTableView.getSelectionModel().selectedItemProperty().addListener((observable, oldValue, selectedVente) -> {
            if (selectedVente != null) {
                numFactureLabel.setText("FACT" + selectedVente.getNoVente());
                dateFactureLabel.setText(selectedVente.getDateVente().toLocalDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")));
                prixTotalLabel.setText(String.valueOf(selectedVente.getPrixTotal()));

                // Charger la liste des médicaments associés à la vente sélectionnée
                int venteId = selectedVente.getId();
                ObservableList<Medicament> medicaments = venteModele.getMedicamentsByVenteId(venteId);
                medicamentsTableView.setItems(medicaments);
            } else {
                numFactureLabel.setText("");
                dateFactureLabel.setText("");
                prixTotalLabel.setText("");
                medicamentsTableView.getItems().clear();
            }
        });
    }



    // Gestion du bouton de retour
    public void retourButtonOnClick(ActionEvent actionEvent) throws IOException {
        Parent root = FXMLLoader.load(Objects.requireNonNull(getClass().getResource("/com/example/pharmagest/view-dashboard/Dashboard.fxml")));
        Stage stage = (Stage) ((javafx.scene.Node) actionEvent.getSource()).getScene().getWindow();
        stage.setScene(new Scene(root));
    }

    // Réinitialise les informations de facture et la liste des médicaments
    public void clearFactureButtonOnClick(ActionEvent actionEvent) {
        numFactureLabel.setText("...");
        dateFactureLabel.setText("...");
        prixTotalLabel.setText("...");
        montantRecuTextField.clear();
        montantRenduLabel.setText("...");
        medicamentsTableView.getItems().clear();
    }


    public void envoyerFactureButtonOnClick(ActionEvent actionEvent) {
    }

    public void suprimerVenteButtonOnClick(ActionEvent actionEvent) {
    }
}
