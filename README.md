# README
This is the backend for Marcus' shop. The idea is that this serves as a customizable shop, in which family of products can be created and customized.

## 
Marcus has the ability to:
- Browse products families and create/delete/update them
- Browse products of each family and create/delete/update them
- Add/delete/update specific options of customization to products
- Add/delete/update specific constraints to products so that certain combinations of customizations are forbidden

A client (to simplify, there is only 1 client expected) can:
- Browse products and customize them
- Add products to its cart

## 

The models can be grouped logically:
- **ProductType** and **Product** are the representation of every product being sold on the shop
- **ProductOption** and **ProductOptionValue** are the representation of every customization available for each product
- **ProductConstraint** and **ProductConstraintValue** are the representation of forbidden comibinations of customizations
  - ProductConstraint has a combination of (ProductOption_1, ProductOptionValue_1, ProductOption_2) -> Meaning if option_1 is selected and its value is value_1, then option_2 is being constrained by all the ProductConstraintValues referenced
- **Cart**, **CartItem** and **CustomizedOption** represent the current cart.

Every time an user adds a product to its cart, 2 validations trigger in order to check if this is a valid combination or not:
- Check CustomizedOptions of the Cart against ProductConstraints table
- Check CustomizedOpitons of the Cart against ProductOptionValue.stock_count column

There is a small test showing examples of valid and not valid carts

##

Next is a Mermaid showing the database structure:

![image](https://github.com/user-attachments/assets/2c6c5f93-65d8-413a-bd67-2c2b287b0434)
