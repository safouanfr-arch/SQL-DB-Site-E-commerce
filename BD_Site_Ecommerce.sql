CREATE TABLE Tdemande_adhesion(
   Id_demande_adhesion COUNTER,
   email_dem VARCHAR(100) NOT NULL,
   nom_dem VARCHAR(50) NOT NULL,
   prenom_dem VARCHAR(50) NOT NULL,
   message_dem VARCHAR(250) NOT NULL,
   statut_dem VARCHAR(8) NOT NULL,
   Ddecision_dem DATETIME NOT NULL,
   Dinscription_dem DATETIME NOT NULL,
   PRIMARY KEY(Id_demande_adhesion),
   UNIQUE(email_dem)
);

CREATE TABLE Tmembre(
   Id_membre COUNTER,
   email_mem VARCHAR(100) NOT NULL,
   mdp_mem VARCHAR(250) NOT NULL,
   nom_mem VARCHAR(50) NOT NULL,
   prenom_mem VARCHAR(50) NOT NULL,
   statut_mem VARCHAR(8) NOT NULL,
   Dvalidation_mem DATETIME NOT NULL,
   Dcreation_mem DATETIME NOT NULL,
   Dlogin_mem DATETIME NOT NULL,
   Id_demande_adhesion INT NOT NULL,
   PRIMARY KEY(Id_membre),
   UNIQUE(Id_demande_adhesion),
   UNIQUE(email_mem),
   FOREIGN KEY(Id_demande_adhesion) REFERENCES Tdemande_adhesion(Id_demande_adhesion)
);

CREATE TABLE Tpoint_collecte(
   Id_point_collecte COUNTER,
   nom_point VARCHAR(50) NOT NULL,
   adresse_point VARCHAR(100) NOT NULL,
   cp_point INT NOT NULL,
   ville_point VARCHAR(100) NOT NULL,
   infos_point VARCHAR(250),
   actif_point LOGICAL NOT NULL,
   PRIMARY KEY(Id_point_collecte)
);

CREATE TABLE Tcreneau_collecte(
   Id_creneau_collecte COUNTER,
   Date_cren DATETIME NOT NULL,
   heured_cren TIME NOT NULL,
   heuref_cren TIME NOT NULL,
   actif_cren LOGICAL NOT NULL,
   Id_point_collecte INT,
   PRIMARY KEY(Id_creneau_collecte),
   FOREIGN KEY(Id_point_collecte) REFERENCES Tpoint_collecte(Id_point_collecte)
);

CREATE TABLE Tcategorie(
   Id_categorie COUNTER,
   nom_cat VARCHAR(100) NOT NULL,
   actif_cat LOGICAL NOT NULL,
   PRIMARY KEY(Id_categorie),
   UNIQUE(nom_cat)
);

CREATE TABLE Tproduit(
   Id_produit COUNTER,
   nom_pro VARCHAR(100) NOT NULL,
   description_pro VARCHAR(500) NOT NULL,
   tva_pro DECIMAL(5,2) NOT NULL,
   Dperemption_pro DATE NOT NULL,
   bio_pro LOGICAL NOT NULL,
   vege_pro LOGICAL NOT NULL,
   vegan_pro LOGICAL NOT NULL,
   actif_pro LOGICAL NOT NULL,
   montantHT_pro CURRENCY NOT NULL,
   Id_categorie INT NOT NULL,
   PRIMARY KEY(Id_produit),
   UNIQUE(nom_pro),
   FOREIGN KEY(Id_categorie) REFERENCES Tcategorie(Id_categorie)
);

CREATE TABLE Tphoto_produit(
   Id_photo_produit COUNTER,
   url_photo VARCHAR(250),
   Id_produit INT NOT NULL,
   PRIMARY KEY(Id_photo_produit),
   FOREIGN KEY(Id_produit) REFERENCES Tproduit(Id_produit)
);

CREATE TABLE Tpromotion(
   Id_promotion COUNTER,
   titre_promo VARCHAR(250) NOT NULL,
   valeur_promo DECIMAL(5,2) NOT NULL,
   description_promo VARCHAR(250),
   type_promo VARCHAR(20) NOT NULL,
   debut_promo DATETIME NOT NULL,
   fin_promo DATETIME NOT NULL,
   PRIMARY KEY(Id_promotion)
);

CREATE TABLE Tstock(
   Id_stock COUNTER,
   quantite_stock INT NOT NULL,
   Id_produit INT NOT NULL,
   PRIMARY KEY(Id_stock),
   UNIQUE(Id_produit),
   FOREIGN KEY(Id_produit) REFERENCES Tproduit(Id_produit)
);

CREATE TABLE Tcommande(
   Id_commande COUNTER,
   numero_com VARCHAR(20) NOT NULL,
   statut_com VARCHAR(20) NOT NULL,
   paiement_com VARCHAR(10) NOT NULL,
   totalHT_com CURRENCY NOT NULL,
   totalTTC_com CURRENCY NOT NULL,
   totalTVA_com CURRENCY NOT NULL,
   Dannulee_com DATETIME NOT NULL,
   Dplacee_com DATETIME NOT NULL,
   Dcree_com DATETIME NOT NULL,
   Id_creneau_collecte INT NOT NULL,
   Id_membre INT NOT NULL,
   PRIMARY KEY(Id_commande),
   UNIQUE(numero_com),
   FOREIGN KEY(Id_creneau_collecte) REFERENCES Tcreneau_collecte(Id_creneau_collecte),
   FOREIGN KEY(Id_membre) REFERENCES Tmembre(Id_membre)
);

CREATE TABLE Tligne_commande(
   Id_ligne_commande COUNTER,
   quantite_lgncom INT NOT NULL,
   prixuniHT_lgncom CURRENCY NOT NULL,
   totalHT_lgncom CURRENCY NOT NULL,
   totalTVA_lgncom CURRENCY NOT NULL,
   totalTTC_lgncom CURRENCY NOT NULL,
   nomS_lgncom VARCHAR(100) NOT NULL,
   tvaS_lgncom DECIMAL(5,2) NOT NULL,
   Id_promotion INT,
   Id_produit INT NOT NULL,
   Id_commande INT NOT NULL,
   PRIMARY KEY(Id_ligne_commande),
   FOREIGN KEY(Id_promotion) REFERENCES Tpromotion(Id_promotion),
   FOREIGN KEY(Id_produit) REFERENCES Tproduit(Id_produit),
   FOREIGN KEY(Id_commande) REFERENCES Tcommande(Id_commande)
);

CREATE TABLE Temail(
   Id_email COUNTER,
   type_mail VARCHAR(30) NOT NULL,
   destinataire_mail VARCHAR(100) NOT NULL,
   Denvoi_mail DATETIME NOT NULL,
   Id_membre INT NOT NULL,
   Id_commande INT NOT NULL,
   Id_demande_adhesion INT NOT NULL,
   PRIMARY KEY(Id_email),
   FOREIGN KEY(Id_membre) REFERENCES Tmembre(Id_membre),
   FOREIGN KEY(Id_commande) REFERENCES Tcommande(Id_commande),
   FOREIGN KEY(Id_demande_adhesion) REFERENCES Tdemande_adhesion(Id_demande_adhesion)
);

CREATE TABLE Tpromotion_produit(
   Id_produit INT,
   Id_promotion INT,
   PRIMARY KEY(Id_produit, Id_promotion),
   FOREIGN KEY(Id_produit) REFERENCES Tproduit(Id_produit),
   FOREIGN KEY(Id_promotion) REFERENCES Tpromotion(Id_promotion)
);

CREATE TABLE Tpromotion_categorie(
   Id_categorie INT,
   Id_promotion INT,
   PRIMARY KEY(Id_categorie, Id_promotion),
   FOREIGN KEY(Id_categorie) REFERENCES Tcategorie(Id_categorie),
   FOREIGN KEY(Id_promotion) REFERENCES Tpromotion(Id_promotion)
);