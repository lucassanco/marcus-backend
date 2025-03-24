# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

bicycle = ProductType.find_or_create_by(name: 'Bicycle', description: "Two-wheeled steerable machine that is pedaled by the rider's feet. On a standard bicycle the wheels are mounted in-line in a metal frame, with the front wheel held in a rotatable fork. The rider sits on a saddle and steers by leaning and turning handlebars that are attached to the fork.")
bmx = Product.find_or_create_by(product_type: bicycle, name: "BMX", description: "Unlike regular bikes, like city bikes, BMX bikes boast a distinctive frame geometry. This component features smaller frames, shorter wheelbases, and robust construction. Together, they make up for the model's ability to withstand the rigours of tricks and jumps.")

frame_type = ProductOption.find_or_create_by(product: bmx, name: "Frame Type")
frame_finish = ProductOption.find_or_create_by(product: bmx, name: "Frame Finish")
wheels = ProductOption.find_or_create_by(product: bmx, name: "Wheels")
rim_color = ProductOption.find_or_create_by(product: bmx, name: "Rim Color")
chain = ProductOption.find_or_create_by(product: bmx, name: "Chain")

full_suspension = ProductOptionValue.find_or_create_by(product_option: frame_type, name: "Full-suspension")
ProductOptionValue.find_or_create_by(product_option: frame_type, name: "Diamond")
ProductOptionValue.find_or_create_by(product_option: frame_type, name: "Step-through")

ProductOptionValue.find_or_create_by(product_option: frame_finish, name: "Matte")
ProductOptionValue.find_or_create_by(product_option: frame_finish, name: "Shiny")

ProductOptionValue.find_or_create_by(product_option: wheels, name: "Road wheels")
mountain_wheels = ProductOptionValue.find_or_create_by(product_option: wheels, name: "Mountain wheels")
fat_bike_wheels = ProductOptionValue.find_or_create_by(product_option: wheels, name: "Fat bike wheels")

ProductOptionValue.find_or_create_by(product_option: rim_color, name: "Red")
black = ProductOptionValue.find_or_create_by(product_option: rim_color, name: "Black")
blue = ProductOptionValue.find_or_create_by(product_option: rim_color, name: "Blue")

ProductOptionValue.find_or_create_by(product_option: chain, name: "Single-speed chain")
ProductOptionValue.find_or_create_by(product_option: chain, name: "8-speed chain")


wheels_constraint_1 = ProductConstraint.find_or_create_by(product: bmx, option_1: wheels, option_2: frame_type, value_1: mountain_wheels)
ProductConstraintValue.find_or_create_by(product_constraint: wheels_constraint_1, product_option_value: full_suspension)

wheels_constraint_2 = ProductConstraint.find_or_create_by(product: bmx, option_1: wheels, option_2: rim_color, value_1: fat_bike_wheels)
ProductConstraintValue.find_or_create_by(product_constraint: wheels_constraint_2, product_option_value: black)
ProductConstraintValue.find_or_create_by(product_constraint: wheels_constraint_2, product_option_value: blue)

Cart.find_or_create_by({})