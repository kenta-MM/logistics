DROP TABLE IF EXISTS logistics.users;
CREATE TABLE logistics.users (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL COMMENT 'ユーザー名',
    supplier_id INT UNSIGNED DEFAULT NULL COMMENT '所属しているサプライヤ',
    role_id TINYINT UNSIGNED NOT NULL COMMENT '与えられている権限',
    created_at TIMESTAMP NOT NULL COMMENT '作成日時',
    updated_at TIMESTAMP NOT NULL COMMENT '更新日時'
);
