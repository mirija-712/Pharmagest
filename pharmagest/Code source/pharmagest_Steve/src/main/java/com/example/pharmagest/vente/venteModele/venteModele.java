package com.example.pharmagest.vente.venteModele;

import com.example.pharmagest.DatabaseConnexion.DatabaseConnection;
import com.example.pharmagest.vente.vente;
import com.example.pharmagest.medicaments.Medicament;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class venteModele {

    // Récupère toutes les ventes
    public ObservableList<vente> getAllVentes() {
        ObservableList<vente> ventesList = FXCollections.observableArrayList();
        String query = "SELECT * FROM vente";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                vente vente = new vente();
                vente.setId(rs.getInt("id"));
                vente.setNoVente(rs.getInt("no_vente"));
                vente.setDateVente(rs.getDate("date_vente"));
                vente.setTypeVente(rs.getString("type_vente"));
                vente.setPrixTotal(rs.getDouble("prix_total"));
                vente.setStatutVente(rs.getString("statut_vente"));
                vente.setUtilisateurId(rs.getInt("utilisateur_id"));
                ventesList.add(vente);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ventesList;
    }

    // Récupère la liste des médicaments associés à une vente donnée
    public ObservableList<Medicament> getMedicamentsByVenteId(int venteId) {
        ObservableList<Medicament> medicamentsList = FXCollections.observableArrayList();
        String query = "SELECT " +
                "    M.nom AS nom_medicament, " +
                "    LV.quantite, " +
                "    LV.prix_unitaire " +
                "FROM LigneVente LV " +
                "JOIN Medicament M ON LV.medicament_id = M.id " +
                "JOIN Vente V ON LV.vente_id = V.id " +
                "WHERE V.id = " + venteId;


        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()){
                Medicament med = new Medicament();
                med.setNom(rs.getString("nom_medicament"));
                med.setStock(rs.getInt("quantite"));
                med.setPrixVente(rs.getDouble("prix_unitaire"));
                medicamentsList.add(med);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return medicamentsList;
    }
}
