# Prague Kebab Database

This semester project implements a comprehensive database for Prague's kebab establishments using **fictional data**.

## Key Features

* **Establishments**
  * `id_provozovny`: Unique identifier (required)
  * Address, phone, and website (optional)
  * `IČO`: Business ID (can be shared among establishments with the same owner)

* **Owners**
  * **Common Attributes:** Unique ID, `IČO`, registered office address, email (optional), phone (optional)
  * **Physical Person:** First name, last name, date of birth
  * **Legal Entity:** Name, reliability score (0–100)

* **Orders**
  * `id_objednávky`: Unique order ID
  * Order date and list of ordered dishes

* **Dishes**
  * Unique ID, name, and price

* **Reviews**
  * Unique review ID, date, and rating (1–5 stars)
  * Customer details: name, platform (e.g., Google, Foodora, Bolt Food, Wolt), optional phone/email
  * Each review can include multiple purchased dishes

* **Employees**
  * Unique ID, name, date of birth, and employment start date

