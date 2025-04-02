package com.example.pharmagest.MajPrix;

public class majPrix {
    private int id;
    private String nom;
    private double prixAchat;
    private double prixVente;
    private int stock;
    private int seuilAlerte;
    private boolean necessitePrescription;
    private int fournisseurId;
    private String famille;
    private String unite;
    private String formeMedicament;

    // Constructeur vide
    public majPrix() {
    }

    // Constructeur avec tous les paramètres
    public majPrix(int id, String nom, double prixAchat, double prixVente, int stock, int seuilAlerte,
                   boolean necessitePrescription, int fournisseurId, String famille, String unite, String formeMedicament) {
        this.id = id;
        this.nom = nom;
        this.prixAchat = prixAchat;
        this.prixVente = prixVente;
        this.stock = stock;
        this.seuilAlerte = seuilAlerte;
        this.necessitePrescription = necessitePrescription;
        this.fournisseurId = fournisseurId;
        this.famille = famille;
        this.unite = unite;
        this.formeMedicament = formeMedicament;
    }

    // Getters et Setters
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }
    public void setNom(String nom) {
        this.nom = nom;
    }

    public double getPrixAchat() {
        return prixAchat;
    }
    public void setPrixAchat(double prixAchat) {
        this.prixAchat = prixAchat;
    }

    public double getPrixVente() {
        return prixVente;
    }
    public void setPrixVente(double prixVente) {
        this.prixVente = prixVente;
    }

    public int getStock() {
        return stock;
    }
    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getSeuilAlerte() {
        return seuilAlerte;
    }
    public void setSeuilAlerte(int seuilAlerte) {
        this.seuilAlerte = seuilAlerte;
    }

    public boolean isNecessitePrescription() {
        return necessitePrescription;
    }
    public void setNecessitePrescription(boolean necessitePrescription) {
        this.necessitePrescription = necessitePrescription;
    }

    public int getFournisseurId() {
        return fournisseurId;
    }
    public void setFournisseurId(int fournisseurId) {
        this.fournisseurId = fournisseurId;
    }

    public String getFamille() {
        return famille;
    }
    public void setFamille(String famille) {
        this.famille = famille;
    }

    public String getUnite() {
        return unite;
    }
    public void setUnite(String unite) {
        this.unite = unite;
    }

    public String getFormeMedicament() {
        return formeMedicament;
    }
    public void setFormeMedicament(String formeMedicament) {
        this.formeMedicament = formeMedicament;
    }
}
