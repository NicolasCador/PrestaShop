<?php
/**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/OSL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/OSL-3.0 Open Software License (OSL 3.0)
 */

namespace PrestaShop\PrestaShop\Core\Domain\CartRule\ValueObject\CartRuleAction;

use PrestaShop\PrestaShop\Core\Domain\CartRule\ValueObject\GiftProduct;
use PrestaShop\PrestaShop\Core\Domain\CartRule\ValueObject\PercentageDiscount;
use PrestaShop\PrestaShop\Core\Domain\ValueObject\Money;

/**
 * Cart rule action that gives amount discount.
 * Amount discount must have a money amount and currency.
 * It can optionally have free shipping and gift product.
 * It cannot have percentage discount.
 */
final class AmountDiscountAction implements CartRuleActionInterface
{
    /**
     * @var Money
     */
    private $amountDiscount;

    /**
     * @var bool
     */
    private $isFreeShipping;

    /**
     * @var GiftProduct|null
     */
    private $giftProduct;

    /**
     * @param Money $amountDiscount
     * @param bool $isFreeShipping
     * @param GiftProduct|null $giftProduct
     */
    public function __construct(
        Money $amountDiscount,
        bool $isFreeShipping,
        GiftProduct $giftProduct = null
    ) {
        $this->amountDiscount = $amountDiscount;
        $this->isFreeShipping = $isFreeShipping;
        $this->giftProduct = $giftProduct;
    }

    /**
     * {@inheritdoc}
     */
    public function isFreeShipping(): bool
    {
        return $this->isFreeShipping;
    }

    /**
     * {@inheritdoc}
     */
    public function getPercentageDiscount(): ?PercentageDiscount
    {
        return null;
    }

    /**
     * {@inheritdoc}
     */
    public function getAmountDiscount(): ?Money
    {
        return $this->amountDiscount;
    }

    /**
     * {@inheritdoc}
     */
    public function getGiftProduct(): ?GiftProduct
    {
        return $this->giftProduct;
    }
}
