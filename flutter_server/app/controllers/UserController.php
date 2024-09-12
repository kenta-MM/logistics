<?php
// app/controllers/UserController.php

require_once __DIR__ . '/../models/User.php';

class UserController {

    public function getUser($id) {
        $user = User::getUserById($id);

        return [
            'id'                => $user->id,
            'name'              => $user->name,
            'supplier_id'       => $user->supplier_id,
            'supplier_name'     => $user->supplier_name,
            'role_id'           => $user->role_id,
            'role_name'         => $user->role_name
        ];
    }

    public function getUsers(?int $page = null, ?int $pageSize = null) {
        $users = User::getUsers($page, $pageSize);
        $response = [];
        foreach ($users as $user) {
            $response[] = [
                'id'                => $user->id,
                'name'              => $user->name,
                'supplier_id'       => $user->supplier_id,
                'supplier_name'     => $user->supplier_name,
                'role_id'           => $user->role_id,
                'role_name'         => $user->role_name
            ];
        }

        return $response;
    }

    public function addUser($data) {
        return [
            'is_succees' => User::addUser($data)
        ];
    }

    public function updateUser($data) {
        return [
            'is_succees' => User::updateUser($data)
        ];
    }
}
