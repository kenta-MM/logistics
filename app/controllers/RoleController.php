<?php
// app/controllers/RoleController.php

require_once __DIR__ . '/../models/Role.php';

class RoleController {

    public function getAllRoles(): array {
        $allRoles = Role::getAllRoles();
        array_unshift($allRoles, ['id' => 0, 'name' => '']);

        return $allRoles;
    }
}
