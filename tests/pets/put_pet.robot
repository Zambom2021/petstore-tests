Language: pt-br
*** Settings ***
Documentation    Suite responsável por validar o endpoint de Atualização de Pets na API Petstore.

Resource    ../../resources/keywords.robot
Resource    ../../resources/assertions.robot


*** Test Cases ***
1 - Alterar o status de pendente para disponível de um pet já existente
    [Documentation]    Realiza a alteração do status de um pet já cadastrado e faz a validação do Staus Code e o corpo da resposta.
    [Tags]    1    pet    positive

    ${petData}    Dado que exista um pet cadastrado com Status "pending"    

    ${respPetData}    E consulte o pet pelo ID    ${petData['id']}  

    ${response}   Quando submeto a alteração do status para "available"    ${respPetData}    

    Então devo validar a alteração com sucesso    ${response}        ${respPetData}    

2 - Alterar o status de disponivel para vendido de um pet já existente
    [Documentation]    Realiza a alteração do status de um pet já cadastrado e faz a validação do Staus Code e o corpo da resposta.
    [Tags]    2    pet    positive

    ${petData}    Dado que exista um pet cadastrado com Status "available"    

    ${respPetData}    E consulte o pet pelo ID    ${petData['id']}   

    ${response}   Quando submeto a alteração do status para "sold"    ${petData}    

    Então devo validar a alteração com sucesso    ${response}        ${respPetData}    
