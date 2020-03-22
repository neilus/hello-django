*** Variables ***

${HOSTNAME}             127.0.0.1
${PORT}                 8000
${SERVER}               http://${HOSTNAME}:${PORT}/
@{BROWSERS}              firefox     chrome
${MYSITE}               hello


*** Settings ***
Documentation   Django Robot Tests
Library           Process
Library           SeleniumLibrary  timeout=10  implicit_wait=10
Suite Setup       Start Django
# Suite Teardown    Terminate All Processes    kill=True
Suite Teardown    Stop Django



*** Keywords ***
Start Django
    ${Django Server} =  Start Process   python manage.py runserver  shell=True  cwd=./
    Set Global Variable  ${Django Server}
Stop Django
    # Terminate All Processes    kill=True
    Terminate Process   ${Django Server}   kill=true
Start Django and open Browser
    Start Django
    Open Browser  ${SERVER}  ${BROWSER}

Stop Django and close browser
    Close Browser
    Stop Django

Hello Django
    [Documentation]     Test the hello website with a browser given
    [Arguments]     ${BROWSER}=firefox
    Open Browser    ${SERVER} ${BROWSER}
    Go To  ${SERVER}
    # Wait until page contains element  id=explanation
    Page Should Contain  Hello
    Capture Page Screenshot
    Close Browser

*** Test Cases ***
Hello From Firefox
    Start Django
    Open Browser    ${SERVER}  firefox
    Go To   ${SERVER}
    Page Should Contain     Hello
    Capture Page Screenshot
    Close Browser

Hello From Chrome
    Start Django
    Open Browser    ${SERVER}  chrome
    Go To   ${SERVER}
    Page Should Contain     Hello
    Capture Page Screenshot
    Close Browser

Hello Django from each browser
    [Template]  Hello Django
    firefox
    chrome
    # safari