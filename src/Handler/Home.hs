{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Home where

import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)

getHomeR :: Handler Html
getHomeR = do
    sess <- lookupSession "_ID"
    defaultLayout $ do
        addStylesheet $ StaticR css_bootstrap_css
        [whamlet|
            $maybe sessao <- sess
                <h3>Gestão de bibliotecas
                <br>
                Ola #{sessao}
                <br>
            $nothing
                <h3>Gestão de bibliotecas
                <br>
            <ul>
                    <br>
                    <h4>------- Funcionário ---------
                <li>
                    <a href=@{FuncionarioR}>
                        Cadastro de Funcionario
                <li>
                    <a href=@{TodosFuncionariosR}>
                        Listar Funcionarios
                    <br>
                    <h4>------- Clientes ---------
                <li>
                    <a href=@{ClienteR}>
                        Cadastro de Cliente
                <li>
                    <a href=@{TodosClientesR}>
                        Listar Clientes
                    <br>
                    <h4>------- Login/Logout -------
                $maybe _ <- sess
                    <form action=@{LogoutR} method=post>
                        <input type="submit" value="Sair">
                $nothing
                    <a href=@{LoginR}>
                        Entrar
        |] 
