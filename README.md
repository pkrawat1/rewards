# Reward Points Awarding API

This API is designed to facilitate point awarding to customers based on the value of orders in JPY. It allows for the identification of customers using their email and/or phone number and implements functionalities to process orders, manage customer balances, and manipulate points.

## Table of Contents

- [Overview](#overview)
- [Specifications](#specifications)
- [Setup Instructions](#setup-instructions)
- [API Endpoints](#api-endpoints)
- [Example Usage](#example-usage)

## Overview

The primary goal of this API is to award points to customers based on the value of an order in JPY. Points are awarded at a base percentage of 1% of the order value. It stores all relevant data in a chosen database and provides endpoints to process orders, fetch customer balances, and perform point manipulation operations.

## Specifications

- Back-end Language: Elixir with Phoenix framework.
- Data Storage: All data is stored in a postgresql database.
- API Functionalities:
  - Process orders and award a set percentage (1% base) in points.
  - Fetch a customer's point balance.
  - Add/subtract points from the balance.
  - Additional: Modify the percentage of points awarded.


## Setup Instructions

To get started with this API on your local machine, follow these steps:
- Clone the Repository
- Configure environment variables using [direnv](https://direnv.net/).
  ```bash
  cp .envrc.example .envrc
  ```
- Install Dependencies
  - Ensure you have Elixir and Phoenix installed.
    - Use `asdf install` to install required versions of elixir/erlang.
  ```bash
    mix deps.get
  ```
- Database Setup
  - Modify database configuration in config/dev.exs
  - Run migrations to set up the database:
  ```bash
    mix ecto.create
    mix ecto.migrate
  ```
- Start the Server
  ```bash
  mix phx.server
  ```



## API Endpoints

- #### Process Orders
  - Endpoint: POST /orders
  - Description: Processes orders and awards points to customers based on order value.
- #### Fetch Customer Balance
  - Endpoint: GET /customers/:identifier/balance
  - Description: Retrieves the current points balance for a specific customer.
- #### Modify Points Balance
  - Endpoint: POST /customers/:identifier/balance
  - Description: Allows addition or subtraction of points to a customer's balance.
- #### Modify Points Award Percentage (Extra)
  - Endpoint: PATCH /settings
  - Description: Modifies the percentage of points awarded.

## Example Usage

```bash
## Example API Request for Order Processing

```bash
curl -X POST http://localhost:4000/orders/new \
  -H "Content-Type: application/json" \
  -d '{
        "order": {
          "id": "104fd7e0-a188-4ffd-9af7-20d7876f70ab",
          "paid": 10000,
          "currency": "jpy"
        },
        "customer": {
          "email": "example@xyz.abc",
          "phone": null
        }
      }'
```
