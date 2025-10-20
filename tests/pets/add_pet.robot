Language: pt-br
*** Settings ***
Documentation    Suite responsável por validar o endpoint de cadastro de Pets na API Petstore.
...              Inclui geração dinâmica de dados e verificação completa do payload de resposta.

Resource    ../../resources/keywords.robot
Resource    ../../resources/assertions.robot


*** Test Cases ***
1 - Adicionar novo pet com sucesso
    [Documentation]    Realiza a adição de um novo pet, com dados dinâmicos e faz a validação do Staus Code e o corpo da resposta.
    [Tags]    1    pet    positive

    ${petData}    Dado que possua dados para cadastrar um novo pet  

    ${response}   Quando submeto o request do cadastro    ${petData}

    Então devo validar a adicao com sucesso    ${response}        ${petData}

