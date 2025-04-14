-- Création des tables
CREATE TABLE Utilisateur (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    identifiant VARCHAR(255) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    numero VARCHAR(255),
    motDePasse VARCHAR(255) NOT NULL,
    statut VARCHAR(255) NOT NULL
);

CREATE TABLE Fournisseur (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255) UNIQUE NOT NULL,
    adresse TEXT,
    contact VARCHAR(255)
);

CREATE TABLE Medicament (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prix_achat DECIMAL(10,2) NOT NULL,
    prix_vente DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL CHECK (stock >= 0),
    seuil_alerte INT NOT NULL CHECK (seuil_alerte >= 0),
    quantite_max INT NOT NULL CHECK (quantite_max >= 0),
    necessite_prescription BOOLEAN NOT NULL,
    forme_medicament VARCHAR(255),
    famille VARCHAR(255),
    dosage VARCHAR(50),
    fournisseur_id INT
);

-- Création des tables modifiées
CREATE TABLE Commande (
    id SERIAL PRIMARY KEY,
    no_commande INT UNIQUE NOT NULL,
    date_commande DATE NOT NULL,
    prix_total DECIMAL(10,2) NOT NULL,
    fournisseur_id INT NOT NULL REFERENCES Fournisseur(id),
    utilisateur_id INT NOT NULL REFERENCES Utilisateur(id),
    statut VARCHAR(20) NOT NULL
);

CREATE TABLE LigneCommande (
    id SERIAL PRIMARY KEY,
    commande_id INT NOT NULL REFERENCES Commande(id), 
    medicament_id INT REFERENCES Medicament(id),
    quantites INT NOT NULL CHECK (quantites > 0),
    prix_achat DECIMAL(10,2) NOT NULL
);

CREATE TABLE Livraison (
    id SERIAL PRIMARY KEY,
    date_livraison DATE NOT NULL,
    status VARCHAR(255) NOT NULL,
    commande_id INT NOT NULL REFERENCES Commande(no_commande)
);

CREATE TABLE Vente (
    id SERIAL PRIMARY KEY,
    no_vente INT UNIQUE NOT NULL,
    date_vente DATE NOT NULL,
    type_vente VARCHAR(25) NOT NULL,
    prix_total DECIMAL(10,2) NOT NULL,
    statut_vente VARCHAR(25) NOT NULL,
    utilisateur_id INT NOT NULL REFERENCES Utilisateur(id)
);

-- La table Prescription est créée ici pour pouvoir référencer dans LigneVente
CREATE TABLE Prescription (
    id SERIAL PRIMARY KEY,
    numero_prescription VARCHAR(255) UNIQUE NOT NULL,
    nom_medecin VARCHAR(255) NOT NULL,
    date_prescription DATE NOT NULL,
    nom_patient VARCHAR(255) NOT NULL,
    medicament VARCHAR(500) NOT NULL
);

-- Modification de la table LigneVente pour inclure un champ de type de vente
CREATE TABLE LigneVente (
    id SERIAL PRIMARY KEY,
    vente_id INT NOT NULL REFERENCES Vente(id),
    medicament_id INT REFERENCES Medicament(id),
    quantite INT NOT NULL CHECK (quantite > 0),
    prix_unitaire DECIMAL(10,2) NOT NULL,
    prescription_id INT REFERENCES Prescription(id),
    typeVente VARCHAR(25) NOT NULL
);

CREATE TABLE Facture (
    id SERIAL PRIMARY KEY,
    numero_facture INT UNIQUE NOT NULL,
    date_emission DATE NOT NULL,
    montant_total DECIMAL(10,2) NOT NULL,
    vente_id INT NOT NULL UNIQUE REFERENCES Vente(id)
);


CREATE TABLE Bilan (
    id SERIAL PRIMARY KEY,
    facture_id INT NOT NULL REFERENCES Facture(id),
    date_vente DATE NOT NULL,
    utilisateur_id INT NOT NULL REFERENCES Utilisateur(id)
);
