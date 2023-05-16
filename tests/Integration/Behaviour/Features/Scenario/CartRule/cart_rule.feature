# ./vendor/bin/behat -c tests/Integration/Behaviour/behat.yml -s cart_rule --tags add-cart-rule
@restore-all-tables-before-feature
@add-cart-rule
Feature: Add cart rule
  PrestaShop allows BO users to create cart rules
  As a BO user
  I must be able to create cart rules

  Background:
    Given shop "shop1" with name "test_shop" exists
    Given there is a currency named "usd" with iso code "USD" and exchange rate of 0.92
    Given there is a currency named "chf" with iso code "CHF" and exchange rate of 1.25
    Given currency "usd" is the default one
    And language with iso code "en" is the default one

  Scenario: Create a cart rule with amount discount
    When I create cart rule "cart_rule_1" with following properties:
      | name[en-US]                      | Promotion              |
      | description                      | Promotion for holidays |
      | highlight                        | false                  |
      | is_active                        | true                   |
      | allow_partial_use                | false                  |
      | priority                         | 2                      |
      | valid_from                       | 2019-01-01 11:05:00    |
      | valid_to                         | 2019-12-01 00:00:00    |
      | total_quantity                   | 10                     |
      | quantity_per_user                | 1                      |
      | free_shipping                    | true                   |
      | minimum_amount                   | 10                     |
      | minimum_amount_currency          | chf                    |
      | minimum_amount_tax_included      | false                  |
      | minimum_amount_shipping_included | true                   |
      | code                             | PROMO_2019             |
      | reduction_amount                 | 15                     |
      | reduction_currency               | usd                    |
      | reduction_tax                    | true                   |
      | discount_application_type        | order_without_shipping |
    And cart rule "cart_rule_1" should have the following properties:
      | name[en-US]                      | Promotion              |
      | description                      | Promotion for holidays |
      | highlight                        | false                  |
      | is_active                        | true                   |
      | allow_partial_use                | false                  |
      | priority                         | 2                      |
      | valid_from                       | 2019-01-01 11:05:00    |
      | valid_to                         | 2019-12-01 00:00:00    |
      | total_quantity                   | 10                     |
      | quantity_per_user                | 1                      |
      | free_shipping                    | true                   |
      | minimum_amount                   | 10                     |
      | minimum_amount_currency          | chf                    |
      | minimum_amount_tax_included      | false                  |
      | minimum_amount_shipping_included | true                   |
      | code                             | PROMO_2019             |
      | reduction_amount                 | 15                     |
      | reduction_currency               | usd                    |
      | reduction_tax                    | true                   |
      | discount_application_type        | order_without_shipping |

  Scenario: Create a cart rule with percentage discount
    When I create cart rule "cart_rule_1" with following properties:
      | name[en-US]                            | 50% off promo                           |
      | description                            | Discount for whole catalog for one hour |
      | highlight                              | true                                    |
      | is_active                              | false                                   |
      | allow_partial_use                      | true                                    |
      | priority                               | 1                                       |
      | valid_from                             | 2019-01-01 11:00:00                     |
      | valid_to                               | 2019-01-01 12:00:00                     |
      | total_quantity                         | 10                                      |
      | quantity_per_user                      | 12                                      |
      | free_shipping                          | true                                    |
      | minimum_amount                         | 99.99                                   |
      | minimum_amount_currency                | usd                                     |
      | minimum_amount_tax_included            | true                                    |
      | minimum_amount_shipping_included       | false                                   |
      | code                                   | HAPPY_HOUR                              |
      | reduction_percentage                   | 50                                      |
      | reduction_apply_to_discounted_products | false                                   |
      | discount_application_type              | cheapest_product                        |
    And cart rule "cart_rule_1" should have the following properties:
      | name[en-US]                            | 50% off promo                           |
      | description                            | Discount for whole catalog for one hour |
      | highlight                              | true                                    |
      | is_active                              | false                                   |
      | allow_partial_use                      | true                                    |
      | priority                               | 1                                       |
      | valid_from                             | 2019-01-01 11:00:00                     |
      | valid_to                               | 2019-01-01 12:00:00                     |
      | total_quantity                         | 10                                      |
      | quantity_per_user                      | 12                                      |
      | free_shipping                          | true                                    |
      | minimum_amount                         | 99.99                                   |
      | minimum_amount_currency                | usd                                     |
      | minimum_amount_tax_included            | true                                    |
      | minimum_amount_shipping_included       | false                                   |
      | code                                   | HAPPY_HOUR                              |
      | reduction_percentage                   | 50                                      |
      | reduction_apply_to_discounted_products | false                                   |
      | discount_application_type              | cheapest_product                        |

  Scenario: Delete cart rule
    When I create cart rule "cart_rule_1" with following properties:
      | name[en-US]                      | Cart Rule 1         |
      | highlight                        | true                |
      | active                           | true                |
      | allow_partial_use                | true                |
      | priority                         | 1                   |
      | is_active                        | true                |
      | valid_from                       | 2019-01-01 11:05:00 |
      | valid_to                         | 2019-12-01 00:00:00 |
      | total_quantity                   | 10                  |
      | quantity_per_user                | 2                   |
      | free_shipping                    | true                |
      | minimum_amount                   | 10                  |
      | minimum_amount_currency          | usd                 |
      | minimum_amount_tax_included      | true                |
      | minimum_amount_shipping_included | true                |
    And I delete Cart rule with reference "cart_rule_1"
    Then Cart rule with reference "cart_rule_1" does not exist

  Scenario: Delete multiple cart rules
    When I create cart rule "cart_rule_1" with following properties:
      | name[en-US]                      | Cart Rule 1         |
      | highlight                        | true                |
      | active                           | true                |
      | allow_partial_use                | true                |
      | priority                         | 1                   |
      | is_active                        | true                |
      | valid_from                       | 2019-01-01 11:05:00 |
      | valid_to                         | 2019-12-01 00:00:00 |
      | total_quantity                   | 10                  |
      | quantity_per_user                | 2                   |
      | free_shipping                    | true                |
      | minimum_amount                   | 10                  |
      | minimum_amount_currency          | usd                 |
      | minimum_amount_tax_included      | true                |
      | minimum_amount_shipping_included | true                |
    And I create cart rule "cart_rule_2" with following properties:
      | name[en-US]                      | Cart Rule 2         |
      | highlight                        | true                |
      | active                           | true                |
      | allow_partial_use                | true                |
      | priority                         | 1                   |
      | is_active                        | true                |
      | valid_from                       | 2019-01-01 11:05:00 |
      | valid_to                         | 2019-12-01 00:00:00 |
      | total_quantity                   | 10                  |
      | quantity_per_user                | 2                   |
      | free_shipping                    | true                |
      | minimum_amount                   | 10                  |
      | minimum_amount_currency          | usd                 |
      | minimum_amount_tax_included      | true                |
      | minimum_amount_shipping_included | true                |
    And I bulk delete cart rules "cart_rule_1,cart_rule_2"
    Then Cart rule with reference "cart_rule_1" does not exist
    And Cart rule with reference "cart_rule_2" does not exist

  Scenario: Create and enable cart rule
    When I create cart rule "cart_rule_1" with following properties:
      | name[en-US]                      | Cart Rule 1         |
      | highlight                        | true                |
      | active                           | true                |
      | allow_partial_use                | true                |
      | priority                         | 1                   |
      | is_active                        | false               |
      | valid_from                       | 2019-01-01 11:05:00 |
      | valid_to                         | 2019-12-01 00:00:00 |
      | total_quantity                   | 10                  |
      | quantity_per_user                | 2                   |
      | free_shipping                    | true                |
      | minimum_amount                   | 10                  |
      | minimum_amount_currency          | usd                 |
      | minimum_amount_tax_included      | true                |
      | minimum_amount_shipping_included | true                |
    When I enable cart rule with reference "cart_rule_1"
    Then Cart rule with reference "cart_rule_1" is enabled

  Scenario: Disable cart rule
    When I create cart rule "cart_rule_1" with following properties:
      | name[en-US]                      | Cart Rule 1         |
      | highlight                        | true                |
      | active                           | true                |
      | allow_partial_use                | true                |
      | priority                         | 1                   |
      | is_active                        | true                |
      | valid_from                       | 2019-01-01 11:05:00 |
      | valid_to                         | 2019-12-01 00:00:00 |
      | total_quantity                   | 10                  |
      | quantity_per_user                | 2                   |
      | free_shipping                    | true                |
      | minimum_amount                   | 10                  |
      | minimum_amount_currency          | usd                 |
      | minimum_amount_tax_included      | true                |
      | minimum_amount_shipping_included | true                |
    And I disable cart rule with reference "cart_rule_1"
    Then Cart rule with reference "cart_rule_1" is disabled

  Scenario: Enable multiple cart rules
    Given I create cart rule "cart_rule_1" with following properties:
      | name[en-US]                      | Cart Rule 1         |
      | highlight                        | true                |
      | active                           | true                |
      | allow_partial_use                | true                |
      | priority                         | 1                   |
      | is_active                        | true                |
      | valid_from                       | 2019-01-01 11:05:00 |
      | valid_to                         | 2019-12-01 00:00:00 |
      | total_quantity                   | 10                  |
      | quantity_per_user                | 2                   |
      | free_shipping                    | true                |
      | minimum_amount                   | 10                  |
      | minimum_amount_currency          | usd                 |
      | minimum_amount_tax_included      | true                |
      | minimum_amount_shipping_included | true                |
    And I create cart rule "cart_rule_2" with following properties:
      | name[en-US]                      | Cart Rule 2         |
      | highlight                        | true                |
      | active                           | true                |
      | allow_partial_use                | true                |
      | priority                         | 1                   |
      | is_active                        | true                |
      | valid_from                       | 2019-01-01 11:05:00 |
      | valid_to                         | 2019-12-01 00:00:00 |
      | total_quantity                   | 10                  |
      | quantity_per_user                | 2                   |
      | free_shipping                    | true                |
      | minimum_amount                   | 10                  |
      | minimum_amount_currency          | usd                 |
      | minimum_amount_tax_included      | true                |
      | minimum_amount_shipping_included | true                |
    And cart rule cart_rule_1 should have the following properties:
      | is_active | true |
    And cart rule cart_rule_2 should have the following properties:
      | is_active | true |
    And I bulk disable cart rules "cart_rule_1,cart_rule_2"
    Then Cart rule with reference "cart_rule_1" is disabled
    And Cart rule with reference "cart_rule_2" is disabled

  Scenario: Disable multiple cart rules
    When I create cart rule "cart_rule_1" with following properties:
      | name[en-US]                      | Cart Rule 1         |
      | highlight                        | true                |
      | active                           | true                |
      | allow_partial_use                | true                |
      | priority                         | 1                   |
      | is_active                        | false               |
      | valid_from                       | 2019-01-01 11:05:00 |
      | valid_to                         | 2019-12-01 00:00:00 |
      | total_quantity                   | 10                  |
      | quantity_per_user                | 2                   |
      | free_shipping                    | true                |
      | minimum_amount                   | 10                  |
      | minimum_amount_currency          | usd                 |
      | minimum_amount_tax_included      | true                |
      | minimum_amount_shipping_included | true                |
    And I create cart rule "cart_rule_2" with following properties:
      | name[en-US]                      | Cart Rule 2         |
      | highlight                        | true                |
      | active                           | false               |
      | allow_partial_use                | true                |
      | priority                         | 1                   |
      | is_active                        | true                |
      | valid_from                       | 2019-01-01 11:05:00 |
      | valid_to                         | 2019-12-01 00:00:00 |
      | total_quantity                   | 10                  |
      | quantity_per_user                | 2                   |
      | free_shipping                    | true                |
      | minimum_amount                   | 10                  |
      | minimum_amount_currency          | usd                 |
      | minimum_amount_tax_included      | true                |
      | minimum_amount_shipping_included | true                |
    When I bulk enable cart rules "cart_rule_1,cart_rule_2"
    Then Cart rule with reference "cart_rule_1" is enabled
    And Cart rule with reference "cart_rule_2" is enabled

  Scenario: I should not be able to create cart rule with already existing code
    Given I create cart rule "cart_rule_1" with following properties:
      | name[en-US]       | Cart Rule 1         |
      | highlight         | true                |
      | active            | true                |
      | allow_partial_use | true                |
      | priority          | 1                   |
      | is_active         | true                |
      | valid_from        | 2019-01-01 11:05:00 |
      | valid_to          | 2019-12-01 00:00:00 |
      | total_quantity    | 10                  |
      | quantity_per_user | 2                   |
      | free_shipping     | true                |
      | code              | testcode1           |
    And cart rule cart_rule_1 should have the following properties:
      | is_active | testcode1 |
    When I create cart rule "cart_rule_2" with following properties:
      | name[en-US]       | Cart Rule 2         |
      | highlight         | true                |
      | active            | true                |
      | allow_partial_use | true                |
      | priority          | 1                   |
      | is_active         | true                |
      | valid_from        | 2019-01-01 11:05:00 |
      | valid_to          | 2019-12-01 00:00:00 |
      | total_quantity    | 10                  |
      | quantity_per_user | 2                   |
      | free_shipping     | true                |
      | code              | testcode1           |
    Then I should get cart rule error about "non unique cart rule code"
