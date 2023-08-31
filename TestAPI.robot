*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Library     JSONLibrary
Library     Collections
Library     DatabaseLibrary


***Test Cases ***
Test API Vulcan
    Exam Show Product
    Exam Search Product
    Exam Add Product
    Exan Delete Cart

***Keywords***
Exam Show Product
    ${req}  Create Dictionary    product_type=smartphone
    ${response}=    POST On Session        https://APILink.xxx.th/    /Showproduct    json=${req}
    ${output}=    Query    select product_name from product Where product_type='smartphone'
    Should Be Equal     ${output}     ${response.json()}[product_name]

Exam Search Product
    ${req}  Create Dictionary    product_name=iPhone14
    ${response}=    POST On Session        https://APILink.xxx.th/    /Showproduct/Searchproduct    json=${req}
    ${output}=    Query    select * from product Where product_name='iPhone14'
    Should Be Equal     ${output}     ${response.json()}

Exam Add Product
    ${req}  Create Dictionary    product_id=12345    quantity=1
    ${response}=    POST On Session        https://APILink.xxx.th/    /Showproduct/addCart    json=${req}
    Open Browser    http://Linkshoppage.com/cart     gc
    ${cartwebview}=    Get Text    id=product_id
    Should Be Equal    ${cartwebview}    12345
    ${output}=    Query    select product_id from cart
    Should Be Equal     ${output}     12345
    Close Browser
    
Exam Show Cart
    ${req}  Create Dictionary    user_id=12345
    ${response}=    POST On Session        https://APILink.xxx.th/    /Showproduct/showCart    json=${req}
    ${output}=    Query    select product_id from cart Where user_id='12345'
    Should Be Equal     ${output}     ${response.json()}[product_id]


Exan Delete Cart
    ${req}  Create Dictionary    product_id=12345
    ${response}=    Delete On Session        https://APILink.xxx.th/    /Showproduct/deleteCart    json=${req}
    Open Browser    http://Linkshoppage.com/cart     gc
    Element Should Not Contain    id=product_id    12345
    Close Browser
    ${output}=    Query    select product_id from cart Where product_id='12345'
    Should Not Be Equal     ${output}     12345