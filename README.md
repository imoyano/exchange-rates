# Exchange Rates

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Overview

**Currency Converter** is a powerful and efficient Elixir-based application that provides real-time foreign exchange rates. This project aims to simplify currency conversion and provide up-to-date financial data, making it an invaluable tool for businesses and individuals alike.

### Features

- **Real-Time Data**: Access accurate and current foreign exchange rate data from reliable sources.
- **API Integration**: A user-friendly API that allows easy currency conversion and integration into your applications.
- **Open-Source**: Currency Converter is open-source and highly customizable, giving you the freedom to adapt it to your needs.

## Technology Stack

The **Currency Converter** project is built with cutting-edge technologies, offering reliability, performance, and flexibility:

- **Elixir (v1.15.4)**: A functional and concurrent programming language known for its robustness and scalability.
- **Erlang/OTP (v26)**: The foundation of Elixir, providing distributed and fault-tolerant capabilities.
- **Phoenix Framework (v1.5.3)**: A productive web framework for building robust and maintainable applications.
- **PostgreSQL**: A powerful open-source relational database that stores and manages exchange rate data.

## Why Elixir?

Elixir was selected as the primary programming language for this project due to its remarkable features and advantages:

1. **Concurrency**: Elixir's actor-based model allows handling multiple concurrent requests efficiently.
2. **Fault Tolerance**: Elixir and the Erlang VM (BEAM) offer a robust fault-tolerant system, ensuring high availability.
3. **Scalability**: Elixir's scalability is perfect for growing applications, providing exceptional performance under increasing loads.
4. **Phoenix Framework**: The Phoenix web framework is ideal for building web applications and RESTful APIs efficiently.
5. **Elixir Ecosystem**: The Elixir ecosystem is rich in libraries and tools that simplify development and maintenance, such as Mox for robust unit testing.

## Data Collection Process

**The Currency Converter Application** seamlessly acquires foreign exchange rate data from a trusted external API, [exchangeratesapi.io](https://exchangeratesapi.io/), ensuring users have access to precise and current information. The process of gathering this data is vividly represented in the diagram below:

![Data Collection Diagram](https://exchange.m1.cl/images/currency_converter.png)

Data is collected three times a day using Phoenix's `phoenix_job` module with a scheduler set to run at regular intervals, specifically configured as follows: "0 */8 * * *". The collected data is stored within a PostgreSQL database, which serves as the backend for the Currency Converter application. Within this database, the exchange rate information is organized within a table named "rates," designed to accommodate data in a format similar to that illustrated in the image below:

![Rates DB Table](https://exchange.m1.cl/images/rates_table.jpg)

## CI/CD with GitHub Actions

The **Currency Converter** project employs CI/CD (Continuous Integration/Continuous Deployment) using GitHub Actions. This automated process ensures that changes to the codebase are thoroughly tested and deployed seamlessly.

### Workflow Overview

The CI/CD workflow consists of the following steps:

1. **Continuous Integration (CI)**:
   - On every push to the repository, any new changes are built, and dependencies are fetched.

2. **Continuous Deployment (CD)**:
   - Upon successful CI, the application is automatically deployed to the production environment.

### GitHub Actions

Our CI/CD process is configured using GitHub Actions. You can find the specific workflow setup in the [`.github/workflows`](.github/workflows) directory. The workflow file, `main.yml`, defines the CI/CD pipeline.

To customize or modify the CI/CD workflow, refer to the `main.yml` file and the GitHub Actions documentation.

## Getting Started

To start using **Currency Converter**, follow these steps:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/imoyano/exchange-rates.git
   cd exchange-rates
   ```

2. **Install Dependencies**:
   ```bash
   mix deps.get
   ```

3. **Database Setup**:
   ```bash
   mix ecto.create
   mix ecto.migrate
   ```
   
4. **Launch the Application**:
   ```bash
   mix phx.server
   ```

5. **Access the API**:
   ```bash
   http://localhost:4000
   ```

6. **Running the unit tests**:
   ```bash
   mix test
   ```

## API Endpoints

### Show All Rates

This endpoint retrieves a list of all available exchange rates.

**Endpoint:**
```http
GET /api/rates
```

**cURL Example:**
```bash
curl --location 'https://exchange.m1.cl/api/rates'
```

### Create a New Rate

Use this endpoint to create a new exchange rate.

**Endpoint:**
```http
POST /api/rates
```

**cURL Example:**
```bash
curl --location 'https://exchange.m1.cl/api/rates' \
--header 'Content-Type: application/json' \
--data '{
    "base": "USD",
    "currency": "CLP",
    "rate": 1,
    "date_rate": "2023-10-11",
    "base_currency": "TEST"
}'
```

### Get Rate by ID

This endpoint allows you to retrieve a specific exchange rate by its unique identifier.

**Endpoint:**
```http
GET /api/rates/:id
```

**cURL Example:**
```bash
curl --location 'https://exchange.m1.cl/api/rates/47b7f1f8-e31e-4914-80d0-8bd917de88ae'
```

### Update a Rate

You can use this endpoint to update an existing exchange rate.

**Endpoint:**
```http
PUT /api/rates/:id
```

**cURL Example:**
```bash
curl --location --request PUT 'https://exchange.m1.cl/api/rates/47b7f1f8-e31e-4914-80d0-8bd917de88ae' \
--header 'Content-Type: application/json' \
--data '{
    "base": "EUR",
    "currency": "CLP",
    "rate": 986.250051,
    "date_rate": "2023-10-11",
    "base_currency": "TEST"
}'
```

You can interact with these endpoints using cURL as shown in the examples above. These endpoints provide comprehensive functionality for managing exchange rates within the Currency Converter API.

## Web Application Demo Online

As previously mentioned, the web application, developed using the Phoenix framework, is deployed through a Continuous Integration / Continuous Deployment (CI/CD) workflow to a cloud-based service. You can access the application by visiting the following URL: [https://exchange.m1.cl](https://exchange.m1.cl)

![Web Application Demo Online](https://exchange.m1.cl/images/demo.jpg)

## License
This project is open-source and available under the MIT License. Feel free to use and modify it as needed.

We hope you find "Currency Converter" useful for your currency exchange and financial data needs. If you have any questions or feedback, please don't hesitate to reach out. Enjoy using the application!