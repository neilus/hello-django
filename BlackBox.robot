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
    Terminate Process   ${Django Server}   kill=true

Start Django and open Browser
    Start Django
    Open Browser  ${SERVER}  ${BROWSER}

Stop Django and close browser
    Close Browser
    Stop Django

Hello Django
    [Documentation]     Test the hello website with a browser given
    [Arguments]     ${BROWSER}= firefox     ${WEBPAGE}= ${SERVER}
    Open Browser    ${WEBPAGE}  ${BROWSER}
    Go To  ${WEBPAGE}
    # Wait until page contains element  id=explanation
    Page Should Contain  Hello
    Capture Page Screenshot
    Close Browser

*** Test Cases ***
Hello From Headless Firefox
    [Tags]  Skip  Headless
    Start Django
    Open Browser    ${SERVER}  headlessfirefox
    Go To   ${SERVER}
    Page Should Contain     Hello
    Capture Page Screenshot
    Close Browser

Hello From Headless Chrome
    [Tags]  Mandatory  Headless
    Start Django
    Open Browser    ${SERVER}  headlesschrome
    Go To   ${SERVER}
    Page Should Contain     Hello
    Capture Page Screenshot
    Close Browser

Test On The Mandatory Browsers
    [Tags]  Mandatory  Head-On  Skip
    [Template]  Hello Django
    headlessfirefox          ${SERVER}
    headlesschrome           ${SERVER}
    firefox                  ${SERVER}
    chrome                   ${SERVER}

Test On Mac Specific Browsers
    [Tags]  MacOS  Head-On
    Pass Execution If  sys.platform != 'darwin'  'MacOs'
    Hello Django    safari     ${SERVER}

Test On Windows Specific Browsers
    [Tags]  Windows  Head-On
    Pass Execution If  sys.platform == 'win32'   'Windows'
    Hello Django    edge     ${SERVER}
        