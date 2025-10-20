*** Settings ***
Resource    ../../resources/keywords.robot

*** Test Cases ***
Adicionar novo pet com sucesso
    [Tags]    pet    post
    Create Petstore Session
    ${body}=    Create Dictionary    id=12345    name=Rex    status=available
    ${response}=    POST On Session    petstore    /pet    json=${body}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Contain    ${response.text}    Rex
