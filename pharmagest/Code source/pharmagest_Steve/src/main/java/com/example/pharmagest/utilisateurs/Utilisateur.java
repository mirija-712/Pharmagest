package com.example.pharmagest.utilisateurs;

public class Utilisateur {
    private int id;
    private String nom;
    private String prenom;
    private String identifiant;
    private String email;
    private String numero;
    private String motDePasse;

    // Constructeur avec ID (pour la modification ou suppression)
    public Utilisateur(int id, String nom, String prenom, String identifiant, String email, String numero, String motDePasse) {
        this.id = id;
        this.nom = nom;
        this.prenom = prenom;
        this.identifiant = identifiant;
        this.email = email;
        this.numero = numero;
        this.motDePasse = motDePasse;
    }

    // Getters
    public int getId() {
        return id;
    }

    public String getNom() {
        return nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public String getIdentifiant() {
        return identifiant;
    }

    public String getEmail() {
        return email;
    }

    public String getNumero() {
        return numero;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    // Setter pour le mot de passe (si nécessaire)
    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }
}
