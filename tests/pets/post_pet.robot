Language: pt-br
*** Settings ***
Documentation    Suite responsável por validar o endpoint de Adição de Pets na API Petstore.
...              Inclui geração dinâmica de dados e verificação completa do payload de resposta.

Resource    ../../resources/keywords.robot
Resource    ../../resources/assertions.robot


*** Test Cases ***
1 - Adicionar novo pet com Status disponivel com sucesso
    [Documentation]    Realiza a adição de um novo pet com status disponivel, com dados dinâmicos e faz a validação do Staus Code e o corpo da resposta.
    [Tags]    1    pet    positive

    ${petData}    Dado que possua dados para cadastrar um novo pet     ${AVAILABLE} 

    ${response}   Quando submeto o cadastro    ${petData}    

    Então devo validar os dados com sucesso    ${response}        ${petData}    ${AVAILABLE}

2 - Adicionar novo pet com Status pendente com sucesso
    [Documentation]    Realiza a adição de um novo pet com status pendente, com dados dinâmicos e faz a validação do Staus Code e o corpo da resposta.
    [Tags]    2    pet    positive

    ${petData}    Dado que possua dados para cadastrar um novo pet    ${PENDING}      

    ${response}   Quando submeto o cadastro    ${petData}

    Então devo validar os dados com sucesso    ${response}        ${petData}    ${PENDING}

3 - Adicionar novo pet com Status vendido com sucesso
    [Documentation]    Realiza a adição de um novo pet com status vendido, com dados dinâmicos e faz a validação do Staus Code e o corpo da resposta.
    [Tags]    3    pet    positive

    ${petData}    Dado que possua dados para cadastrar um novo pet    ${SOLD}      

    ${response}   Quando submeto o cadastro    ${petData}

    Então devo validar os dados com sucesso    ${response}        ${petData}    ${SOLD}

4 - Adicionar novo pet com campo photos_urls vazio
    [Documentation]    Realiza a adição de um novo pet com status pendente e campo Photos_Url Vazio e faz a validação da resposta
    [Tags]    4    pet    positive

    ${petData}    Dado que possua dados para cadastrar um novo pet    ${PENDING}            

    ${response}   Quando submeto o cadastro com o campo "photos_urls" vazio     ${petData}   

    Então devo validar o campo "photos_urls" vazio no payload de resposta    ${response}        ${petData}        

5 - Adicionar novo pet com campo Tags vazio
    [Documentation]    Realiza a adição de um novo pet com status pendente e campo Tags Vazio e faz a validação da resposta
    [Tags]    5    pet    positive

    ${petData}    Dado que possua dados para cadastrar um novo pet    ${PENDING}            

    ${response}   Quando submeto o cadastro com o campo "tags" vazio     ${petData}   

    Então devo validar o campo "tags" vazio no payload de resposta    ${response}        ${petData}  

6 - Adicionar novo pet com campo Category vazio
    [Documentation]    Realiza a adição de um novo pet com status pendente e campo Category Vazio e faz a validação da resposta
    [Tags]    6    pet    positive

    ${petData}    Dado que possua dados para cadastrar um novo pet    ${PENDING}            

    ${response}   Quando submeto o cadastro com o campo "category" vazio     ${petData}   

    Então devo validar o campo "category" vazio no payload de resposta    ${response}        ${petData}           


