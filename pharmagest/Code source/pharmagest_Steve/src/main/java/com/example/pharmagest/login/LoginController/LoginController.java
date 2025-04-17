package com.example.pharmagest.login.LoginController;

import com.example.pharmagest.login.LoginModele.LoginConnexion;
import com.example.pharmagest.login.login;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.io.IOException;
import java.util.Objects;

public class LoginController {

    @FXML
    private TextField identifiantTextField;

    @FXML
    private PasswordField motdepassePasswordField;

    @FXML
    private Button loginOnAction;

    @FXML
    private Button cancelOnAction;

    @FXML
    private Label loginMessageLabel;

    private final LoginConnexion loginConnexion = new LoginConnexion();

    @FXML
    public void loginButtonOnAction(ActionEvent e) {
        login user = new login();
        user.setUsername(identifiantTextField.getText());
        user.setPassword(motdepassePasswordField.getText());

        Stage stage = (Stage) loginOnAction.getScene().getWindow();

        if (!user.getUsername().isBlank() && !user.getPassword().isBlank()) {
            boolean loginSuccessful = loginConnexion.validateLogin(user, loginMessageLabel, stage);
            if (loginSuccessful) {
                // Redirection vers le tableau de bord après validation réussie
                try {
                    Parent dashboardRoot = FXMLLoader.load(Objects.requireNonNull(getClass().getResource("/com/example/pharmagest/view-dashboard/Dashboard.fxml")));
                    Stage currentStage = (Stage) ((Node) e.getSource()).getScene().getWindow();
                    Scene dashboardScene = new Scene(dashboardRoot);

                    currentStage.setScene(dashboardScene);
                    currentStage.setMaximized(true); // Maximiser la fenêtre
                    currentStage.show();
                } catch (IOException ioException) {
                    ioException.printStackTrace();
                }
            } else {
                System.out.println("Connexion refusée.");
            }
        } else {
            loginMessageLabel.setText("Veuillez entrer un identifiant et un mot de passe !");
        }
    }


    @FXML
    public void cancelButtonOnAction(ActionEvent e) {
        Stage stage = (Stage) cancelOnAction.getScene().getWindow();
        stage.close();
    }
}
