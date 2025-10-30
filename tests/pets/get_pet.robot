Language: pt-br
*** Settings ***
Documentation    Suite responsável por validar o endpoint de Consultas de Pets na API Petstore.

Resource    ../../resources/keywords.robot
Resource    ../../resources/assertions.robot

Suite Setup      Dado que possua Pets Cadastrados

*** Test Cases ***
1 - Consulta lista de Pets pelo Status Pendente
    [Documentation]    Realiza a Consulta de Pets pelo Status Pendente e faz a validação do corpo da resposta.
    [Tags]    1    pet    positive

    ${respPetsData}    Quando consultar um pet pelo status    ${PENDING} 

    Então devo validar o payload de resposta    ${respPetsData}    ${PENDING}    

2 - Consulta lista de Pets pelo Status Vendido
    [Documentation]    Realiza a Consulta de Pets pelo Status Vendido e faz a validação do corpo da resposta.
    [Tags]    2    pet    positive 

    ${respPetsData}    Quando consultar um pet pelo status    ${SOLD}  

    Então devo validar o payload de resposta    ${respPetsData}    ${SOLD}    

3 - Consulta lista de Pets pelo Status Disponivel
    [Documentation]    Realiza a Consulta de Pets pelo Status Disponivel e faz a validação do corpo da resposta.
    [Tags]    3    pet    positive

    ${respPetsData}    Quando consultar um pet pelo status    ${AVAILABLE}     

    Então devo validar o payload de resposta    ${respPetsData}    ${AVAILABLE}   

4 - Consulta Pet pelo ID  
    [Documentation]    Realiza a Consulta de um  Pet pelo ID e faz a validação do corpo da resposta.
    [Tags]    4    pet    positive

    ${petData}    Dado que exista um pet cadastrado com Status     ${AVAILABLE}    ${DOGS}    

    ${respPetData}    Quando consultar o pet pelo ID    ${petData['id']}  

    Então devo validar o retorno com sucesso     ${respPetData}    ${petData}   

5 - Consulta Pet pelas TAGS  
    [Documentation]    Realiza a Consulta de um  Pet pelas TAGS e faz a validação do corpo da resposta.
    [Tags]    5    pet    positive

    ${respPetData}    Quando consultar o pet pela TAG   ${TAG_AMIG}

    Então devo validar a TAG no payload de resposta     ${respPetData}     ${TAG_AMIG}      


