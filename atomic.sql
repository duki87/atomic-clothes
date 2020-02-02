-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 02, 2020 at 11:39 PM
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

INSERT INTO `brands` (`id`, `title`, `description`, `logo`, `website`, `tags`, `created_at`, `updated_at`) VALUES
(1, 'Atomic', 'Atomic is our primary brand.', 'ukaVONUHw4XWHTuvVS8Pg2bbhxXb7uq3.png', 'http://www.atomic.com', '[\"atomic\"]', '2019-11-26 18:10:08', '2019-11-26 18:10:08'),
(2, 'Core', 'Core is a new brand which offers casual clothing.', 's2MC7Q27EWHnzi5Nvy3iiaxj3WKUmVOU.png', 'http://www.core-clothing.com', '[\"core\"]', '2019-11-26 18:35:13', '2019-11-26 18:35:13'),
(3, 'Proto', 'Proto is a new brand', 'yhHffY7rihunpd36BeLvTvYhEib0HTRL.png', 'http://www.proto.com', '[\"proto\"]', '2020-01-15 21:21:54', '2020-01-15 21:21:54');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `main` int(11) NOT NULL DEFAULT 0,
  `sub` int(11) NOT NULL DEFAULT 0,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tags` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `main`, `sub`, `title`, `tags`, `created_at`, `updated_at`) VALUES
(1, 0, 0, 'Men', '[\"men\"]', '2019-11-26 17:57:59', '2019-11-26 17:57:59'),
(2, 0, 0, 'Women', '[\"women\"]', '2019-11-26 17:58:11', '2019-11-26 17:58:11'),
(3, 0, 0, 'Children', '[\"children\"]', '2019-11-26 17:58:27', '2019-11-26 17:58:27'),
(4, 1, 0, 'Shirts', '[\"shirts\",\"men\"]', '2019-11-26 17:58:54', '2019-11-26 17:58:54'),
(5, 1, 4, 'Long Sleeve', '[\"men\",\"shirts\",\"long-sleeve\"]', '2019-11-26 17:59:21', '2019-11-26 17:59:21'),
(6, 2, 0, 'Shirts', '[\"women\",\"shirts\"]', '2019-11-26 17:59:43', '2019-11-26 17:59:43'),
(7, 2, 6, 'Long Sleeves', '[\"women\",\"shirts\",\"long-sleeve\"]', '2019-11-26 18:00:12', '2019-11-26 18:00:12'),
(8, 1, 0, 'T-Shirts', '[\"t-shirts\",\"men\"]', '2019-12-03 19:02:23', '2019-12-03 19:02:23'),
(9, 1, 8, 'V-Neck', '[\"t-shirts\",\"men\",\"v-neck\"]', '2019-12-03 19:05:13', '2019-12-03 19:05:13'),
(10, 1, 4, 'Short Sleeve', '[\"men\",\"shirts\",\"short-sleeve\"]', '2019-12-03 19:52:45', '2019-12-03 19:52:45'),
(11, 2, 0, 'Shirts', '[\"women-shirts\"]', '2020-01-06 10:08:23', '2020-01-06 10:08:23'),
(12, 2, 11, 'Short Sleeve', '[\"women-short-sleeve-shirts\"]', '2020-01-06 10:08:49', '2020-01-06 10:08:49'),
(13, 2, 0, 'T-Shirts', '[\"women\",\"t-shirts\"]', '2020-01-16 18:53:14', '2020-01-16 18:53:14'),
(14, 2, 13, 'Classic', '[\"classic\"]', '2020-01-16 18:53:31', '2020-01-16 18:53:31');

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
(19, '2020_02_02_191145_create_admins_table', 12);

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

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 'bEMao5yHMhlfbb1JxahM2Lt1vo71Pba7GB0KS2h0', 'http://localhost', 1, 0, 0, '2020-01-15 14:32:58', '2020-01-15 14:32:58'),
(2, NULL, 'Laravel Password Grant Client', 'RSXfutimPXLF6ZBcZ3qan5nCJmKw9UH4tP8zyo3f', 'http://localhost', 0, 1, 0, '2020-01-15 14:32:58', '2020-01-15 14:32:58');

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

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2020-01-15 14:32:58', '2020-01-15 14:32:58');

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

INSERT INTO `products` (`id`, `main_category_id`, `sub_category_id`, `category_id`, `brand_id`, `code`, `title`, `description`, `price`, `discount`, `image_folder`, `cover_image`, `tags`, `status`, `created_at`, `updated_at`) VALUES
(39, 1, 8, 9, 2, 'YMRS094451', 'Men T-Shirt M-113', 'Men T-Shirt M-113 Men T-Shirt M-113 Men T-Shirt M-113 Men T-Shirt M-113 Men T-Shirt M-113', 20.99, NULL, '16012020190353-0raywsr8qmuh6fve', 'I2qAAvwG2BpfVuU3YKM5jBV9LMoNvgkD.jpg', '[\"men-t-shirt-m-113\"]', 1, '2020-01-16 18:03:53', '2020-01-16 18:04:41'),
(40, 1, 4, 5, 1, 'YEC2092441', 'Men Shirt Classic A-235', 'Men Shirt Classic A-235 Men Shirt Classic A-235 Men Shirt Classic A-235 Men Shirt Classic A-235 Men Shirt Classic A-235', 25.99, NULL, '16012020194556-c97adnlgjozezxfz', '0MVxb1NOR3fe6r4INZIcm5Wtl0tLVguO.jpg', '', 1, '2020-01-16 18:45:56', '2020-01-16 18:47:14'),
(41, 2, 13, 14, 2, 'QIDK046902', 'Women T-Shirt Y-12', 'Women T-Shirt Y-12 Women T-Shirt Y-12 Women T-Shirt Y-12 Women T-Shirt Y-12 Women T-Shirt Y-12', 14.99, 11.99, '16012020194959-zgiciiayj3doqxzt', 'uoZ3LKkVhILqki542Zkj4GufR89WzNGo.jpg', '', 1, '2020-01-16 18:49:59', '2020-01-16 18:54:16'),
(44, 0, 0, 0, 0, '32GS002453', 'Product title', 'Product description must have at least 20 characters', 0.00, 0, '23012020144939-kawtgggfpf80zr0g', 'not_selected', '[\"product\",\"tags\"]', 0, '2020-01-23 13:49:39', '2020-01-23 13:49:39'),
(45, 0, 0, 0, 0, '3EN8079769', 'Product title', 'Product description must have at least 20 characters', 0.00, 0, '23012020145823-5mgiq3iyuflwyn9v', 'not_selected', '[\"product\",\"tags\"]', 0, '2020-01-23 13:58:23', '2020-01-23 13:58:23'),
(46, 0, 0, 0, 0, 'F0SN043107', 'Product title', 'Product description must have at least 20 characters', 0.00, 0, '23012020145859-i1kfyhmrwx9ovx0b', 'not_selected', '[\"product\",\"tags\"]', 0, '2020-01-23 13:58:59', '2020-01-23 13:58:59'),
(47, 0, 0, 0, 0, 'MNWU080447', 'Product title', 'Product description must have at least 20 characters', 0.00, 0, '23012020145930-santjcrv5v7mh5r0', 'not_selected', '[\"product\",\"tags\"]', 0, '2020-01-23 13:59:30', '2020-01-23 13:59:30'),
(48, 0, 0, 0, 0, 'QVOR080029', 'Product title', 'Product description must have at least 20 characters', 0.00, 0, '23012020145954-byhaadnzuop6amsh', 'not_selected', '[\"product\",\"tags\"]', 0, '2020-01-23 13:59:54', '2020-01-23 13:59:54'),
(49, 0, 0, 0, 0, 'HAL5054490', 'Product title', 'Product description must have at least 20 characters', 0.00, 0, '23012020151455-mc8modnmegq2gatn', 'not_selected', '[\"product\",\"tags\"]', 0, '2020-01-23 14:14:55', '2020-01-23 14:14:55'),
(50, 0, 0, 0, 0, 'HECP015223', 'Product title', 'Product description must have at least 20 characters', 0.00, 0, '23012020151605-olc6yhwfmyzcgsk6', 'not_selected', '[\"product\",\"tags\"]', 0, '2020-01-23 14:16:05', '2020-01-23 14:16:05'),
(51, 0, 0, 0, 0, 'XOMD058602', 'Product title', 'Product description must have at least 20 characters', 0.00, 0, '23012020151724-cpjtql4emgxvx9tx', 'not_selected', '[\"product\",\"tags\"]', 0, '2020-01-23 14:17:24', '2020-01-23 14:17:24'),
(52, 0, 0, 0, 0, '4AIW020872', 'Product title', 'Product description must have at least 20 characters', 0.00, 0, '23012020152135-i6az03kmpwy9zxbb', 'not_selected', '[\"product\",\"tags\"]', 0, '2020-01-23 14:21:35', '2020-01-23 14:21:35'),
(53, 0, 0, 0, 0, 'XGAL037702', 'Product title', 'Product description must have at least 20 characters', 0.00, 0, '23012020153636-8boab8cufvgukgti', 'not_selected', '[\"product\",\"tags\"]', 0, '2020-01-23 14:36:36', '2020-01-23 14:36:36'),
(54, 0, 0, 0, 0, 'YQM8047613', 'Product title', 'Product description must have at least 20 characters', 0.00, 0, '23012020153718-cm3tehcwybp5ywob', 'not_selected', '[\"product\",\"tags\"]', 0, '2020-01-23 14:37:18', '2020-01-23 14:37:18'),
(55, 0, 0, 0, 0, 'OYWE074981', 'Product title', 'Product description must have at least 20 characters', 0.00, 0, '23012020154038-pmrqdv18wtzdu8o6', 'not_selected', '[\"product\",\"tags\"]', 0, '2020-01-23 14:40:38', '2020-01-23 14:40:38'),
(56, 0, 0, 0, 0, 'PHN5078021', 'Product title', 'Product description must have at least 20 characters', 0.00, 0, '23012020154156-e4pktqtyuytofpes', 'not_selected', '[\"product\",\"tags\"]', 0, '2020-01-23 14:41:56', '2020-01-23 14:41:56'),
(57, 0, 0, 0, 0, '4ZDE027951', 'Product title', 'Product description must have at least 20 characters', 0.00, 0, '23012020154544-vk5e4ix8odi58ilv', 'not_selected', '[\"product\",\"tags\"]', 0, '2020-01-23 14:45:44', '2020-01-23 14:45:44'),
(58, 0, 0, 0, 0, 'ORZQ066008', 'Product title', 'Product description must have at least 20 characters', 0.00, 0, '23012020154639-ahg6i19grt2m2em0', 'not_selected', '[\"product\",\"tags\"]', 0, '2020-01-23 14:46:39', '2020-01-23 14:46:39'),
(59, 0, 0, 0, 0, 'RKYX041175', 'Product title', 'Product description must have at least 20 characters', 0.00, 0, '23012020154907-mhcoigltvmzsmx61', 'not_selected', '[\"product\",\"tags\"]', 0, '2020-01-23 14:49:07', '2020-01-23 14:49:07'),
(60, 0, 0, 0, 0, 'WDVS062618', 'Product title', 'Product description must have at least 20 characters', 0.00, 0, '23012020155022-81mo3n6lzqih9cyp', 'not_selected', '[\"product\",\"tags\"]', 0, '2020-01-23 14:50:22', '2020-01-23 14:50:22');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `variant_id`, `image`, `created_at`, `updated_at`) VALUES
(15, 39, NULL, 'I2qAAvwG2BpfVuU3YKM5jBV9LMoNvgkD.jpg', '2020-01-16 18:04:37', '2020-01-16 18:04:37'),
(16, 39, NULL, 'aR5lcLImOdGJFTpuryzn7uH7evuzjDhG.jpg', '2020-01-16 18:04:38', '2020-01-16 18:04:38'),
(17, 39, NULL, 'DTLeL4ltOYH1BfwOhG9se3pMjnso80pV.jpg', '2020-01-16 18:04:38', '2020-01-16 18:04:38'),
(18, 39, NULL, 'qi1lwB5HugXxCtIDCFztX0iejHxWD5rZ.jpg', '2020-01-16 18:04:38', '2020-01-16 18:04:38'),
(19, 39, NULL, 'pbcbE2I2I13xCuGuUbzjYzefatEU5PSp.jpg', '2020-01-16 18:04:38', '2020-01-16 18:04:38'),
(20, 39, NULL, 'nF0F4Pq4yiOIdkaCCFpT7lolDxhLItmg.jpg', '2020-01-16 18:04:39', '2020-01-16 18:04:39'),
(21, 39, NULL, '3TEw2zWgg9KTb4BWNwtpvDbBL39lnWnN.jpg', '2020-01-16 18:04:39', '2020-01-16 18:04:39'),
(22, NULL, 12, 'qi1lwB5HugXxCtIDCFztX0iejHxWD5rZ.jpg', '2020-01-16 18:06:06', '2020-01-16 18:06:06'),
(23, NULL, 12, 'pbcbE2I2I13xCuGuUbzjYzefatEU5PSp.jpg', '2020-01-16 18:06:06', '2020-01-16 18:06:06'),
(24, NULL, 12, 'nF0F4Pq4yiOIdkaCCFpT7lolDxhLItmg.jpg', '2020-01-16 18:06:06', '2020-01-16 18:06:06'),
(25, NULL, 12, '3TEw2zWgg9KTb4BWNwtpvDbBL39lnWnN.jpg', '2020-01-16 18:06:06', '2020-01-16 18:06:06'),
(26, NULL, 13, 'I2qAAvwG2BpfVuU3YKM5jBV9LMoNvgkD.jpg', '2020-01-16 18:06:43', '2020-01-16 18:06:43'),
(27, NULL, 13, 'aR5lcLImOdGJFTpuryzn7uH7evuzjDhG.jpg', '2020-01-16 18:06:43', '2020-01-16 18:06:43'),
(28, NULL, 13, 'DTLeL4ltOYH1BfwOhG9se3pMjnso80pV.jpg', '2020-01-16 18:06:43', '2020-01-16 18:06:43'),
(29, 40, NULL, '0MVxb1NOR3fe6r4INZIcm5Wtl0tLVguO.jpg', '2020-01-16 18:46:08', '2020-01-16 18:46:08'),
(30, 40, NULL, 'oE6T6HjLQ7rZJ205ydpQZaAApgB4CToW.jpg', '2020-01-16 18:46:08', '2020-01-16 18:46:08'),
(31, 40, NULL, 'zUGNSf5PmveHw0RW9qblaz06YPxi2SmN.jpg', '2020-01-16 18:46:08', '2020-01-16 18:46:08'),
(32, 40, NULL, 'yOBS5p5U6bNzajXP0NFHtHkK8gv0SIle.jpg', '2020-01-16 18:46:09', '2020-01-16 18:46:09'),
(33, 40, NULL, 'lyBzgZQXn6i82UkfFM4Zfi7Vsutb16m6.jpg', '2020-01-16 18:46:09', '2020-01-16 18:46:09'),
(34, 40, NULL, 'uDYXb5NoDxlHxpMfS65kjHExyugu7X2Y.jpg', '2020-01-16 18:46:09', '2020-01-16 18:46:09'),
(35, NULL, 14, '0MVxb1NOR3fe6r4INZIcm5Wtl0tLVguO.jpg', '2020-01-16 18:47:52', '2020-01-16 18:47:52'),
(36, NULL, 14, 'oE6T6HjLQ7rZJ205ydpQZaAApgB4CToW.jpg', '2020-01-16 18:47:52', '2020-01-16 18:47:52'),
(37, NULL, 15, '0MVxb1NOR3fe6r4INZIcm5Wtl0tLVguO.jpg', '2020-01-16 18:48:21', '2020-01-16 18:48:21'),
(38, NULL, 15, 'oE6T6HjLQ7rZJ205ydpQZaAApgB4CToW.jpg', '2020-01-16 18:48:21', '2020-01-16 18:48:21'),
(39, NULL, 16, 'lyBzgZQXn6i82UkfFM4Zfi7Vsutb16m6.jpg', '2020-01-16 18:49:19', '2020-01-16 18:49:19'),
(40, NULL, 16, 'uDYXb5NoDxlHxpMfS65kjHExyugu7X2Y.jpg', '2020-01-16 18:49:19', '2020-01-16 18:49:19'),
(41, NULL, 17, 'uDYXb5NoDxlHxpMfS65kjHExyugu7X2Y.jpg', '2020-01-16 18:49:41', '2020-01-16 18:49:41'),
(42, NULL, 17, 'lyBzgZQXn6i82UkfFM4Zfi7Vsutb16m6.jpg', '2020-01-16 18:49:41', '2020-01-16 18:49:41'),
(52, 41, NULL, 'ZLGlXIMZFe94fwgaM6FFiPvNoEMvp1KH.jpg', '2020-01-16 18:50:43', '2020-01-16 18:50:43'),
(53, 41, NULL, 'yRMi8uJZbFYxEoUe2UimmPT29eS7mOQX.jpg', '2020-01-16 18:50:43', '2020-01-16 18:50:43'),
(54, 41, NULL, 'ApEIgKMDhIIHfCZmHHg4ovS4Oxbkauyo.jpg', '2020-01-16 18:50:44', '2020-01-16 18:50:44'),
(55, 41, NULL, 'SLTYHY348oEYHkiHCtNxE0b5YNwi0kdG.jpg', '2020-01-16 18:50:44', '2020-01-16 18:50:44'),
(56, 41, NULL, '8m24M2OR4NBmB4ECRarz3W5kAbuhqoyr.jpg', '2020-01-16 18:50:45', '2020-01-16 18:50:45'),
(57, 41, NULL, 'jjuMnkY4VltA7fXQjgZysBCB3ssf3yUE.jpg', '2020-01-16 18:50:45', '2020-01-16 18:50:45'),
(58, 41, NULL, '22MPdyV1jjydA7TezsYMpPGAnox0uhIJ.jpg', '2020-01-16 18:50:45', '2020-01-16 18:50:45'),
(59, 41, NULL, 'dof7iswv3cLMWc4lKkMSSvUCP447C17k.jpg', '2020-01-16 18:50:45', '2020-01-16 18:50:45'),
(60, 41, NULL, '47SeeKDfvoG3wkrbJd5MSH1ZahnXEdfV.jpg', '2020-01-16 18:50:46', '2020-01-16 18:50:46'),
(61, 41, NULL, 'lnBLBRnw8O0CuAiLsvGDAFVLrlgvGhZq.jpg', '2020-01-16 18:50:46', '2020-01-16 18:50:46'),
(62, 41, NULL, 'uoZ3LKkVhILqki542Zkj4GufR89WzNGo.jpg', '2020-01-16 18:50:46', '2020-01-16 18:50:46'),
(63, 41, NULL, 'OgB5FaX6e8Gz0N360i4xHLzJ46w54nkU.jpg', '2020-01-16 18:50:47', '2020-01-16 18:50:47'),
(64, 41, NULL, 'Clu7fCdUxoPN6f7s2O3dSta6WKeOPzUe.jpg', '2020-01-16 18:50:47', '2020-01-16 18:50:47'),
(65, NULL, 18, 'ZLGlXIMZFe94fwgaM6FFiPvNoEMvp1KH.jpg', '2020-01-16 18:54:45', '2020-01-16 18:54:45'),
(66, NULL, 18, 'yRMi8uJZbFYxEoUe2UimmPT29eS7mOQX.jpg', '2020-01-16 18:54:45', '2020-01-16 18:54:45'),
(67, NULL, 18, 'ApEIgKMDhIIHfCZmHHg4ovS4Oxbkauyo.jpg', '2020-01-16 18:54:45', '2020-01-16 18:54:45'),
(68, NULL, 18, 'SLTYHY348oEYHkiHCtNxE0b5YNwi0kdG.jpg', '2020-01-16 18:54:45', '2020-01-16 18:54:45'),
(69, NULL, 19, 'ZLGlXIMZFe94fwgaM6FFiPvNoEMvp1KH.jpg', '2020-01-16 18:55:17', '2020-01-16 18:55:17'),
(70, NULL, 19, 'yRMi8uJZbFYxEoUe2UimmPT29eS7mOQX.jpg', '2020-01-16 18:55:17', '2020-01-16 18:55:17'),
(71, NULL, 19, 'ApEIgKMDhIIHfCZmHHg4ovS4Oxbkauyo.jpg', '2020-01-16 18:55:17', '2020-01-16 18:55:17'),
(72, NULL, 19, 'SLTYHY348oEYHkiHCtNxE0b5YNwi0kdG.jpg', '2020-01-16 18:55:17', '2020-01-16 18:55:17'),
(73, NULL, 20, 'uoZ3LKkVhILqki542Zkj4GufR89WzNGo.jpg', '2020-01-16 18:55:43', '2020-01-16 18:55:43'),
(74, NULL, 20, 'OgB5FaX6e8Gz0N360i4xHLzJ46w54nkU.jpg', '2020-01-16 18:55:43', '2020-01-16 18:55:43'),
(75, NULL, 20, 'Clu7fCdUxoPN6f7s2O3dSta6WKeOPzUe.jpg', '2020-01-16 18:55:43', '2020-01-16 18:55:43'),
(76, NULL, 20, 'lnBLBRnw8O0CuAiLsvGDAFVLrlgvGhZq.jpg', '2020-01-16 18:55:43', '2020-01-16 18:55:43'),
(77, NULL, 21, 'lnBLBRnw8O0CuAiLsvGDAFVLrlgvGhZq.jpg', '2020-01-16 18:56:57', '2020-01-16 18:56:57'),
(78, NULL, 21, 'uoZ3LKkVhILqki542Zkj4GufR89WzNGo.jpg', '2020-01-16 18:56:57', '2020-01-16 18:56:57'),
(79, NULL, 21, 'OgB5FaX6e8Gz0N360i4xHLzJ46w54nkU.jpg', '2020-01-16 18:56:57', '2020-01-16 18:56:57'),
(80, NULL, 21, 'Clu7fCdUxoPN6f7s2O3dSta6WKeOPzUe.jpg', '2020-01-16 18:56:57', '2020-01-16 18:56:57'),
(81, NULL, 22, '8m24M2OR4NBmB4ECRarz3W5kAbuhqoyr.jpg', '2020-01-16 18:57:38', '2020-01-16 18:57:38'),
(82, NULL, 22, 'jjuMnkY4VltA7fXQjgZysBCB3ssf3yUE.jpg', '2020-01-16 18:57:38', '2020-01-16 18:57:38'),
(83, NULL, 22, '22MPdyV1jjydA7TezsYMpPGAnox0uhIJ.jpg', '2020-01-16 18:57:38', '2020-01-16 18:57:38'),
(84, NULL, 22, 'dof7iswv3cLMWc4lKkMSSvUCP447C17k.jpg', '2020-01-16 18:57:38', '2020-01-16 18:57:38'),
(85, NULL, 22, '47SeeKDfvoG3wkrbJd5MSH1ZahnXEdfV.jpg', '2020-01-16 18:57:38', '2020-01-16 18:57:38'),
(86, NULL, 23, 'uoZ3LKkVhILqki542Zkj4GufR89WzNGo.jpg', '2020-01-16 20:29:01', '2020-01-16 20:29:01'),
(87, NULL, 23, 'OgB5FaX6e8Gz0N360i4xHLzJ46w54nkU.jpg', '2020-01-16 20:29:01', '2020-01-16 20:29:01'),
(88, NULL, 23, 'lnBLBRnw8O0CuAiLsvGDAFVLrlgvGhZq.jpg', '2020-01-16 20:29:01', '2020-01-16 20:29:01'),
(89, NULL, 23, 'Clu7fCdUxoPN6f7s2O3dSta6WKeOPzUe.jpg', '2020-01-16 20:29:01', '2020-01-16 20:29:01'),
(100, 46, NULL, 'ckaeIGFbOpGpqUsiCQuCVGEhctHtLmuW.jpg', '2020-01-23 13:59:04', '2020-01-23 13:59:04'),
(101, 46, NULL, 'FmHtUOFNA68kDAj6bd9MYN85B1OoieOm.jpg', '2020-01-23 13:59:04', '2020-01-23 13:59:04'),
(144, 54, NULL, 'idTLx459JRTYTE15zrvphWDQxC93f90n.jpg', '2020-01-23 14:37:23', '2020-01-23 14:37:23'),
(145, 54, NULL, 'T2C4ItadQvskjfOJ2qERoLCib1rbDoJU.jpg', '2020-01-23 14:37:23', '2020-01-23 14:37:23'),
(146, 54, NULL, 'PNdtJhuhzAhWDtzI4ZkZ8sLIkyte1npG.jpg', '2020-01-23 14:37:23', '2020-01-23 14:37:23'),
(147, 54, NULL, 'y0YeB0DjEnH5GQxi3ZOM2b6efIljRpSV.jpg', '2020-01-23 14:37:24', '2020-01-23 14:37:24'),
(148, 54, NULL, 'SsM7A0NrGFNdS2PyA63XGj2qonKe9Ak2.jpg', '2020-01-23 14:37:24', '2020-01-23 14:37:24'),
(149, 54, NULL, 'xPHrZLgpnt8tzDWGz056bwQYXosKH0p5.jpg', '2020-01-23 14:37:24', '2020-01-23 14:37:24'),
(150, 54, NULL, 'GgctoYbU0NRZuwjfuz8ikeOSkflOTuaU.jpg', '2020-01-23 14:37:25', '2020-01-23 14:37:25'),
(165, 57, NULL, 'PK9XLxLzSqyEL127MIvcUtvbhDQi3sIi.jpg', '2020-01-23 14:45:51', '2020-01-23 14:45:51'),
(166, 57, NULL, 'UnyWEyyiNGF55CsmiMST2DZlqpPoAT5Q.jpg', '2020-01-23 14:45:51', '2020-01-23 14:45:51'),
(167, 57, NULL, 'eQQJBVXLhJVhdhgdeB8zAy3sRsiCAnmT.jpg', '2020-01-23 14:45:52', '2020-01-23 14:45:52'),
(168, 57, NULL, 'Na9zjgRaH9XGBjP8rbkb1fuK3zrEKDSn.jpg', '2020-01-23 14:45:52', '2020-01-23 14:45:52'),
(169, 57, NULL, '2wAr1jgUZ5LEtC19bVbcI6N5Nhi1AV7y.jpg', '2020-01-23 14:45:52', '2020-01-23 14:45:52'),
(170, 57, NULL, 'zMhFU7qfYPB9sd7mBSqSL1wElEdTW6pf.jpg', '2020-01-23 14:45:52', '2020-01-23 14:45:52'),
(171, 57, NULL, 'an4qKjnirQl3Vop6rAxg8wFE9IiO95aB.jpg', '2020-01-23 14:45:53', '2020-01-23 14:45:53');

-- --------------------------------------------------------

--
-- Table structure for table `product_variants`
--

CREATE TABLE `product_variants` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `sku` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stock` int(11) NOT NULL,
  `tags` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_variants`
--

INSERT INTO `product_variants` (`id`, `product_id`, `sku`, `size`, `color`, `stock`, `tags`, `created_at`, `updated_at`) VALUES
(12, 39, 'MRD', 'M', 'Red', 100, '[\"m\",\"red\"]', '2020-01-16 18:06:06', '2020-01-16 18:06:06'),
(13, 39, 'MBK', 'M', 'Black', 200, '[\"m\",\"black\"]', '2020-01-16 18:06:43', '2020-01-16 18:06:43'),
(14, 40, 'LRD', 'L', 'Red', 200, '', '2020-01-16 18:47:52', '2020-01-16 18:47:52'),
(15, 40, 'MRD', 'M', 'Red', 200, '', '2020-01-16 18:48:21', '2020-01-16 18:48:21'),
(16, 40, 'LBK', 'L', 'Black', 200, '', '2020-01-16 18:49:19', '2020-01-16 18:49:19'),
(17, 40, 'MBK', 'M', 'Black', 200, '', '2020-01-16 18:49:41', '2020-01-16 18:49:41'),
(18, 41, 'SPK', 'S', 'Pink', 200, '', '2020-01-16 18:54:45', '2020-01-16 18:54:45'),
(19, 41, 'MPK', 'M', 'Pink', 30, '', '2020-01-16 18:55:17', '2020-01-16 18:55:17'),
(20, 41, 'LWH', 'L', 'White', 50, '', '2020-01-16 18:55:43', '2020-01-16 18:55:43'),
(21, 41, 'XLWH', 'XL', 'White', 100, '', '2020-01-16 18:56:57', '2020-01-16 18:56:57'),
(22, 41, 'LPR', 'L', 'Purple', 150, '', '2020-01-16 18:57:38', '2020-01-16 18:57:38'),
(23, 41, 'XSWH', 'XS', 'White', 345, '', '2020-01-16 20:29:00', '2020-01-16 20:29:00');

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=183;

--
-- AUTO_INCREMENT for table `product_variants`
--
ALTER TABLE `product_variants`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
