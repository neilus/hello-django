*** Variables ***

${HOSTNAME}             127.0.0.1
${PORT}                 8000
${SERVER}               http://${HOSTNAME}:${PORT}
@{BROWSERS}              firefox     chrome
${MYSITE}               hello
${CWD}                  .


*** Settings ***
Documentation   Django Robot Tests
Library           Process
Library           SeleniumLibrary  timeout=10  implicit_wait=10
Suite Setup       Start Django
Suite Teardown    Terminate All Processes    kill=True
# Suite Teardown    Stop Django


*** Keywords ***
Start Django
    Run Process     python      manage.py       migrate
    # Run Process     python      manage.py       createsuperuser     --username admin    --noinput
    # This will require to give the password  trogh stdin:
    # Run Process     python      manage.py       changepassword      admin

    ${Django Server} =  Start Process   python manage.py runserver  shell=True  cwd=./
    Set Global Variable  ${Django Server}

Stop Django
    Terminate Process   ${Django Server}   kill=true


*** Test Cases ***

Test The Default Django Landing Page
    [Tags]  Headless    Skip
    Open Browser    ${SERVER}  headlesschrome
    Go To   ${SERVER}
    Page Should Contain     The install worked successfully
    Capture Page Screenshot
    Close Browser
    
Test On Mac Specific Browsers
    [Tags]  MacOS  Head-On  Skip
    Pass Execution If  sys.platform != 'darwin'  'MacOs'
    Hello Django    safari     ${SERVER}

Test On Windows Specific Browsers
    [Tags]  Windows  Head-On  Skip
    Pass Execution If  sys.platform == 'win32'   'Windows'
    Hello Django    edge     ${SERVER}

Check The Admin Interface Login Page
    [Tags]  Headless
    Given Open Browser    browser=headlesschrome
    
    When Go To   ${SERVER}/admin
    And Capture Page Screenshot
    
    Then Page Should Contain     Django administration
    And Page Should Contain Button   Log in
    And Page Should Contain Textfield   username
    And Page Should Contain Textfield   password
    
    Close Browser

Attempt To Log In With Default Credentials On The Admin Interface Login Page
    [Tags]  Headless
    Given Open Browser    browser=headlesschrome
    And Go To   ${SERVER}/admin
    
    When Input Text         username    admin
    And Input Password      password    admin
    And Capture Page Screenshot
    And Click Button        Log in

    Then Wait Until Location Is Not     ${SERVER}/admin
    And Page Should Not Contain      OperationalError
    Close Browser
