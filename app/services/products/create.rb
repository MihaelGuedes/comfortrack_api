class Products::Create
  prepend SimpleCommand

  def initialize(var_i:)
    # colocar variaveis
    @var_i = var_i
  end

  def call
    # criar um produto
  end
end
