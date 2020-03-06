-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 06, 2020 at 02:48 PM
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
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `total` double(8,2) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `user_id`, `total`, `status`, `created_at`, `updated_at`) VALUES
(33, 0, 47.97, 1, '2020-03-05 14:33:15', '2020-03-05 15:33:06');

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL,
  `product_price` double(8,2) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `subtotal` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cart_items`
--

INSERT INTO `cart_items` (`id`, `cart_id`, `product_id`, `variant_id`, `product_price`, `quantity`, `subtotal`, `created_at`, `updated_at`) VALUES
(34, 33, 4, 11, 15.99, 2, 47.97, '2020-03-05 15:10:37', '2020-03-05 15:11:36');

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
(28, '2020_02_10_132743_alter_product_images_delete_variant_id', 21),
(29, '2020_02_22_100655_alter_product_images_table_make_color_id_nullable', 22),
(30, '2020_02_22_105125_alter_product_images_table_add_default_value_to_color_id', 23),
(31, '2020_02_26_160906_create_carts_table', 24),
(32, '2020_02_26_171142_create_cart_items_table', 24),
(33, '2020_03_03_142342_ater_cart_items_table_add_variant_id', 25);

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
(4, 1, 4, 5, 2, 'PT3E014622', 'shirt', 'shirt', 'shirt shirt shirt shirt shirt shirt shirt shirt shirt shirt shirt', 21.99, 15.99, '22022020101658-za3y7mbuagi4oydt', 'tSk1i69rQFOKzD8dUCdQ6AOgVrunpiBQ.jpg', '[\"shirt\"]', 1, '2020-02-22 09:16:58', '2020-02-22 09:18:02'),
(5, 2, 13, 14, 3, 'DHXO023077', 'Women T-Shirt', 'women-t-shirt', 'Very nice t-shirt available in three colors and all sizes!', 5.99, 3.99, '03032020141431-bgmiugx1cwwls3kk', 'a8LMPHkp1i1GoWvdhvRSu0k923NYHhJr.jpg', '', 1, '2020-03-03 13:14:31', '2020-03-03 13:15:43'),
(6, 1, 4, 5, 2, 'QLKJ017588', 'Core Shirt M-122', 'core-shirt-m-122', 'Core Shirt M-122 Core Shirt M-122 Core Shirt M-122', 20.99, NULL, '06032020114442-lp0dqldo1cv2vvlb', 'nAdsIJdoqMkbBESiWjDinwESYu7JKDh5.jpg', '', 1, '2020-03-06 10:44:43', '2020-03-06 10:45:43'),
(7, 1, 4, 5, 1, 'VYE9039252', 'Shirt Atomic AX-12', 'shirt-atomic-ax-12', 'Shirt Atomic AX-12 Shirt Atomic AX-12 Shirt Atomic AX-12', 19.95, NULL, '06032020114650-bpw0igm8a3rcaxtx', 'tM6Q8QsdryBGleh8hQoR7CLsgL4zoRld.jpg', '', 1, '2020-03-06 10:46:50', '2020-03-06 10:47:33'),
(8, 1, 4, 5, 1, '9LWP009105', 'Atomic Classic Shirt C-13', 'atomic-classic-shirt-c-13', 'Atomic Classic Shirt C-13 Atomic Classic Shirt C-13 Atomic Classic Shirt C-13', 12.99, 10.99, '06032020120047-vl550dqxnvqfjhfe', 'zRn4bGt2556SpVxV2EygPMSZiJB4QU6K.jpg', '', 1, '2020-03-06 11:00:47', '2020-03-06 11:02:14');

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
(1, 4, 'RED TARTAN PLAID SHIRT', '2020-02-22 09:27:03', '2020-02-22 09:27:03'),
(2, 4, 'BLACK TARTAN PLAID SHIRT', '2020-02-22 09:49:18', '2020-02-22 09:49:18'),
(3, 4, 'BROWN TARTAN PLAID SHIRT', '2020-02-22 09:49:31', '2020-02-22 09:49:31'),
(4, 5, 'Pink', '2020-03-03 13:16:31', '2020-03-03 13:16:31'),
(5, 5, 'Purple', '2020-03-03 13:16:45', '2020-03-03 13:16:45'),
(6, 5, 'White', '2020-03-03 13:16:52', '2020-03-03 13:16:52'),
(7, 6, 'Black and white', '2020-03-06 10:46:08', '2020-03-06 10:46:08'),
(8, 7, 'Green with black squares', '2020-03-06 10:47:54', '2020-03-06 10:47:54'),
(9, 8, 'Red with black squares', '2020-03-06 11:02:36', '2020-03-06 11:02:36');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `color_id` int(11) DEFAULT 0,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `color_id`, `image`, `created_at`, `updated_at`) VALUES
(1, 4, 1, 'I1Z6fHhW3U6eigOIuKLoBui4nOkfz7Rn.jpg', '2020-02-22 09:17:32', '2020-02-22 09:27:03'),
(2, 4, 1, 'oQ9dEpHKYl8q97k9o1ExPlOeV8vsMBJB.jpg', '2020-02-22 09:17:33', '2020-02-22 09:27:03'),
(3, 4, 3, '8H8avp8rlDc66HAt6RwOdmOvuhiMsXkC.jpg', '2020-02-22 09:17:33', '2020-02-22 09:49:31'),
(4, 4, 3, '5ncGCL3NE6DEvhahincm3s1CoaPv5ZJ4.jpg', '2020-02-22 09:17:33', '2020-02-22 09:49:31'),
(5, 4, 2, 'tSk1i69rQFOKzD8dUCdQ6AOgVrunpiBQ.jpg', '2020-02-22 09:17:34', '2020-02-22 09:49:18'),
(6, 4, 2, 'M5KXCF79R55pqW5JplnySSpL2u6UPHES.jpg', '2020-02-22 09:17:34', '2020-02-22 09:49:18'),
(7, 5, 4, 'a8LMPHkp1i1GoWvdhvRSu0k923NYHhJr.jpg', '2020-03-03 13:14:51', '2020-03-03 13:16:31'),
(8, 5, 4, 'DpbkX6Bw4u1e5cCP28B8gljm7VBzj7XB.jpg', '2020-03-03 13:14:51', '2020-03-03 13:16:31'),
(9, 5, 4, 'ZCpNV7vA4tgNUhfZbFm1sDCicGdAQOkC.jpg', '2020-03-03 13:14:52', '2020-03-03 13:16:31'),
(10, 5, 4, 'MfnHEWAzy3u2rZDL7jDtS1NKl2k7zlAY.jpg', '2020-03-03 13:14:52', '2020-03-03 13:16:31'),
(11, 5, 5, 'WHrMjnBr9XXHeoSEO7UDwSPl06GvV9gQ.jpg', '2020-03-03 13:14:52', '2020-03-03 13:16:45'),
(12, 5, 5, 'LuJfATNHCaeVGCG8imUtzsmh4IQAyovZ.jpg', '2020-03-03 13:14:53', '2020-03-03 13:16:46'),
(13, 5, 5, 'QObwGCt19AbzwADCE8RCgSm5p5m1xw5j.jpg', '2020-03-03 13:14:53', '2020-03-03 13:16:46'),
(14, 5, 5, '2nHcqIVejuSqmPptPcsIOuSFTF0zQ3ih.jpg', '2020-03-03 13:14:53', '2020-03-03 13:16:46'),
(15, 5, 5, '7TeYobX6tES6cbzcOpkniJ71mwNyb4VH.jpg', '2020-03-03 13:14:54', '2020-03-03 13:16:46'),
(16, 5, 6, 'Hq7RvnaqX9zJvkSqZE6uGx2WhvemetCz.jpg', '2020-03-03 13:14:54', '2020-03-03 13:16:52'),
(17, 5, 6, 'D1NlyFJ9zoz1oscJZW9HpF8sdY1Xgaxd.jpg', '2020-03-03 13:14:54', '2020-03-03 13:16:52'),
(18, 5, 6, 'mUGU4Fni9qb51Wa6V2ZNzG0mgXgoShpX.jpg', '2020-03-03 13:14:55', '2020-03-03 13:16:52'),
(19, 5, 6, 'sxNRsByObkuz0Pf8bQ1cs6myIYwEXU0y.jpg', '2020-03-03 13:14:55', '2020-03-03 13:16:52'),
(20, 6, 7, 'nAdsIJdoqMkbBESiWjDinwESYu7JKDh5.jpg', '2020-03-06 10:45:34', '2020-03-06 10:46:08'),
(21, 7, 8, 'tM6Q8QsdryBGleh8hQoR7CLsgL4zoRld.jpg', '2020-03-06 10:47:21', '2020-03-06 10:47:54'),
(22, 8, 9, 'zRn4bGt2556SpVxV2EygPMSZiJB4QU6K.jpg', '2020-03-06 11:01:34', '2020-03-06 11:02:36');

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
(1, 5, 4, 'PKL', 'L', 200, '', '2020-03-03 13:59:14', '2020-03-05 15:33:06'),
(2, 5, 4, 'PKM', 'M', 200, '', '2020-03-03 13:59:25', '2020-03-03 13:59:25'),
(3, 5, 4, 'PKXL', 'XL', 1000, '', '2020-03-03 13:59:39', '2020-03-03 13:59:39'),
(4, 5, 5, 'PPS', 'S', 203, '', '2020-03-03 13:59:51', '2020-03-04 18:51:09'),
(5, 5, 5, 'PPL', 'L', 300, '', '2020-03-03 14:00:04', '2020-03-05 15:24:06'),
(6, 5, 6, 'WHXS', 'XS', 607, '', '2020-03-03 14:00:18', '2020-03-04 18:51:09'),
(7, 5, 6, 'WHS', 'S', 400, '', '2020-03-03 14:00:29', '2020-03-03 14:00:29'),
(8, 5, 6, 'WHL', 'L', 330, '', '2020-03-03 14:00:41', '2020-03-03 14:00:41'),
(9, 4, 1, 'RDL', 'L', 2, '', '2020-03-03 14:01:20', '2020-03-05 15:29:16'),
(10, 4, 1, 'RDXL', 'XL', 400, '', '2020-03-03 14:01:40', '2020-03-03 14:01:40'),
(11, 4, 2, 'BKM', 'M', 98, '', '2020-03-03 14:01:52', '2020-03-05 15:11:36'),
(12, 4, 3, 'BRL', 'L', 408, '', '2020-03-03 14:02:11', '2020-03-05 15:23:58'),
(13, 4, 3, 'BRM', 'M', 500, '', '2020-03-03 14:02:28', '2020-03-03 14:02:28'),
(14, 6, 7, 'BWL', 'L', 1000, '', '2020-03-06 10:46:26', '2020-03-06 10:46:26'),
(15, 7, 8, 'GBM', 'M', 500, '', '2020-03-06 10:48:14', '2020-03-06 10:48:14'),
(16, 8, 9, 'RBL', 'L', 500, '', '2020-03-06 11:02:59', '2020-03-06 11:02:59'),
(17, 8, 9, 'RBS', 'S', 100, '', '2020-03-06 11:03:08', '2020-03-06 11:03:08'),
(18, 8, 9, 'RBL', 'L', 1800, '', '2020-03-06 11:03:23', '2020-03-06 11:03:23');

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
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
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
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `product_colors`
--
ALTER TABLE `product_colors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `product_variants`
--
ALTER TABLE `product_variants`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
