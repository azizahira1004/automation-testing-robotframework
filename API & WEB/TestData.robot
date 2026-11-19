*** Variables ***
${BASE_URL}                     https://reqres.in/api
${SERVER}                       https://www.saucedemo.com/
${INVENTORY_URL}                ${SERVER}inventory.html
${CART_URL}                     ${SERVER}cart.html
${CHECKOUT_STEP_ONE_URL}        ${SERVER}checkout-step-one.html

&{standard_user}              USERNAME=standard_user
...                           PASSWORD=secret_sauce
&{locked_out_user}            USERNAME=locked_out_user
...                           PASSWORD=secret_sauce
&{problem_user}               USERNAME=problem_user
...                           PASSWORD=secret_sauce
&{performance_glitch_user}    USERNAME=performance_glitch_user
...                           PASSWORD=secret_sauce
&{error_user}                 USERNAME=error_user
...                           PASSWORD=secret_sauce
&{visual_user}                USERNAME=visual_user
...                           PASSWORD=secret_sauce
