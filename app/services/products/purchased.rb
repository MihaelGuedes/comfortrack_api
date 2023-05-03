class Products::Purchased
  prepend SimpleCommand

  def initialize(params, user)
    @params = params
    @user = user
  end

  def call
    product = take_product

    purchased_product = PurchasedProduct.new(
      name: product.name,
      price: product.price,
      product_type: product.product_type,
      user: @user,
      promotion: @params[:promotion],
      status: :paid,
      product:,
    )

    return purchased_product if purchased_product.save

    purchased_product.errors.each { |error| errors.add error.attribute, error.message }
  end

  private

  def take_product
    Product.find @params[:product_id]
  end
end