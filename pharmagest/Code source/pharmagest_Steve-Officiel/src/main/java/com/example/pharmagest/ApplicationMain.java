package com.example.pharmagest;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;
import javafx.stage.StageStyle;

import java.io.IOException;

public class ApplicationMain extends Application {
    @Override
    public void start(Stage stage) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(ApplicationMain.class.getResource("view-login/Login.fxml"));
        Scene scene = new Scene(fxmlLoader.load(), 1366, 764);
        stage.setTitle("PharmaGest");
        // Retirer la ligne suivante pour avoir les boutons de réduction et de fermeture
        // stage.initStyle(StageStyle.UNDECORATED);
        stage.setScene(scene);
        stage.setMaximized(true); // Met la fenêtre en plein écran
        stage.setResizable(true); // Permet le redimensionnement
        stage.show();
    }

    public static void main(String[] args) {
        launch();
    }
}
