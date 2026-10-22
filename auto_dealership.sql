CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    position VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    hire_date DATE NOT NULL
);
CREATE TABLE configurations (
    configuration_id SERIAL PRIMARY KEY,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    model_year INT NOT NULL,
    engine_volume NUMERIC(3, 1) NOT NULL,
    base_price NUMERIC(12, 2) NOT NULL
);
CREATE TABLE automobiles (
    automobile_id SERIAL PRIMARY KEY,
    vin_number VARCHAR(17) NOT NULL UNIQUE,
    configuration_id INT NOT NULL,
    body_color VARCHAR(30) NOT NULL,
    status VARCHAR(20) NOT NULL CHECK(status IN ('на складе', 'зарезервирован', 'продан')),
    CONSTRAINT fk_auto_configuration FOREIGN KEY (configuration_id)
        REFERENCES configurations(configuration_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE clients (
    client_id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    passport_data VARCHAR(20) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    address TEXT NOT NULL
);
CREATE TABLE contracts (
    contract_id SERIAL PRIMARY KEY,
    contract_number VARCHAR(50) NOT NULL UNIQUE,
    contract_date DATE NOT NULL,
    automobile_id INT NOT NULL UNIQUE,
    client_id INT NOT NULL,
    employee_id INT NOT NULL,
    payment_type VARCHAR(20) NOT NULL CHECK(payment_type IN ('наличные', 'банковский перевод', 'автокредит')),
    total_amount NUMERIC(12, 2) NOT NULL,
    CONSTRAINT fk_contract_auto FOREIGN KEY (automobile_id)
        REFERENCES automobiles(automobile_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_contract_client FOREIGN KEY (client_id)
        REFERENCES clients(client_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_contract_employee FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    service_cost NUMERIC(10, 2) NOT NULL,
    description TEXT
);
CREATE TABLE contract_services (
    contract_service_id SERIAL PRIMARY KEY,
    contract_id INT NOT NULL,
    service_id INT NOT NULL,
    applied_price NUMERIC(10, 2) NOT NULL,
    CONSTRAINT fk_cs_contract FOREIGN KEY (contract_id)
        REFERENCES contracts(contract_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_cs_service FOREIGN KEY (service_id)
        REFERENCES services(service_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
