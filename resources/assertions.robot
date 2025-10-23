*** Settings ***
Library    JSONLibrary

*** Keywords ***
devo validar os dados com sucesso   
    [Documentation]     Valida o payload de resposta e o status code
    [Arguments]     ${response}    ${petData}    ${status}
    
    # Pega os dados do response
    ${response_json}=   Set Variable    ${response.json()} 
    ${body_dict}=       Set Variable    ${response_json}

    # Valida statusCode
    Should Be Equal As Integers         ${response.status_code}      200
 
    # Valida cada campo
    Should Be Equal As Integers         ${body_dict["id"]}                   ${petData['id']}
    Should Be Equal                     ${body_dict["name"]}                 ${petData['name']}   
    Should Be Equal                     ${body_dict["photoUrls"][0]}         ${petData['photoUrls'][0]}
    Should Be Equal As Integers         ${body_dict["tags"][0]["id"]}        ${petData['tags'][0]['id']}
    Should Be Equal                     ${body_dict["tags"][0]["name"]}      ${petData['tags'][0]['name']}
    Should Be Equal As Integers         ${body_dict["category"]["id"]}       ${petData['category']['id']}
    Should Be Equal                     ${body_dict["category"]["name"]}     ${petData['category']['name']}    
    Should Be Equal                     ${body_dict["status"]}               ${status}

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
    Should Be Equal As Integers       ${petData['id']}                    ${body_dict["id"]}                   
    Should Be Equal                   ${petData['name']}                  ${body_dict["name"]}                    
    Should Not Be Equal               ${petData['status']}                ${body_dict["status"]}               