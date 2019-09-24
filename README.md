# README

Rails GotCarbs Restaurant Application
Overview and Features
My workflow notes for building a restaurant Rails application. Summary features outlined below.  Overall, this app started simple by following the requirements for my ROR FlatIron school project. Hower, it is two websites in one. One for users and one for admins. The requirements are first, and then I break down the functionality added to this project. The app uses bootstrap, css, and some java for the front end.  The database is built using Postgress and you can see a live version of the app on Heroku at: https://gotcarbs.herokuapp.com.

Original Requirements:

Specs:

 Using Ruby on Rails for the project
 Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes)
 Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User)
 Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients)
 Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients)
 The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (In my case I made a cart, and user can add quantity to it.)
 Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
 Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
 Include signup
 Include login
 Include logout
 Include third party signup/login (how e.g. Devise/OmniAuth)
 Include nested resource show or index (URL e.g. users/2/recipes)
 Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)
 Include form display of validation errors (form URL e.g. /recipes/new)
Confirm:

 The application is pretty DRY(There are some stuff that can be refactored.)
 Limited logic in controllers
 Views use helper methods if appropriate
 Views use partials if appropriate

User is able to:

View all menus.
Only current menu is available to shop.
Can sign up
Can sign in with facebook or automatically signed after signed up.
A user can log out.
Add/ reduce quantity of products in cart
Checkout cart by submitting order
Can see individual order history or a list of all their orders.
Can see their profile, and update their attributes such as address.


Admin is able to:

Create, edit and delete items and users.  It can do the same for orders, except create or a brand new item.
Admin can also search and see any user, orders, and items.


Great functionality added to this app:

Some friendly forwarding.
Item helpers to display menus and current menus.
You will notice that if it's not time for current menu, you won't be able to add items to cart.
A lot tweaking took place with javascript and bootstrap to make the styles and layouts work fine.
It uses two layouts one for admin and one for user.
The part where items are added to cart took some thinking and a lot of work. 
Items are added to cart via the cart_items controller.
Once an ordered is place the cart gets destroy. 
There's also a seed file to test the appication. 

Models:

User
Item
Cart_Item
Ordered_Item
Address
Order