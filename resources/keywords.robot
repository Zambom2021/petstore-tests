*** Settings ***
Library    RequestsLibrary
Resource   variables.robot

*** Keywords ***
Create Petstore Session
    Create Session    petstore    ${BASE_URL}
