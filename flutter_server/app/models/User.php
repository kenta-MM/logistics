<?php
// app/models/User.php

class User extends ORM {
    // Idiormでは、設定は必要なく、必要に応じてカスタマイズします。
    protected static $_table        = 'users'; // 明示的にテーブル名を指定
    private static $tblSuppliers    = 'suppliers';
    private static $tblRoles        = 'roles';

    public static function getUserById($id) {
        return ORM::for_table(self::$_table)->find_one($id);
    }

    public static function getUsers(?int $page = null, ?int $pageSize = null) {
        // クエリの実行
        $query = ORM::for_table('users')
            ->select_many('users.id', 'users.name', 'users.supplier_id', 'users.role_id')
            ->select('b.name', 'supplier_name')
            ->select('c.name', 'role_name')
            ->left_outer_join('suppliers', array('users.supplier_id', '=', 'b.id'), 'b')
            ->left_outer_join('roles', array('users.role_id', '=', 'c.id'), 'c');

        if ($page != null && $pageSize != null) {
            $offset = ($page - 1) * $pageSize;
            $query = $query->limit($pageSize)->offset($offset);
        }

        return $query->find_many();
    }

    /**
    * ユーザーの情報を更新する
    * @param array [
    *    'name'         => ユーザ名,
    *    'supplier_id'  => 所属サプライヤID,
    *    'role_id'      => 割り当てられた権限
    * ]
    * @return bool Response of PDOStatement::execute()
    */
    public static function updateUser($addData) : bool {
        // 既存のユーザーを取得
        $user = ORM::for_table('users')->find_one($addData['id']);

        if ($user) {
            $user->name         = $addData['name'];
            $user->supplier_id  = $addData['supplier_id'];
            $user->role_id      = $addData['role_id'];
            $user->updated_at   = date('Y-m-d H:i:s');

            return $user->save();
        }

        return false;
    }

    /**
    * ユーザーを追加する
    * @param array [
    *    'name'         => ユーザ名,
    *    'supplier_id'  => 所属サプライヤID(省略可能),
    *    'role_id'      => 割り当てられた権限
    * ]
    * @return bool Response of PDOStatement::execute()
    */
    public static function addUser($addData) : bool {
        $now = date('Y-m-d H:i:s');

        $user = ORM::for_table('users')->create();
        $user->name         = $addData['name'];
        $user->role_id      = $addData['role_id'];
        $user->created_at   = date('Y-m-d H:i:s');
        $user->updated_at   = date('Y-m-d H:i:s');
        if (isset($addData['supplier_id'])) {
            $user->supplier_id = $addData['supplier_id'];
        }
        return $user->save();
    }
}
