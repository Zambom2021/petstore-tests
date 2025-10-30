
*** Settings ***
Library    RequestsLibrary
Library    ../resources/utils.py
Library    ../resources/categories.py
Library    Collections
Resource   variables.robot

*** Keywords ***
Create Petstore Session
    Create Session    petstore    ${BASE_URL}

Dado que possua Pets Cadastrados
    ${petData}    que possua dados para cadastrar um novo pet    ${AVAILABLE}        ${DOGS}    
      
que possua dados para cadastrar um novo pet
    [Arguments]    ${status}    ${petCategory}
    ${nomePet}=     Gera Pet Name
    ${petId}=       Gera Pet Id
    ${category}=    Get Category         ${petCategory}
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

submeto o cadastro com o campo "${data_EMPTY}" vazio 
    [Arguments]    ${petData}       
      
    IF     $data_EMPTY == "photos_urls"
        ${newPetData}=     Create Dictionary         
        ...    id=${petData["id"]}
        ...    name=${petData["name"]}
        ...    category=${petData["category"]}
        ...    tags=${petData["tags"]}
        ...    status=${PENDING} 

    ELSE IF     $data_EMPTY == "tags"
        ${newPetData}=     Create Dictionary  
        ...    id=${petData["id"]}
        ...    name=${petData["name"]}
        ...    category=${petData["category"]}
        ...    photoUrls=${petData["photoUrls"]}
        ...    status=${PENDING} 
    
    ELSE IF    $data_EMPTY == "category"
        ${invalid_category}=    Create Dictionary    id=    name=
        ${newPetData}=     Create Dictionary  
        ...    id=${petData["id"]}
        ...    name=${petData["name"]}
        ...    category=${invalid_category}
        ...    photoUrls=${petData["photoUrls"]}
        ...    tags=${petData["tags"]}
        ...    status=${PENDING} 
    END

    Create Petstore Session
    ${response}=    POST On Session    petstore    /pet    json=${newPetData}

    RETURN     ${response}      

consultar um pet pelo status
    [Arguments]    ${petStatus}

    Create Petstore Session
    ${response}=    GET On Session    petstore    url=/pet/findByStatus?status=${petStatus}    expected_status=anything   

    # Valida o Status Code da resposta
    Should Be Equal As Integers    ${response.status_code}           200   
    
    ${petsData}    Set Variable   ${response.json()}    

    RETURN     ${petsData} 

consultar o pet pelo ID
    [Arguments]    ${petId}

    Create Petstore Session
    ${response}=    GET On Session    petstore    url=/pet/${petId}     expected_status=anything 

    # Valida o Status Code da resposta
    Should Be Equal As Integers    ${response.status_code}           200   
    
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

que exista um pet cadastrado com Status
    [Arguments]      ${status}     ${category}     
    
    ${petData}    que possua dados para cadastrar um novo pet     ${status}    ${category}   

    ${response}   submeto o cadastro    ${petData} 

    RETURN     ${petData}
    
consultar o pet pela TAG
    [Arguments]    ${tag}

    Create Petstore Session
    ${headers}=    Create Dictionary    accept=application/json
    ${params}=     Create Dictionary    tags=${tag}

    ${response}=   GET On Session    petstore    url=/pet/findByTags    params=${params}    headers=${headers}    expected_status=anything

    Should Be Equal As Integers    ${response.status_code}    200

    ${petData}=    Set Variable    ${response.json()}
    RETURN    ${petData}