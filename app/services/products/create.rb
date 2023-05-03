class Products::Create
  prepend SimpleCommand

  def initialize(params)
    @params = params
  end

  def call
    product = Products.new(params)

    return product if product.save

    product.errors.each { |error| errors.add error.attribute, error.message }
  end
end
