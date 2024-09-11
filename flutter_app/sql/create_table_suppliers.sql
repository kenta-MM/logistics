DROP TABLE IF EXISTS logistics.suppliers;
CREATE TABLE logistics.suppliers (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL COMMENT '会社の正式名称',
    email VARCHAR(255) NOT NULL COMMENT '会社の連絡用メールアドレス',
    fax VARCHAR(20) COMMENT '会社のFAX用番号',
    address VARCHAR(255) NOT NULL COMMENT '会社の住所',
    created_at TIMESTAMP NOT NULL COMMENT '作成日時',
    updated_at TIMESTAMP NOT NULL COMMENT '更新日時'
);
