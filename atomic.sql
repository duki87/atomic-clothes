-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 10, 2020 at 10:10 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `atomic`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `username`, `role`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Dusan Marinkovic', 'duki87', 'admin', 'duki@gmail.com', NULL, '$2y$10$PRWEfGNk5yL79/HkGikVx.4hvNFUBAhDrdpa/VhKbGt23GMBY7iKC', NULL, '2020-02-02 19:13:44', '2020-02-02 19:13:44');

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tags` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `title`, `url`, `description`, `logo`, `website`, `tags`, `created_at`, `updated_at`) VALUES
(1, 'Atomic', '', 'Atomic is our primary brand.', 'ukaVONUHw4XWHTuvVS8Pg2bbhxXb7uq3.png', 'http://www.atomic.com', '[\"atomic\"]', '2019-11-26 18:10:08', '2019-11-26 18:10:08'),
(2, 'Core', '', 'Core is a new brand which offers casual clothing.', 's2MC7Q27EWHnzi5Nvy3iiaxj3WKUmVOU.png', 'http://www.core-clothing.com', '[\"core\"]', '2019-11-26 18:35:13', '2019-11-26 18:35:13'),
(3, 'Proto', '', 'Proto is a new brand', 'yhHffY7rihunpd36BeLvTvYhEib0HTRL.png', 'http://www.proto.com', '[\"proto\"]', '2020-01-15 21:21:54', '2020-01-15 21:21:54');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `main` int(11) NOT NULL DEFAULT 0,
  `sub` int(11) NOT NULL DEFAULT 0,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tags` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `main`, `sub`, `url`, `title`, `tags`, `created_at`, `updated_at`) VALUES
(1, 0, 0, 'men', 'Men', '[\"men\"]', '2019-11-26 17:57:59', '2019-11-26 17:57:59'),
(2, 0, 0, 'women', 'Women', '[\"women\"]', '2019-11-26 17:58:11', '2019-11-26 17:58:11'),
(3, 0, 0, 'children', 'Children', '[\"children\"]', '2019-11-26 17:58:27', '2019-11-26 17:58:27'),
(4, 1, 0, 'shirts', 'Shirts', '[\"shirts\",\"men\"]', '2019-11-26 17:58:54', '2019-11-26 17:58:54'),
(5, 1, 4, 'long-sleeve', 'Long Sleeve', '[\"men\",\"shirts\",\"long-sleeve\"]', '2019-11-26 17:59:21', '2019-11-26 17:59:21'),
(6, 2, 0, 'shirts', 'Shirts', '[\"women\",\"shirts\"]', '2019-11-26 17:59:43', '2019-11-26 17:59:43'),
(7, 2, 6, 'long-sleeves', 'Long Sleeves', '[\"women\",\"shirts\",\"long-sleeve\"]', '2019-11-26 18:00:12', '2019-11-26 18:00:12'),
(8, 1, 0, 't-shirt', 'T-Shirts', '[\"t-shirts\",\"men\"]', '2019-12-03 19:02:23', '2019-12-03 19:02:23'),
(9, 1, 8, 'v-neck', 'V-Neck', '[\"t-shirts\",\"men\",\"v-neck\"]', '2019-12-03 19:05:13', '2019-12-03 19:05:13'),
(10, 1, 4, 'short-sleeve', 'Short Sleeve', '[\"men\",\"shirts\",\"short-sleeve\"]', '2019-12-03 19:52:45', '2019-12-03 19:52:45'),
(11, 2, 0, 'shirts', 'Shirts', '[\"women-shirts\"]', '2020-01-06 10:08:23', '2020-01-06 10:08:23'),
(12, 2, 11, 'short-sleeve', 'Short Sleeve', '[\"women-short-sleeve-shirts\"]', '2020-01-06 10:08:49', '2020-01-06 10:08:49'),
(13, 2, 0, 't-shirts', 'T-Shirts', '[\"women\",\"t-shirts\"]', '2020-01-16 18:53:14', '2020-01-16 18:53:14'),
(14, 2, 13, 'classic', 'Classic', '[\"classic\"]', '2020-01-16 18:53:31', '2020-01-16 18:53:31'),
(15, 1, 0, 'pants', 'Pants', '', '2020-02-05 18:04:13', '2020-02-05 18:04:13'),
(16, 1, 15, 'long-pants', 'Long Pants', '[\"long-pants\"]', '2020-02-05 18:09:49', '2020-02-05 18:09:49');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2019_11_13_212221_create_categories_table', 1),
(2, '2019_11_18_223523_create_brands_table', 2),
(3, '2019_11_26_193611_create_products_table', 3),
(4, '2019_11_26_195106_create_product_variants_table', 3),
(5, '2019_12_03_154652_create_product_images_table', 3),
(6, '2019_12_03_173502_add_price_to_products', 4),
(7, '2019_12_03_201632_add_discount_to_products', 5),
(8, '2019_12_12_125412_add_code_to_products_table', 6),
(9, '2019_12_12_142549_add_product_id_to_images_table', 7),
(10, '2019_12_17_133051_add_status_to_products_table', 8),
(11, '2019_12_26_135218_alter_variants_table_columns', 9),
(12, '2016_06_01_000001_create_oauth_auth_codes_table', 10),
(13, '2016_06_01_000002_create_oauth_access_tokens_table', 10),
(14, '2016_06_01_000003_create_oauth_refresh_tokens_table', 10),
(15, '2016_06_01_000004_create_oauth_clients_table', 10),
(16, '2016_06_01_000005_create_oauth_personal_access_clients_table', 10),
(17, '2019_12_31_145019_alter_product_images_table_make_product_id_nullable', 11),
(18, '2019_12_31_154844_alter_products_table_chande_discount_type', 11),
(19, '2020_02_02_191145_create_admins_table', 12),
(20, '2020_02_05_182503_alter_category_table_add_url', 13),
(21, '2020_02_10_094325_create_product_colors_table', 14),
(22, '2020_02_10_095904_alter_variants_table_add_color_id', 15),
(23, '2020_02_10_100058_alter_images_table_add_color_id', 16),
(24, '2020_02_10_100407_alter_variants_table_delete_color', 17),
(25, '2020_02_10_101206_alter_products_table_add_url', 18),
(26, '2020_02_10_101408_alter_brands_table_add_url', 19),
(27, '2020_02_10_111855_alter_products_table_make_unique_url', 20),
(28, '2020_02_10_132743_alter_product_images_delete_variant_id', 21);

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `main_category_id` int(11) NOT NULL,
  `sub_category_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double(8,2) NOT NULL,
  `discount` double DEFAULT NULL,
  `image_folder` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cover_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tags` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `main_category_id`, `sub_category_id`, `category_id`, `brand_id`, `code`, `title`, `url`, `description`, `price`, `discount`, `image_folder`, `cover_image`, `tags`, `status`, `created_at`, `updated_at`) VALUES
(39, 1, 8, 9, 2, 'YMRS094451', 'Men T-Shirt M-113', 'men-t-Shirt-m-113', 'Men T-Shirt M-113 Men T-Shirt M-113 Men T-Shirt M-113 Men T-Shirt M-113 Men T-Shirt M-113', 20.99, NULL, '16012020190353-0raywsr8qmuh6fve', 'I2qAAvwG2BpfVuU3YKM5jBV9LMoNvgkD.jpg', '[\"men-t-shirt-m-113\"]', 1, '2020-01-16 18:03:53', '2020-01-16 18:04:41'),
(40, 1, 4, 5, 1, 'YEC2092441', 'Men Shirt Classic A-235', 'Men-shirt-classic-a-235', 'Men Shirt Classic A-235 Men Shirt Classic A-235 Men Shirt Classic A-235 Men Shirt Classic A-235 Men Shirt Classic A-235', 25.99, NULL, '16012020194556-c97adnlgjozezxfz', '0MVxb1NOR3fe6r4INZIcm5Wtl0tLVguO.jpg', '', 1, '2020-01-16 18:45:56', '2020-01-16 18:47:14'),
(41, 2, 13, 14, 2, 'QIDK046902', 'Women T-Shirt Y-12', 'women-t-shirt-y-12', 'Women T-Shirt Y-12 Women T-Shirt Y-12 Women T-Shirt Y-12 Women T-Shirt Y-12 Women T-Shirt Y-12', 14.99, 11.99, '16012020194959-zgiciiayj3doqxzt', 'uoZ3LKkVhILqki542Zkj4GufR89WzNGo.jpg', '', 1, '2020-01-16 18:49:59', '2020-01-16 18:54:16'),
(71, 1, 15, 16, 2, '8JU2060610', 'Men Pants Core', 'men-pants-core', 'fgh fghfsgh fjyrf nf ndgcbn fhjfhmj ghmgmgm', 29.99, 25.99, '06022020104234-iwdkjmwugjugrnft', 'lTtAExjEzZ3BbOi6DraFNOSRbDOKy9wQ.jpg', '[\"pants\",\"core\",\"men\"]', 1, '2020-02-06 09:42:35', '2020-02-06 09:44:05');

-- --------------------------------------------------------

--
-- Table structure for table `product_colors`
--

CREATE TABLE `product_colors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_colors`
--

INSERT INTO `product_colors` (`id`, `product_id`, `color`, `created_at`, `updated_at`) VALUES
(1, 71, 'black', NULL, NULL),
(2, 71, 'red', NULL, NULL),
(3, 41, 'white', NULL, NULL),
(4, 41, 'pink', NULL, NULL),
(7, 41, 'Purple', '2020-02-10 17:31:33', '2020-02-10 17:31:33'),
(8, 41, 'various colors', '2020-02-10 17:33:49', '2020-02-10 17:33:49');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `color_id` int(11) NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `color_id`, `image`, `created_at`, `updated_at`) VALUES
(15, 39, 0, 'I2qAAvwG2BpfVuU3YKM5jBV9LMoNvgkD.jpg', '2020-01-16 18:04:37', '2020-01-16 18:04:37'),
(16, 39, 0, 'aR5lcLImOdGJFTpuryzn7uH7evuzjDhG.jpg', '2020-01-16 18:04:38', '2020-01-16 18:04:38'),
(17, 39, 0, 'DTLeL4ltOYH1BfwOhG9se3pMjnso80pV.jpg', '2020-01-16 18:04:38', '2020-01-16 18:04:38'),
(18, 39, 0, 'qi1lwB5HugXxCtIDCFztX0iejHxWD5rZ.jpg', '2020-01-16 18:04:38', '2020-01-16 18:04:38'),
(19, 39, 0, 'pbcbE2I2I13xCuGuUbzjYzefatEU5PSp.jpg', '2020-01-16 18:04:38', '2020-01-16 18:04:38'),
(20, 39, 0, 'nF0F4Pq4yiOIdkaCCFpT7lolDxhLItmg.jpg', '2020-01-16 18:04:39', '2020-01-16 18:04:39'),
(21, 39, 0, '3TEw2zWgg9KTb4BWNwtpvDbBL39lnWnN.jpg', '2020-01-16 18:04:39', '2020-01-16 18:04:39'),
(22, NULL, 0, 'qi1lwB5HugXxCtIDCFztX0iejHxWD5rZ.jpg', '2020-01-16 18:06:06', '2020-01-16 18:06:06'),
(23, NULL, 0, 'pbcbE2I2I13xCuGuUbzjYzefatEU5PSp.jpg', '2020-01-16 18:06:06', '2020-01-16 18:06:06'),
(24, NULL, 0, 'nF0F4Pq4yiOIdkaCCFpT7lolDxhLItmg.jpg', '2020-01-16 18:06:06', '2020-01-16 18:06:06'),
(25, NULL, 0, '3TEw2zWgg9KTb4BWNwtpvDbBL39lnWnN.jpg', '2020-01-16 18:06:06', '2020-01-16 18:06:06'),
(26, NULL, 0, 'I2qAAvwG2BpfVuU3YKM5jBV9LMoNvgkD.jpg', '2020-01-16 18:06:43', '2020-01-16 18:06:43'),
(27, NULL, 0, 'aR5lcLImOdGJFTpuryzn7uH7evuzjDhG.jpg', '2020-01-16 18:06:43', '2020-01-16 18:06:43'),
(28, NULL, 0, 'DTLeL4ltOYH1BfwOhG9se3pMjnso80pV.jpg', '2020-01-16 18:06:43', '2020-01-16 18:06:43'),
(29, 40, 0, '0MVxb1NOR3fe6r4INZIcm5Wtl0tLVguO.jpg', '2020-01-16 18:46:08', '2020-01-16 18:46:08'),
(30, 40, 0, 'oE6T6HjLQ7rZJ205ydpQZaAApgB4CToW.jpg', '2020-01-16 18:46:08', '2020-01-16 18:46:08'),
(31, 40, 0, 'zUGNSf5PmveHw0RW9qblaz06YPxi2SmN.jpg', '2020-01-16 18:46:08', '2020-01-16 18:46:08'),
(32, 40, 0, 'yOBS5p5U6bNzajXP0NFHtHkK8gv0SIle.jpg', '2020-01-16 18:46:09', '2020-01-16 18:46:09'),
(33, 40, 0, 'lyBzgZQXn6i82UkfFM4Zfi7Vsutb16m6.jpg', '2020-01-16 18:46:09', '2020-01-16 18:46:09'),
(34, 40, 0, 'uDYXb5NoDxlHxpMfS65kjHExyugu7X2Y.jpg', '2020-01-16 18:46:09', '2020-01-16 18:46:09'),
(35, NULL, 0, '0MVxb1NOR3fe6r4INZIcm5Wtl0tLVguO.jpg', '2020-01-16 18:47:52', '2020-01-16 18:47:52'),
(36, NULL, 0, 'oE6T6HjLQ7rZJ205ydpQZaAApgB4CToW.jpg', '2020-01-16 18:47:52', '2020-01-16 18:47:52'),
(37, NULL, 0, '0MVxb1NOR3fe6r4INZIcm5Wtl0tLVguO.jpg', '2020-01-16 18:48:21', '2020-01-16 18:48:21'),
(38, NULL, 0, 'oE6T6HjLQ7rZJ205ydpQZaAApgB4CToW.jpg', '2020-01-16 18:48:21', '2020-01-16 18:48:21'),
(39, NULL, 0, 'lyBzgZQXn6i82UkfFM4Zfi7Vsutb16m6.jpg', '2020-01-16 18:49:19', '2020-01-16 18:49:19'),
(40, NULL, 0, 'uDYXb5NoDxlHxpMfS65kjHExyugu7X2Y.jpg', '2020-01-16 18:49:19', '2020-01-16 18:49:19'),
(41, NULL, 0, 'uDYXb5NoDxlHxpMfS65kjHExyugu7X2Y.jpg', '2020-01-16 18:49:41', '2020-01-16 18:49:41'),
(42, NULL, 0, 'lyBzgZQXn6i82UkfFM4Zfi7Vsutb16m6.jpg', '2020-01-16 18:49:41', '2020-01-16 18:49:41'),
(52, 41, 4, 'ZLGlXIMZFe94fwgaM6FFiPvNoEMvp1KH.jpg', '2020-01-16 18:50:43', '2020-01-16 18:50:43'),
(53, 41, 4, 'yRMi8uJZbFYxEoUe2UimmPT29eS7mOQX.jpg', '2020-01-16 18:50:43', '2020-01-16 18:50:43'),
(54, 41, 8, 'ApEIgKMDhIIHfCZmHHg4ovS4Oxbkauyo.jpg', '2020-01-16 18:50:44', '2020-02-10 17:33:49'),
(55, 41, 4, 'SLTYHY348oEYHkiHCtNxE0b5YNwi0kdG.jpg', '2020-01-16 18:50:44', '2020-01-16 18:50:44'),
(56, 41, 7, '8m24M2OR4NBmB4ECRarz3W5kAbuhqoyr.jpg', '2020-01-16 18:50:45', '2020-02-10 17:31:33'),
(57, 41, 8, 'jjuMnkY4VltA7fXQjgZysBCB3ssf3yUE.jpg', '2020-01-16 18:50:45', '2020-02-10 17:33:50'),
(58, 41, 7, '22MPdyV1jjydA7TezsYMpPGAnox0uhIJ.jpg', '2020-01-16 18:50:45', '2020-02-10 17:31:33'),
(59, 41, 7, 'dof7iswv3cLMWc4lKkMSSvUCP447C17k.jpg', '2020-01-16 18:50:45', '2020-02-10 17:31:33'),
(60, 41, 7, '47SeeKDfvoG3wkrbJd5MSH1ZahnXEdfV.jpg', '2020-01-16 18:50:46', '2020-02-10 17:31:33'),
(61, 41, 8, 'lnBLBRnw8O0CuAiLsvGDAFVLrlgvGhZq.jpg', '2020-01-16 18:50:46', '2020-02-10 17:33:50'),
(62, 41, 3, 'uoZ3LKkVhILqki542Zkj4GufR89WzNGo.jpg', '2020-01-16 18:50:46', '2020-01-16 18:50:46'),
(63, 41, 3, 'OgB5FaX6e8Gz0N360i4xHLzJ46w54nkU.jpg', '2020-01-16 18:50:47', '2020-01-16 18:50:47'),
(64, 41, 3, 'Clu7fCdUxoPN6f7s2O3dSta6WKeOPzUe.jpg', '2020-01-16 18:50:47', '2020-01-16 18:50:47'),
(65, NULL, 0, 'ZLGlXIMZFe94fwgaM6FFiPvNoEMvp1KH.jpg', '2020-01-16 18:54:45', '2020-01-16 18:54:45'),
(66, NULL, 0, 'yRMi8uJZbFYxEoUe2UimmPT29eS7mOQX.jpg', '2020-01-16 18:54:45', '2020-01-16 18:54:45'),
(67, NULL, 0, 'ApEIgKMDhIIHfCZmHHg4ovS4Oxbkauyo.jpg', '2020-01-16 18:54:45', '2020-01-16 18:54:45'),
(68, NULL, 0, 'SLTYHY348oEYHkiHCtNxE0b5YNwi0kdG.jpg', '2020-01-16 18:54:45', '2020-01-16 18:54:45'),
(69, NULL, 0, 'ZLGlXIMZFe94fwgaM6FFiPvNoEMvp1KH.jpg', '2020-01-16 18:55:17', '2020-01-16 18:55:17'),
(70, NULL, 0, 'yRMi8uJZbFYxEoUe2UimmPT29eS7mOQX.jpg', '2020-01-16 18:55:17', '2020-01-16 18:55:17'),
(71, NULL, 0, 'ApEIgKMDhIIHfCZmHHg4ovS4Oxbkauyo.jpg', '2020-01-16 18:55:17', '2020-01-16 18:55:17'),
(72, NULL, 0, 'SLTYHY348oEYHkiHCtNxE0b5YNwi0kdG.jpg', '2020-01-16 18:55:17', '2020-01-16 18:55:17'),
(73, NULL, 0, 'uoZ3LKkVhILqki542Zkj4GufR89WzNGo.jpg', '2020-01-16 18:55:43', '2020-01-16 18:55:43'),
(74, NULL, 0, 'OgB5FaX6e8Gz0N360i4xHLzJ46w54nkU.jpg', '2020-01-16 18:55:43', '2020-01-16 18:55:43'),
(75, NULL, 0, 'Clu7fCdUxoPN6f7s2O3dSta6WKeOPzUe.jpg', '2020-01-16 18:55:43', '2020-01-16 18:55:43'),
(76, NULL, 0, 'lnBLBRnw8O0CuAiLsvGDAFVLrlgvGhZq.jpg', '2020-01-16 18:55:43', '2020-01-16 18:55:43'),
(77, NULL, 0, 'lnBLBRnw8O0CuAiLsvGDAFVLrlgvGhZq.jpg', '2020-01-16 18:56:57', '2020-01-16 18:56:57'),
(78, NULL, 0, 'uoZ3LKkVhILqki542Zkj4GufR89WzNGo.jpg', '2020-01-16 18:56:57', '2020-01-16 18:56:57'),
(79, NULL, 0, 'OgB5FaX6e8Gz0N360i4xHLzJ46w54nkU.jpg', '2020-01-16 18:56:57', '2020-01-16 18:56:57'),
(80, NULL, 0, 'Clu7fCdUxoPN6f7s2O3dSta6WKeOPzUe.jpg', '2020-01-16 18:56:57', '2020-01-16 18:56:57'),
(81, NULL, 0, '8m24M2OR4NBmB4ECRarz3W5kAbuhqoyr.jpg', '2020-01-16 18:57:38', '2020-01-16 18:57:38'),
(82, NULL, 0, 'jjuMnkY4VltA7fXQjgZysBCB3ssf3yUE.jpg', '2020-01-16 18:57:38', '2020-01-16 18:57:38'),
(83, NULL, 0, '22MPdyV1jjydA7TezsYMpPGAnox0uhIJ.jpg', '2020-01-16 18:57:38', '2020-01-16 18:57:38'),
(84, NULL, 0, 'dof7iswv3cLMWc4lKkMSSvUCP447C17k.jpg', '2020-01-16 18:57:38', '2020-01-16 18:57:38'),
(85, NULL, 0, '47SeeKDfvoG3wkrbJd5MSH1ZahnXEdfV.jpg', '2020-01-16 18:57:38', '2020-01-16 18:57:38'),
(86, NULL, 0, 'uoZ3LKkVhILqki542Zkj4GufR89WzNGo.jpg', '2020-01-16 20:29:01', '2020-01-16 20:29:01'),
(87, NULL, 0, 'OgB5FaX6e8Gz0N360i4xHLzJ46w54nkU.jpg', '2020-01-16 20:29:01', '2020-01-16 20:29:01'),
(88, NULL, 0, 'lnBLBRnw8O0CuAiLsvGDAFVLrlgvGhZq.jpg', '2020-01-16 20:29:01', '2020-01-16 20:29:01'),
(89, NULL, 0, 'Clu7fCdUxoPN6f7s2O3dSta6WKeOPzUe.jpg', '2020-01-16 20:29:01', '2020-01-16 20:29:01'),
(100, 46, 0, 'ckaeIGFbOpGpqUsiCQuCVGEhctHtLmuW.jpg', '2020-01-23 13:59:04', '2020-01-23 13:59:04'),
(101, 46, 0, 'FmHtUOFNA68kDAj6bd9MYN85B1OoieOm.jpg', '2020-01-23 13:59:04', '2020-01-23 13:59:04'),
(144, 54, 0, 'idTLx459JRTYTE15zrvphWDQxC93f90n.jpg', '2020-01-23 14:37:23', '2020-01-23 14:37:23'),
(145, 54, 0, 'T2C4ItadQvskjfOJ2qERoLCib1rbDoJU.jpg', '2020-01-23 14:37:23', '2020-01-23 14:37:23'),
(146, 54, 0, 'PNdtJhuhzAhWDtzI4ZkZ8sLIkyte1npG.jpg', '2020-01-23 14:37:23', '2020-01-23 14:37:23'),
(147, 54, 0, 'y0YeB0DjEnH5GQxi3ZOM2b6efIljRpSV.jpg', '2020-01-23 14:37:24', '2020-01-23 14:37:24'),
(148, 54, 0, 'SsM7A0NrGFNdS2PyA63XGj2qonKe9Ak2.jpg', '2020-01-23 14:37:24', '2020-01-23 14:37:24'),
(149, 54, 0, 'xPHrZLgpnt8tzDWGz056bwQYXosKH0p5.jpg', '2020-01-23 14:37:24', '2020-01-23 14:37:24'),
(150, 54, 0, 'GgctoYbU0NRZuwjfuz8ikeOSkflOTuaU.jpg', '2020-01-23 14:37:25', '2020-01-23 14:37:25'),
(165, 57, 0, 'PK9XLxLzSqyEL127MIvcUtvbhDQi3sIi.jpg', '2020-01-23 14:45:51', '2020-01-23 14:45:51'),
(166, 57, 0, 'UnyWEyyiNGF55CsmiMST2DZlqpPoAT5Q.jpg', '2020-01-23 14:45:51', '2020-01-23 14:45:51'),
(167, 57, 0, 'eQQJBVXLhJVhdhgdeB8zAy3sRsiCAnmT.jpg', '2020-01-23 14:45:52', '2020-01-23 14:45:52'),
(168, 57, 0, 'Na9zjgRaH9XGBjP8rbkb1fuK3zrEKDSn.jpg', '2020-01-23 14:45:52', '2020-01-23 14:45:52'),
(169, 57, 0, '2wAr1jgUZ5LEtC19bVbcI6N5Nhi1AV7y.jpg', '2020-01-23 14:45:52', '2020-01-23 14:45:52'),
(170, 57, 0, 'zMhFU7qfYPB9sd7mBSqSL1wElEdTW6pf.jpg', '2020-01-23 14:45:52', '2020-01-23 14:45:52'),
(171, 57, 0, 'an4qKjnirQl3Vop6rAxg8wFE9IiO95aB.jpg', '2020-01-23 14:45:53', '2020-01-23 14:45:53'),
(183, NULL, 0, '3TEw2zWgg9KTb4BWNwtpvDbBL39lnWnN.jpg', '2020-02-03 12:11:04', '2020-02-03 12:11:04'),
(184, NULL, 0, 'qi1lwB5HugXxCtIDCFztX0iejHxWD5rZ.jpg', '2020-02-03 12:11:04', '2020-02-03 12:11:04'),
(185, NULL, 0, 'nF0F4Pq4yiOIdkaCCFpT7lolDxhLItmg.jpg', '2020-02-03 12:11:05', '2020-02-03 12:11:05'),
(186, NULL, 0, 'pbcbE2I2I13xCuGuUbzjYzefatEU5PSp.jpg', '2020-02-03 12:11:05', '2020-02-03 12:11:05'),
(187, 71, 0, 'lTtAExjEzZ3BbOi6DraFNOSRbDOKy9wQ.jpg', '2020-02-06 09:43:49', '2020-02-06 09:43:49'),
(188, 71, 0, 'F021QZkxVmiFI9I6ggIODbgTAPtkvZOb.jpg', '2020-02-06 09:43:50', '2020-02-06 09:43:50'),
(189, NULL, 0, 'lTtAExjEzZ3BbOi6DraFNOSRbDOKy9wQ.jpg', '2020-02-06 09:45:16', '2020-02-06 09:45:16'),
(190, NULL, 0, 'F021QZkxVmiFI9I6ggIODbgTAPtkvZOb.jpg', '2020-02-06 09:45:16', '2020-02-06 09:45:16');

-- --------------------------------------------------------

--
-- Table structure for table `product_variants`
--

CREATE TABLE `product_variants` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `color_id` int(11) NOT NULL,
  `sku` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stock` int(11) NOT NULL,
  `tags` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_variants`
--

INSERT INTO `product_variants` (`id`, `product_id`, `color_id`, `sku`, `size`, `stock`, `tags`, `created_at`, `updated_at`) VALUES
(12, 39, 0, 'MRD', 'M', 100, '[\"m\",\"red\"]', '2020-01-16 18:06:06', '2020-01-16 18:06:06'),
(13, 39, 0, 'MBK', 'M', 200, '[\"m\",\"black\"]', '2020-01-16 18:06:43', '2020-01-16 18:06:43'),
(14, 40, 0, 'LRD', 'L', 200, '', '2020-01-16 18:47:52', '2020-01-16 18:47:52'),
(15, 40, 0, 'MRD', 'M', 200, '', '2020-01-16 18:48:21', '2020-01-16 18:48:21'),
(16, 40, 0, 'LBK', 'L', 200, '', '2020-01-16 18:49:19', '2020-01-16 18:49:19'),
(17, 40, 0, 'MBK', 'M', 200, '', '2020-01-16 18:49:41', '2020-01-16 18:49:41'),
(18, 41, 0, 'SPK', 'S', 200, '', '2020-01-16 18:54:45', '2020-01-16 18:54:45'),
(19, 41, 0, 'MPK', 'M', 30, '', '2020-01-16 18:55:17', '2020-01-16 18:55:17'),
(20, 41, 0, 'LWH', 'L', 50, '', '2020-01-16 18:55:43', '2020-01-16 18:55:43'),
(21, 41, 0, 'XLWH', 'XL', 100, '', '2020-01-16 18:56:57', '2020-01-16 18:56:57'),
(22, 41, 0, 'LPR', 'L', 150, '', '2020-01-16 18:57:38', '2020-01-16 18:57:38'),
(23, 41, 0, 'XSWH', 'XS', 345, '', '2020-01-16 20:29:00', '2020-01-16 20:29:00'),
(25, 39, 0, 'XLRD', 'XL', 1000, '', '2020-02-03 12:11:04', '2020-02-03 12:11:04'),
(26, 71, 0, 'MBK', 'M', 100, '', '2020-02-06 09:45:16', '2020-02-06 09:45:16'),
(27, 41, 3, 'LWH', 'L', 100, '', '2020-02-10 20:10:04', '2020-02-10 20:10:04');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `role`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Dusan', 'duki87', 'user', 'dusan@gmail.com', NULL, '$2y$10$w6il4TqeR5rZVZwfPi/37uoYNUhqiokw6J0kpFoITD2jI7sDyEV8i', NULL, '2019-11-10 19:05:05', '2019-11-10 19:05:05'),
(2, 'Gigi', 'gigi', 'user', 'gigi@gmail.com', NULL, '$2y$10$nLfgh0sXq1n1K0d1/R1sDuiJwKmjhu2EFpfFXJuqKMOqEydm62Gbu', NULL, '2019-11-12 14:32:38', '2019-11-12 14:32:38');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_email_unique` (`email`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_personal_access_clients_client_id_index` (`client_id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_url_unique` (`url`);

--
-- Indexes for table `product_colors`
--
ALTER TABLE `product_colors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `product_colors`
--
ALTER TABLE `product_colors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=191;

--
-- AUTO_INCREMENT for table `product_variants`
--
ALTER TABLE `product_variants`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
