Language: pt-br
*** Settings ***
Documentation    Suite responsável por validar o endpoint de Exclusão (delete) de Pets na API Petstore.

Resource    ../../resources/keywords.robot
Resource    ../../resources/assertions.robot

*** Test Cases ***
1 - Deve Consultar lista de Pets pelo Status Pendente
    [Documentation]    Realiza a Consulta de Pets pelo Status Pendente e faz a validação do corpo da resposta.
    [Tags]    1    pet    positive

    ${petData}    Dado que exista um pet cadastrado com Status     ${AVAILABLE}    ${DOGS}    

    ${respMessage}    Quando executo a exclusao do pet pelo ID    ${petData['id']}  

    Então devo validar a a exclusao com sucesso     ${respMessage}        

