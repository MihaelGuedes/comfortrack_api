class Products::Update
  prepend SimpleCommand

  def initialize(product_id, params)
    @product = Product.find product_id
    @params = params
  end

  def call
    return @product if @product.update(@params)

    @product.errors.each { |error| errors.add error.attribute, error.message }
  end
end
