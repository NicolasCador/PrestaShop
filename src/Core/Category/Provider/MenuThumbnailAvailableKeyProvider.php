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

declare(strict_types=1);

namespace PrestaShop\PrestaShop\Core\Category\Provider;

use PrestaShop\PrestaShop\Core\Domain\Category\ValueObject\MenuThumbnailId;

/**
 * This class is responsible for providing available category menu thumbnail keys.
 * Category can only have 3 thumbnails (0,1,2).
 * We check if thumbnails with those id's exist, if they do they are no longer available.
 */
class MenuThumbnailAvailableKeyProvider
{
    /**
     * @var CategoryImageFinder
     */
    private $categoryImageFinder;

    public function __construct(CategoryImageFinder $categoryImageFinder)
    {
        $this->categoryImageFinder = $categoryImageFinder;
    }

    /**
     * @param int $categoryId
     *
     * @return array<int, int>
     */
    public function getAvailableKeys(int $categoryId): array
    {
        $usedKeys = [];

        foreach ($this->categoryImageFinder->findMenuThumbnails($categoryId) as $file) {
            $matches = [];

            if (preg_match('/^' . $categoryId . '-([0-9])?_thumb.jpg/i', $file->getFilename(), $matches) === 1) {
                $usedKeys[] = (int) $matches[1];
            }
        }

        return array_diff(MenuThumbnailId::ALLOWED_ID_VALUES, $usedKeys);
    }
}
