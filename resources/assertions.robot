*** Settings ***
Library    JSONLibrary

*** Keywords ***
devo validar os dados com sucesso   
    [Documentation]     Valida o payload de resposta 
    [Arguments]     ${response}    ${petData}    ${status}
    
    # Valida cada campo
    Should Be Equal As Integers         ${response["id"]}                   ${petData['id']}
    Should Be Equal                     ${response["name"]}                 ${petData['name']}   
    Should Be Equal                     ${response["photoUrls"][0]}         ${petData['photoUrls'][0]}
    Should Be Equal As Integers         ${response["tags"][0]["id"]}        ${petData['tags'][0]['id']}
    Should Be Equal                     ${response["tags"][0]["name"]}      ${petData['tags'][0]['name']}
    Should Be Equal As Integers         ${response["category"]["id"]}       ${petData['category']['id']}
    Should Be Equal                     ${response["category"]["name"]}     ${petData['category']['name']}    
    Should Be Equal                     ${response["status"]}               ${status}

devo validar o campo "${data_empty}" vazio no payload de resposta
    [Documentation]     Valida o campo vazio no payload de resposta e o status code
    [Arguments]     ${response}    ${petData}    
    
    # Pega os dados do response
    ${response_json}=   Set Variable    ${response.json()} 
    ${body_dict}=       Set Variable    ${response_json}

    # Valida statusCode
    Should Be Equal As Integers         ${response.status_code}      200
 
    # Valida cada campo
    Should Be Equal As Integers         ${body_dict["id"]}                   ${petData['id']}
    Should Be Equal                     ${body_dict["name"]}                 ${petData['name']} 

    IF    $data_empty == "photoUrls" 
        Should Be Empty                     ${body_dict["photoUrls"]}        []
    ELSE IF    $data_empty == "tags"
        Should Be Empty                     ${body_dict["tags"]}             []
    ELSE IF    $data_empty == "category"
        Should Be Equal                     ${body_dict["category"]["id"]}       ${0}
        Should Be Equal                     ${body_dict["category"]["name"]}     ${EMPTY}            
    END
    
devo validar a alteração do Status   
    [Documentation]     Valida o payload de resposta e o status code
    [Arguments]     ${response}    ${petData}    
    
    # Pega os dados do response
    ${response_json}=   Set Variable    ${response.json()} 
    ${body_dict}=       Set Variable    ${response_json}

    # Valida statusCode
    Should Be Equal As Integers         ${response.status_code}      200
 
    # Valida cada campo
    Should Be Equal As Integers       ${petData['id']}          ${body_dict["id"]}                   
    Should Be Equal                   ${petData['name']}        ${body_dict["name"]}                    
    Should Not Be Equal               ${petData['status']}      ${body_dict["status"]} 
    Should Be Equal As Integers       ${petData['id']}          ${body_dict["id"]}                   
    Should Be Equal                   ${petData['name']}        ${body_dict["name"]}                                


devo validar o payload de resposta  
    [Documentation]     Valida se o payload de resposta contem lista de Pets com o stuatus consultado
    [Arguments]     ${petsData}    ${status}    
    
    ${qtdPets}    Get Length    ${petsData}  

    # Faz um Loop para validar a quantidade e campos
    FOR     ${pet}     IN RANGE   ${qtdPets}                                   
        Should Be Equal           ${petsData[${pet}]['status']}        ${status} 
        Should Not Be Equal       ${petsData[${pet}]['id']}            0
        Should Not Be Empty       ${petsData[${pet}]['name']}
    END                  

devo validar o retorno com sucesso  
    [Documentation]     Valida o payload de resposta e o status code
    [Arguments]       ${response}    ${petData}    
     
    # Valida Campos
    Should Be Equal As Integers         ${response["id"]}                   ${petData['id']}
    Should Be Equal                     ${response["name"]}                 ${petData['name']}   
    Should Be Equal                     ${response["photoUrls"][0]}         ${petData['photoUrls'][0]}
    Should Be Equal As Integers         ${response["tags"][0]["id"]}        ${petData['tags'][0]['id']}
    Should Be Equal                     ${response["tags"][0]["name"]}      ${petData['tags'][0]['name']}
    Should Be Equal As Integers         ${response["category"]["id"]}       ${petData['category']['id']}
    Should Be Equal                     ${response["category"]["name"]}     ${petData['category']['name']}    
    Should Be Equal                     ${response["status"]}               ${petData['status']}

devo validar a TAG no payload de resposta  
    [Documentation]     Valida se o payload de resposta contem lista de Pets com o stuatus consultado
    [Arguments]     ${petsData}    ${tag}        
    
    ${qtdPets}    Get Length    ${petsData}  

    # Faz um Loop para validar a quantidade e campos
    FOR     ${pet}     IN RANGE   ${qtdPets}                                   
        Should Not Be Empty       ${petsData[${pet}]['status']}         
        Should Not Be Equal       ${petsData[${pet}]['id']}    0
        Should Not Be Empty       ${petsData[${pet}]['name']}
        
        ${qtdTags}    Get Length    ${petsData[${pet}]['tags']} 
        FOR  ${petTag}    IN RANGE   ${qtdTags}
            Should Be Equal       ${petsData[${pet}]['tags'][${petTag}]["name"]}    ${tag}
        END
    END                  

devo validar os dados alterados
    [Documentation]     Valida a alteração realizada
    [Arguments]     ${respUpdate}        ${petData}  
    
    # Valida cada campo
    Should Be Equal As Integers    ${petData['id']}         ${respUpdate["id"]} 
    Should Not Be Equal            ${petData['name']}       ${respUpdate["name"]}  
    Should Not Be Equal            ${petData['status']}     ${respUpdate["status"]} 

