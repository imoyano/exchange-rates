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

**Currency Converter** collects foreign exchange rate data from an external API to provide accurate and up-to-date information. The data collection process can be visualized in the following diagram:

![Data Collection Diagram](https://exchange.m1.cl/images/currency_converter.png)

Data is collected 3 times a day using phoenix_job with a scheduler: "0 */8 * * *"

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

## Demo Online

### Web Application

### API