# ./vendor/bin/behat -c tests/Integration/Behaviour/behat.yml -s cart --tags cart-minimum-amount-cart-rule
@restore-all-tables-before-feature
@cart-minimum-amount-cart-rule
Feature: Add cart rule in cart
  As a customer
  I must be able to correctly add cart rules in my cart

  Background:
    Given there is customer "testCustomer" with email "pub@prestashop.com"
    And country "US" is enabled
    And there is a currency named "usd" with iso code "USD" and exchange rate of 0.92
    And currency "usd" is the default one
    And language with iso code "en" is the default one

  Scenario: cart rule with minimum amount doesn't apply if cart total is lower
    Given I am logged in as "test@prestashop.com" employee
    And there is customer "customer1" with email "pub@prestashop.com"
    And I create an empty cart "dummy_custom_cart" for customer "customer1"
    And email sending is disabled
    And shipping handling fees are set to 2.0
    And there is a product in the catalog named "product1" with a price of 19.812 and 1000 items in stock
    And there is a product in the catalog named "product4" with a price of 35.567 and 1000 items in stock
    And I create cart rule "cart_rule_1" with following properties:
      | name[en-US]                            | CartRule with minimum amount |
      | description                            | CartRule with minimum amount |
      | highlight                              | true                         |
      | is_active                              | true                         |
      | allow_partial_use                      | false                        |
      | priority                               | 2                            |
      | valid_from                             | 2019-01-01 11:05:00          |
      | valid_to                               | 2029-12-01 00:00:00          |
      | total_quantity                         | 10                           |
      | quantity_per_user                      | 1                            |
      | free_shipping                          | true                         |
      | minimum_amount                         | 50                           |
      | minimum_amount_currency                | usd                          |
      | minimum_amount_tax_included            | false                        |
      | minimum_amount_shipping_included       | true                         |
      | code                                   | CART_RULE_MIN_AMOUNT         |
      | reduction_amount                       | 2                            |
      | reduction_currency                     | usd                          |
      | reduction_tax                          | true                         |
      | discount_application_type              | order_without_shipping       |
    And cart rule "cart_rule_1" should have the following properties:
      | name[en-US]                            | CartRule with minimum amount |
      | description                            | CartRule with minimum amount |
      | highlight                              | true                         |
      | is_active                              | true                         |
      | allow_partial_use                      | false                        |
      | priority                               | 2                            |
      | valid_from                             | 2019-01-01 11:05:00          |
      | valid_to                               | 2029-12-01 00:00:00          |
      | total_quantity                         | 10                           |
      | quantity_per_user                      | 1                            |
      | free_shipping                          | true                         |
      | minimum_amount                         | 50                           |
      | minimum_amount_currency                | usd                          |
      | minimum_amount_tax_included            | false                        |
      | minimum_amount_shipping_included       | true                         |
      | code                                   | CART_RULE_MIN_AMOUNT         |
      | reduction_amount                       | 2                            |
      | reduction_currency                     | usd                          |
      | reduction_tax                          | true                         |
      | discount_application_type              | order_without_shipping       |
    When I add 1 products "product1" to the cart "dummy_custom_cart"
    And I add 1 products "product4" to the cart "dummy_custom_cart"
    Then cart "dummy_custom_cart" should contain 2 products
    When I use a voucher "CART_RULE_MIN_AMOUNT" on the cart "dummy_custom_cart"
    Then reduction value of voucher "CART_RULE_MIN_AMOUNT" in cart "dummy_custom_cart" should be "2"
    And cart "dummy_custom_cart" total with tax included should be "$53.38"
    When I delete product "product1" from cart "dummy_custom_cart"
    Then cart "dummy_custom_cart" should contain 1 products
    And cart "dummy_custom_cart" total with tax included should be "$35.57"
    And voucher "CART_RULE_MIN_AMOUNT" should not be applied to cart "dummy_custom_cart"
