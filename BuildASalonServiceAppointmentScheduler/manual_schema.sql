CONNECT salon;
DROP TABLE IF EXISTS customers;
CREATE TABLE customers(
  customer_id SERIAL PRIMARY KEY NOT NULL,
  phone VARCHAR(15) UNIQUE NOT NULL,
  name VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS services;
CREATE TABLE services(
  service_id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments(
  apppointment_id SERIAL PRIMARY KEY NOT NULL,
  time VARCHAR(50) NOT NULL,
  customer_id INT FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
  service_id INT FOREIGN KEY(service_id) REFERENCES services(service_id)
);

INSERT INTO services(service_id, name) VALUES(1, 'cut'),(2,'color'),(3, 'perm'),(4,'style'),(5,'trim');