<?php
// app/models/Role.php

class Role extends ORM {
    protected static $_table = 'roles'; // 明示的にテーブル名を指定

    public static function getAllRoles(): array {
        $roles = ORM::for_table(self::$_table)
            ->select_many('id', 'name')
            ->find_many();

        $response = [];
        foreach ($roles as $role) {
            $response[] = [
                'id'                => $role->id,
                'name'              => $role->name,
            ];
        }

        return $response;
    }
}
