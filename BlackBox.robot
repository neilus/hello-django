*** Variables ***

${HOSTNAME}             127.0.0.1
${PORT}                 8000
${SERVER}               http://${HOSTNAME}:${PORT}/
${BROWSER}              firefox
${MYSITE}               hello


*** Settings ***
Documentation   Django Robot Tests
Library           Process
Library           SeleniumLibrary  timeout=10  implicit_wait=10
Suite Setup       Start Django and open Browser
# Suite Teardown    Terminate All Processes    kill=True
Suite Teardown    Stop Django and close Browser


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


*** Test Cases ***
Hello Django
    Go To  ${SERVER}
    # Wait until page contains element  id=explanation
    Page Should Contain  Hello
    Capture Page Screenshot
  
# Scenario: As a visitor I can visit the django default page
#   Go To  ${SERVER}
#   Wait until page contains element  id=explanation
#   Page Should Contain  It worked!
#   Page Should Contain  Congratulations on your first Django-powered page.