***Settings***
Documentation        Teste para verifficar o Slogan da Smartbit na web app

Library        Browser

*** Test Cases***
Deve exibir o Slagan na Landing Page
    New Browser    browser=chromium   headless=False   
    New Page    http://localhost:3000
    Get Text    css=.headline h2    equal    Sua Jornada Fitness Começa aqui!

    Sleep    5

    