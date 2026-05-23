CREATE TABLE IF NOT EXISTS `d4t_vehicles` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `owner` VARCHAR(128) NOT NULL,
    `plate` VARCHAR(16) NOT NULL,
    `model` VARCHAR(64) NOT NULL,
    `garage` VARCHAR(64) NOT NULL DEFAULT 'legion',
    `state` VARCHAR(32) NOT NULL DEFAULT 'stored',
    `fuel` FLOAT NOT NULL DEFAULT 100,
    `engine` FLOAT NOT NULL DEFAULT 1000,
    `body` FLOAT NOT NULL DEFAULT 1000,
    `mileage` FLOAT NOT NULL DEFAULT 0,
    `mods` LONGTEXT DEFAULT NULL,
    `damage` LONGTEXT DEFAULT NULL,
    `position` LONGTEXT DEFAULT NULL,
    `created_at` DATETIME NOT NULL,
    `updated_at` DATETIME NOT NULL,
    `deleted` TINYINT(1) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx_d4t_vehicles_plate` (`plate`),
    KEY `idx_d4t_vehicles_owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `d4t_vehicle_keys` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(128) NOT NULL,
    `plate` VARCHAR(16) NOT NULL,
    `key_type` VARCHAR(32) NOT NULL DEFAULT 'shared',
    `created_at` DATETIME NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx_d4t_vehicle_keys_unique` (`identifier`, `plate`),
    KEY `idx_d4t_vehicle_keys_plate` (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `d4t_vehicle_history` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `plate` VARCHAR(16) NOT NULL,
    `action` VARCHAR(64) NOT NULL,
    `payload` LONGTEXT DEFAULT NULL,
    `created_at` DATETIME NOT NULL,
    PRIMARY KEY (`id`),
    KEY `idx_d4t_vehicle_history_plate` (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
