-- Fleet Management System Demo Data
-- Created: December 2024
-- This file contains demo data for testing the fleet management system
-- IMPORTANT: Run this AFTER importing the main database schema files

-- Use the fleet management database
USE maggie_fleet;

-- Clear existing data (optional - comment out if you want to keep existing data)
-- DELETE FROM fuel_logs;
-- DELETE FROM vehicles;
-- DELETE FROM employees;
-- DELETE FROM users;
-- DELETE FROM departments;
-- DELETE FROM offices;
-- DELETE FROM roles;
-- DELETE FROM vehicle_categories;

-- Insert roles if they don't exist
INSERT INTO roles (name, description, permissions) VALUES 
('Super Admin', 'Full system access', JSON_OBJECT(
    'vehicles_view', true, 'vehicles_edit', true, 'vehicles_delete', true,
    'fuel_logs_view', true, 'fuel_logs_edit', true, 'fuel_logs_delete', true,
    'employees_view', true, 'employees_edit', true, 'employees_delete', true,
    'departments_view', true, 'departments_edit', true, 'departments_delete', true,
    'users_view', true, 'users_edit', true, 'users_delete', true,
    'reports_view', true, 'system_settings', true
)),
('Admin', 'Administrative access with some restrictions', JSON_OBJECT(
    'vehicles_view', true, 'vehicles_edit', true, 'vehicles_delete', false,
    'fuel_logs_view', true, 'fuel_logs_edit', true, 'fuel_logs_delete', false,
    'employees_view', true, 'employees_edit', true, 'employees_delete', false,
    'departments_view', true, 'departments_edit', true, 'departments_delete', false,
    'users_view', true, 'users_edit', false, 'users_delete', false,
    'reports_view', true, 'system_settings', false
)),
('User', 'Basic user access - view and add fuel logs only', JSON_OBJECT(
    'vehicles_view', true, 'vehicles_edit', false, 'vehicles_delete', false,
    'fuel_logs_view', true, 'fuel_logs_edit', true, 'fuel_logs_delete', false,
    'employees_view', true, 'employees_edit', false, 'employees_delete', false,
    'departments_view', true, 'departments_edit', false, 'departments_delete', false,
    'users_view', false, 'users_edit', false, 'users_delete', false,
    'reports_view', true, 'system_settings', false
)),
('Fleet Manager', 'Fleet management with full vehicle access', JSON_OBJECT(
    'vehicles_view', true, 'vehicles_edit', true, 'vehicles_delete', true,
    'fuel_logs_view', true, 'fuel_logs_edit', true, 'fuel_logs_delete', true,
    'employees_view', true, 'employees_edit', true, 'employees_delete', false,
    'departments_view', true, 'departments_edit', false, 'departments_delete', false,
    'users_view', false, 'users_edit', false, 'users_delete', false,
    'reports_view', true, 'system_settings', false
))
ON DUPLICATE KEY UPDATE description = VALUES(description);

-- Insert offices
INSERT INTO offices (name, description, address, phone) VALUES 
('HQ', 'Headquarters Office', 'Main office location, Nairobi', '+254-700-123-456'),
('Maragua', 'Maragua Office', 'Maragua branch office', '+254-700-123-457'),
('Thika', 'Thika Branch', 'Thika regional office', '+254-700-123-458'),
('Kiambu', 'Kiambu Office', 'Kiambu county office', '+254-700-123-459')
ON DUPLICATE KEY UPDATE description = VALUES(description);

-- Insert demo users for each role
-- Note: All passwords are hashed version of "Demo123#"
INSERT INTO users (username, email, password_hash, full_name, role_id, office_id, status) VALUES 
-- Super Admin users
('superadmin', 'superadmin@fleet.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Super Administrator', 1, 1, 'active'),
('admin', 'admin@fleet.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'System Administrator', 1, 1, 'active'),

-- Admin users
('admin_hq', 'admin.hq@fleet.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'HQ Administrator', 2, 1, 'active'),
('admin_maragua', 'admin.maragua@fleet.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Maragua Administrator', 2, 2, 'active'),
('admin_thika', 'admin.thika@fleet.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Thika Administrator', 2, 3, 'active'),

-- Fleet Manager users
('fleet_manager1', 'fleet.manager1@fleet.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'John Fleet Manager', 4, 1, 'active'),
('fleet_manager2', 'fleet.manager2@fleet.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Sarah Fleet Manager', 4, 2, 'active'),

-- Regular users
('user1', 'user1@fleet.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'John Driver', 3, 1, 'active'),
('user2', 'user2@fleet.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Mary Driver', 3, 1, 'active'),
('user3', 'user3@fleet.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Peter Transport', 3, 2, 'active'),
('user4', 'user4@fleet.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Grace Operations', 3, 3, 'active'),
('user5', 'user5@fleet.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'David Field', 3, 4, 'active')
ON DUPLICATE KEY UPDATE username = VALUES(username);

-- Insert vehicle categories
INSERT INTO vehicle_categories (name, description) VALUES 
('Car', 'Passenger cars and sedans'),
('Motorcycle', 'Motorcycles and scooters'),
('Truck', 'Trucks and commercial vehicles'),
('Van', 'Utility vans and light commercial vehicles'),
('Pick-up', 'Pick-up trucks and double cabs'),
('Bus', 'Buses and minibuses')
ON DUPLICATE KEY UPDATE description = VALUES(description);

-- Insert departments
INSERT INTO departments (name, description, office_id) VALUES 
('Transport', 'Main transport and logistics department', 1),
('Operations', 'Field operations and utility services', 1),
('Administration', 'Administrative and management functions', 1),
('Maintenance', 'Vehicle and equipment maintenance', 1),
('Transport', 'Maragua transport department', 2),
('Operations', 'Maragua field operations', 2),
('Transport', 'Thika transport department', 3),
('Operations', 'Thika field operations', 3),
('Transport', 'Kiambu transport department', 4)
ON DUPLICATE KEY UPDATE description = VALUES(description);

-- Insert employees
INSERT INTO employees (name, email, phone, department, office_id) VALUES 
-- HQ employees
('John Smith', 'john.smith@fleet.com', '+254-700-111-001', 'Transport', 1),
('Maria Garcia', 'maria.garcia@fleet.com', '+254-700-111-002', 'Transport', 1),
('David Johnson', 'david.johnson@fleet.com', '+254-700-111-003', 'Operations', 1),
('Sarah Wilson', 'sarah.wilson@fleet.com', '+254-700-111-004', 'Administration', 1),
('Michael Brown', 'michael.brown@fleet.com', '+254-700-111-005', 'Maintenance', 1),
('Jennifer Davis', 'jennifer.davis@fleet.com', '+254-700-111-006', 'Transport', 1),
('Robert Miller', 'robert.miller@fleet.com', '+254-700-111-007', 'Operations', 1),

-- Maragua employees
('Peter Kamau', 'peter.kamau@fleet.com', '+254-700-222-001', 'Transport', 2),
('Grace Wanjiku', 'grace.wanjiku@fleet.com', '+254-700-222-002', 'Transport', 2),
('James Mwangi', 'james.mwangi@fleet.com', '+254-700-222-003', 'Operations', 2),
('Lucy Njeri', 'lucy.njeri@fleet.com', '+254-700-222-004', 'Operations', 2),

-- Thika employees
('Samuel Kiprotich', 'samuel.kiprotich@fleet.com', '+254-700-333-001', 'Transport', 3),
('Rose Akinyi', 'rose.akinyi@fleet.com', '+254-700-333-002', 'Transport', 3),
('Francis Mutua', 'francis.mutua@fleet.com', '+254-700-333-003', 'Operations', 3),

-- Kiambu employees
('Daniel Ochieng', 'daniel.ochieng@fleet.com', '+254-700-444-001', 'Transport', 4),
('Mary Wambui', 'mary.wambui@fleet.com', '+254-700-444-002', 'Transport', 4)
ON DUPLICATE KEY UPDATE name = VALUES(name);

-- Insert demo vehicles
INSERT INTO vehicles (registration_number, make, model, year, category_id, assigned_employee_id, department, office_id, status, current_mileage) VALUES 
-- HQ vehicles
('KCA-001A', 'Toyota', 'Hilux', 2020, 5, 1, 'Transport', 1, 'active', 45000),
('KCA-002B', 'Honda', 'CB125', 2021, 2, 2, 'Transport', 1, 'active', 12500),
('KCA-003C', 'Toyota', 'Corolla', 2019, 1, 3, 'Operations', 1, 'active', 67000),
('KCA-004D', 'Nissan', 'Navara', 2020, 5, 4, 'Administration', 1, 'active', 38000),
('KCA-005E', 'Isuzu', 'D-Max', 2021, 5, 5, 'Maintenance', 1, 'active', 28000),
('KCA-006F', 'Toyota', 'Prado', 2019, 1, 6, 'Transport', 1, 'active', 55000),
('KCA-007G', 'Mitsubishi', 'Canter', 2020, 3, 7, 'Operations', 1, 'active', 72000),

-- Maragua vehicles
('KBJ-101A', 'Toyota', 'Vitz', 2018, 1, 8, 'Transport', 2, 'active', 89000),
('KBJ-102B', 'Honda', 'CRF150', 2020, 2, 9, 'Transport', 2, 'active', 15000),
('KBJ-103C', 'Ford', 'Ranger', 2019, 5, 10, 'Operations', 2, 'active', 62000),
('KBJ-104D', 'Suzuki', 'Alto', 2017, 1, 11, 'Operations', 2, 'active', 95000),

-- Thika vehicles
('KCE-201A', 'Toyota', 'Hiace', 2020, 4, 12, 'Transport', 3, 'active', 35000),
('KCE-202B', 'Nissan', 'Patrol', 2019, 1, 13, 'Transport', 3, 'active', 48000),
('KCE-203C', 'Isuzu', 'NPR', 2018, 3, 14, 'Operations', 3, 'active', 78000),

-- Kiambu vehicles
('KCF-301A', 'Toyota', 'Fielder', 2019, 1, 15, 'Transport', 4, 'active', 42000),
('KCF-302B', 'Honda', 'Fit', 2020, 1, 16, 'Transport', 4, 'active', 25000)
ON DUPLICATE KEY UPDATE make = VALUES(make);

-- Insert sample fuel logs for the last 3 months
INSERT INTO fuel_logs (vehicle_id, date, mileage, fuel_quantity, cost, notes) VALUES 
-- Vehicle 1 (KCA-001A) logs
(1, '2024-12-15', 45000, 45.5, 7280.00, 'Regular refuel at Shell Station'),
(1, '2024-12-01', 44800, 42.0, 6720.00, 'Monthly fuel allowance'),
(1, '2024-11-15', 44500, 48.2, 7712.00, 'Long distance trip refuel'),

-- Vehicle 2 (KCA-002B) logs
(2, '2024-12-14', 12500, 8.2, 1312.00, 'Motorcycle fuel top-up'),
(2, '2024-12-01', 12350, 7.5, 1200.00, 'Regular motorcycle refuel'),
(2, '2024-11-20', 12200, 8.0, 1280.00, 'Monthly motorcycle fuel'),

-- Vehicle 3 (KCA-003C) logs
(3, '2024-12-13', 67000, 38.0, 6080.00, 'Monthly fuel for administration vehicle'),
(3, '2024-11-28', 66750, 35.5, 5680.00, 'Regular fuel top-up'),
(3, '2024-11-10', 66500, 40.0, 6400.00, 'Field operations fuel'),

-- Vehicle 4 (KCA-004D) logs
(4, '2024-12-12', 38000, 52.0, 8320.00, 'Pick-up truck fuel'),
(4, '2024-11-25', 37600, 48.5, 7760.00, 'Administration department fuel'),

-- Vehicle 5 (KCA-005E) logs
(5, '2024-12-10', 28000, 55.0, 8800.00, 'Maintenance vehicle fuel'),
(5, '2024-11-22', 27700, 50.0, 8000.00, 'Monthly maintenance fuel'),

-- Maragua vehicles logs
(8, '2024-12-08', 89000, 28.0, 4480.00, 'Maragua office vehicle fuel'),
(8, '2024-11-24', 88750, 30.0, 4800.00, 'Regular fuel for small car'),

(9, '2024-12-09', 15000, 6.5, 1040.00, 'Motorcycle fuel - Maragua'),
(9, '2024-11-26', 14800, 7.0, 1120.00, 'Monthly motorcycle fuel'),

(10, '2024-12-07', 62000, 48.0, 7680.00, 'Ford Ranger fuel - Operations'),
(10, '2024-11-21', 61600, 45.0, 7200.00, 'Field operations fuel'),

-- Thika vehicles logs
(12, '2024-12-06', 35000, 65.0, 10400.00, 'Hiace van fuel - Transport'),
(12, '2024-11-19', 34500, 60.0, 9600.00, 'Monthly transport fuel'),

(13, '2024-12-05', 48000, 55.0, 8800.00, 'Nissan Patrol fuel'),
(13, '2024-11-18', 47600, 52.0, 8320.00, 'Administrative fuel'),

-- Kiambu vehicles logs
(15, '2024-12-04', 42000, 32.0, 5120.00, 'Fielder fuel - Transport'),
(15, '2024-11-17', 41700, 35.0, 5600.00, 'Monthly fuel allowance'),

(16, '2024-12-03', 25000, 28.0, 4480.00, 'Honda Fit fuel'),
(16, '2024-11-16', 24750, 30.0, 4800.00, 'Regular fuel top-up')
ON DUPLICATE KEY UPDATE notes = VALUES(notes);

-- Update vehicle mileage based on latest fuel logs
UPDATE vehicles v 
SET current_mileage = (
    SELECT MAX(fl.mileage) 
    FROM fuel_logs fl 
    WHERE fl.vehicle_id = v.id
)
WHERE id IN (SELECT DISTINCT vehicle_id FROM fuel_logs);

-- Display summary of created demo data
SELECT 'Demo Data Summary' as Info;

SELECT 
    'Users Created' as Category,
    COUNT(*) as Total,
    CONCAT(
        SUM(CASE WHEN role_id = 1 THEN 1 ELSE 0 END), ' Super Admin, ',
        SUM(CASE WHEN role_id = 2 THEN 1 ELSE 0 END), ' Admin, ',
        SUM(CASE WHEN role_id = 3 THEN 1 ELSE 0 END), ' User, ',
        SUM(CASE WHEN role_id = 4 THEN 1 ELSE 0 END), ' Fleet Manager'
    ) as Breakdown
FROM users;

SELECT 
    'Vehicles Created' as Category,
    COUNT(*) as Total,
    CONCAT(COUNT(*), ' vehicles across ', COUNT(DISTINCT office_id), ' offices') as Breakdown
FROM vehicles;

SELECT 
    'Fuel Logs Created' as Category,
    COUNT(*) as Total,
    CONCAT(COUNT(*), ' fuel entries for ', COUNT(DISTINCT vehicle_id), ' vehicles') as Breakdown
FROM fuel_logs;

SELECT 
    'Employees Created' as Category,
    COUNT(*) as Total,
    CONCAT(COUNT(*), ' employees across ', COUNT(DISTINCT office_id), ' offices') as Breakdown
FROM employees;

-- Display login credentials for testing
SELECT 
    'LOGIN CREDENTIALS FOR TESTING' as Info,
    'Username: admin, Password: Demo123#' as 'Super Admin',
    'Username: admin_hq, Password: Demo123#' as 'Admin (HQ)',
    'Username: fleet_manager1, Password: Demo123#' as 'Fleet Manager',
    'Username: user1, Password: Demo123#' as 'Regular User'
FROM dual;

-- End of demo data file