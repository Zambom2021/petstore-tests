
*** Settings ***
Library    RequestsLibrary
Library    ../resources/utils.py
Library    Collections
Resource   variables.robot

*** Keywords ***
Create Petstore Session
    Create Session    petstore    ${BASE_URL}

que possua dados para cadastrar um novo pet
    ${nomePet}=     Gera Pet Name
    ${petId}=       Gera Pet Id
    ${category}=    Create Dictionary    id=1    name=Dogs
    ${photoUrl}=    Gera Foto Url        ${nomePet}    
    ${photoUrls}=   Create List          ${photoUrl}
    ${tags}=        Gera Tags          

    ${petData}=     Create Dictionary
    ...    id=${petId}
    ...    name=${nomePet}
    ...    category=${category}
    ...    photoUrls=${photoUrls}
    ...    tags=${tags}
    ...    status=available

    RETURN    ${petData}

submeto o request do cadastro 
    [Arguments]    ${petData} 

    Create Petstore Session
    ${response}=    POST On Session    petstore    /pet    json=${petData}

    RETURN     ${response}        
