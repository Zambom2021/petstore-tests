
*** Settings ***
Library    RequestsLibrary
Library    ../resources/utils.py
Library    Collections
Resource   variables.robot

*** Keywords ***
Create Petstore Session
    Create Session    petstore    ${BASE_URL}

que possua dados para cadastrar um novo pet
    [Arguments]    ${status}
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
    ...    status=${status}

    RETURN    ${petData}

submeto o cadastro 
    [Arguments]    ${petData} 

    Create Petstore Session
    ${response}=    POST On Session    petstore    /pet    json=${petData}

    RETURN     ${response}        

que consulte um pet já existente pelo status
    [Arguments]    ${petStatus}

    Create Petstore Session
    ${response}=    GET On Session    petstore    url=/pet/findByStatus?status=${petStatus}  
    
    ${petData}    Get From List    ${response.json()}    0

    RETURN     ${petData} 

consulte o pet pelo ID
    [Arguments]    ${petId}

    Create Petstore Session
    ${response}=    GET On Session    petstore    url=/pet/${petId}  
    
    ${petData}    Set Variable    ${response.json()}    

    RETURN     ${petData} 


submeto a alteração do status para "${status}"
    [Arguments]    ${petData}    

    ${newPetData}=     Create Dictionary
    ...    id=${petData["id"]}
    ...    name=${petData["name"]}
    ...    category=${petData["category"]}
    ...    photoUrls=${petData["photoUrls"]}
    ...    tags=${petData["tags"]}
    ...    status=${status}

    Create Petstore Session
    ${response}=    PUT On Session    petstore    /pet    json=${newPetData}

    RETURN     ${response}


que exista um pet cadastrado com Status "${status}" 
    # [Arguments]    ${status}
    
    ${petData}    que possua dados para cadastrar um novo pet     ${status} 

    ${response}   submeto o cadastro    ${petData} 

    RETURN     ${petData}
    
