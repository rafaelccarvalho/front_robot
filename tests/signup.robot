*** Settings ***
Documentation    Cenario de testes de pré cadastro de clientes

Library        Browser
Library    ../resources/libs/Account.py

Resource    ../resources/base.resource

*** Test Cases ***
Deve iniciar o cadastro do cliente

    ${account}    Get Fake Account

    Start session
    Submit signup form        ${account}

    Wait For Elements State
    ...    text=Falta pouco para fazer parte da família Smartbit!
    ...    visible    5


Campo nome deve ser obrigatório
    [Tags]    required

    ${account}        Create Dictionary
    ...    name=${EMPTY}
    ...    email=casito@gmail.com
    ...    cpf=22318672067

    Start session
    Submit signup form        ${account}
    Notice should be          Por favor informe o seu nome completo

Campo email deve ser obrigatório
    [Tags]    required

    ${account}        Create Dictionary
    ...    name=Casito
    ...    email=${EMPTY}
    ...    cpf=22318672067

    Start session
    Submit signup form    ${account}

    #verificação
    Wait For Elements State
    ...    css=form .notice
    ...    visible    5
    
    Get Text    css=form .notice    equal    Por favor, informe o seu melhor e-mail


Campo cpf deve ser obrigatório
    [Tags]    required

    ${account}        Create Dictionary
    ...    name=Casito
    ...    email=casito@gmail.com
    ...    cpf=${EMPTY}

    Start session
    Submit signup form    ${account}
    Notice should be      Por favor, informe o seu CPF

Email no formato invalido
    [Tags]    inv

    ${account}        Create Dictionary
    ...    name=Casito
    ...    email=casito*gmail.com
    ...    cpf=32843069009

    Start session
    Submit signup form    ${account}

    Notice should be      Oops! O email informado é inválido 

Cpf no formato inválido
    [Tags]    inv

    ${account}        Create Dictionary
    ...    name=Casito
    ...    email=casito@gmail.com
    ...    cpf=3284306900a

    Start session
    Submit signup form    ${account}
    Notice should be      Oops! O CPF informado é inválido
   

***Keywords***
Start session
    New Browser    browser=chromium   headless=False   
    New Page       http://localhost:3000
Submit signup form
    [Arguments]        ${account}
    Get Text
    ...    css=#signup h2
    ...    equal
    ...    Faça seu cadastro e venha para a Smartbit!

    Fill Text    id=name        ${account}[name]
    Fill Text    id=email       ${account}[email]
    Fill Text    id=cpf         ${account}[cpf]

    Click    css=button >> text=Cadastrar

Notice should be 
    [Arguments]        ${target}

    ${element}        Set Variable        css=form .notice

    Wait For Elements State
    ...    ${element}
    ...    visible    5
    
    Get Text    ${element}    equal    ${target}
   
      
