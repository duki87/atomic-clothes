-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 03, 2019 at 10:00 PM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.8

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
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
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
(2, 'Core', 'Core is a new brand which offers casual clothing.', 's2MC7Q27EWHnzi5Nvy3iiaxj3WKUmVOU.png', 'http://www.core-clothing.com', '[\"core\"]', '2019-11-26 18:35:13', '2019-11-26 18:35:13');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `main` int(11) NOT NULL DEFAULT '0',
  `sub` int(11) NOT NULL DEFAULT '0',
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
(10, 1, 4, 'Short Sleeve', '[\"men\",\"shirts\",\"short-sleeve\"]', '2019-12-03 19:52:45', '2019-12-03 19:52:45');

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
(7, '2019_12_03_201632_add_discount_to_products', 5);

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
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double(8,2) NOT NULL,
  `discount` int(11) DEFAULT NULL,
  `image_folder` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cover_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tags` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `main_category_id`, `sub_category_id`, `category_id`, `brand_id`, `title`, `description`, `price`, `discount`, `image_folder`, `cover_image`, `tags`, `created_at`, `updated_at`) VALUES
(1, 1, 4, 5, 2, 'dfgdfgdfg', 'dfg dfg dfgd hbh ey eryhgfbnh bvn', 20.11, NULL, 'dfgdfgdfg.201912031924', 'RqGVdQlpvUYwa21DLPU2uSgQHSTEQJ1u.jpg', '[\"gfhgfh\"]', '2019-12-03 18:24:24', '2019-12-03 18:24:24'),
(2, 1, 4, 5, 1, 'shirt long sleeves', 'very nice shirt bla bla bla', 20.99, NULL, 'shirt.long.sleeves.201912031949', '8jaBNIfHDljSlB2gWRqAvsFac3JMJ1bK.jpg', '[\"shirt\"]', '2019-12-03 18:52:50', '2019-12-03 18:52:50'),
(3, 1, 8, 9, 1, 'V-Neck Men T-Shirt', 'V-Neck Men T-Shirt V-Neck Men T-Shirt V-Neck Men T-Shirt', 15.99, NULL, 'v-neck.men.t-shirt.201912032043', 'PWmjIuY9iVtNjffus2MldKD6ywftjZgP.jpg', '[\"V-Neck\",\"Men\",\"T-Shirt\"]', '2019-12-03 19:06:43', '2019-12-03 19:06:43'),
(4, 1, 8, 9, 2, 'V-Neck Men T-Shirt Core Inspire', 'V-Neck Men T-Shirt Core Inspire V-Neck Men T-Shirt Core Inspire V-Neck Men T-Shirt Core Inspire', 16.99, NULL, 'v-neck.men.t-shirt.core.inspire.201912032059', 'qbLtM7KxpbpwfBYkusFsk6RaJ4UKHsfx.jpg', '[\"V-Neck\"]', '2019-12-03 19:07:59', '2019-12-03 19:07:59'),
(5, 1, 4, 5, 1, 'Atomic Fantastic Shirt', 'Atomic Fantastic Shirt Atomic Fantastic Shirt Atomic Fantastic Shirt Atomic Fantastic Shirt Atomic Fantastic Shirt', 19.99, NULL, 'atomic.fantastic.shirt.201912032047', 'R28KbYCUSgW6OLnsVVpJc5DFaN3CduCW.jpg', '', '2019-12-03 19:12:48', '2019-12-03 19:12:48'),
(6, 1, 4, 5, 2, 'product test 2445', 'product test 2445 product test 2445 product test 2445 product test 2445 product test 2445', 12.99, NULL, 'product.test.2445.201912032059', '4NYxWnwet6J7yASdivooMKRdxy2yTbT2.jpg', '[\"dfdfg\"]', '2019-12-03 19:24:00', '2019-12-03 19:24:00'),
(7, 1, 4, 5, 2, 'dfg dghgh fghfghtrytry', 'gfh gfhgfhyrtyrty rty hghjdrgergfh fhjh', 40.99, NULL, 'dfg.dghgh.fghfghtrytry.201912032012', 'ND4icfJb11y6RtOmkLTglFSpg8QD7E9c.jpg', '[\"gfh fh\"]', '2019-12-03 19:31:13', '2019-12-03 19:31:13'),
(8, 2, 6, 7, 2, 'gfhdfghdfg dhhfjhgj', 'jhgj ghjghj ghjsfgergt eh fgh fnvbjghjghj', 12.99, 20, 'gfhdfghdfg.dhhfjhgj.201912032013', 'AU95DWk2ZvCuID0oJPI5DW0ZCctDtXVO.jpg', '', '2019-12-03 19:32:13', '2019-12-03 19:32:13'),
(10, 2, 6, 7, 1, 'ljkjkljk ghjrtyrty  qwewqe', 'ljkjkljk ghjrtyrty  qwewqe ljkjkljk ghjrtyrty  qwewqe ljkjkljk ghjrtyrty  qwewqe', 11.99, 30, 'ljkjkljk.ghjrtyrty..qwewqe.201912032026', 'Z9PNcmcP4nO4z463tNm1wEVfkwWGgYP9.jpg', '', '2019-12-03 19:33:26', '2019-12-03 19:33:26');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `variant_id` int(11) NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_variants`
--

CREATE TABLE `product_variants` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `sku` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` int(11) NOT NULL,
  `color` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  `tags` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 'Dusan', 'duki87', 'superadmin', 'duki@gmail.com', NULL, '$2y$10$w6il4TqeR5rZVZwfPi/37uoYNUhqiokw6J0kpFoITD2jI7sDyEV8i', NULL, '2019-11-10 19:05:05', '2019-11-10 19:05:05'),
(2, 'Gigi', 'gigi', 'user', 'gigi@gmail.com', NULL, '$2y$10$nLfgh0sXq1n1K0d1/R1sDuiJwKmjhu2EFpfFXJuqKMOqEydm62Gbu', NULL, '2019-11-12 14:32:38', '2019-11-12 14:32:38');

--
-- Indexes for dumped tables
--

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
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product_variants`
--
ALTER TABLE `product_variants`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
