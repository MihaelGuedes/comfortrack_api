module PaginationHelper
  def paginate(scope, default_per_page: 10, options: {}, decorate: false, decorate_name: nil)
    if params[:per_page] == 'all'
      collection, current, total_page, per_page, total_count = all_itens(scope)
    else
      collection, current, total_page, per_page, total_count = with_paginate(scope, default_per_page:, 
options:, decorate:, decorate_name:)
    end

    {
      total: total_count,
      per_page:,
      current_page: current,
      last_page: total_page,
      next_page_url: nil,
      prev_page_url: nil,
      data: collection,
    }
  end

  def with_paginate(scope, default_per_page:, options:, decorate:, decorate_name:)
    if decorate
      klass = get_decorator(scope, decorate_name)
      collection = klass.decorate_collection(scope.page(params[:page]).per((params[:per_page] || default_per_page).to_i))
    else
      collection = scope&.page(params[:page])&.per((params[:per_page] || default_per_page).to_i)
    end

    current = collection.current_page
    total_page = collection.total_pages
    per_page = collection.limit_value
    total_count = collection.total_count

    collection = collection.as_json(options) if options.present?

    [collection, current, total_page, per_page, total_count]
  end

  def all_itens(scope)
    collection = scope.all
    current = 1
    total_page = 1
    per_page = collection.size
    total_count = collection.size

    [collection, current, total_page, per_page, total_count]
  end

  def get_decorator(scope, decorate_name)
    klass = if decorate_name
      decorate_name.constantize
    else
      "#{scope.table_name.singularize}_decorator".camelcase.constantize
            end
  end

  private

  def klass_to_decorate(default_per_page, scope)
    klass = "#{scope.table_name.singularize}_decorator".camelcase.constantize
    klass.decorate_collection(scope.page(params[:page]).per((params[:per_page] || default_per_page).to_i))
  end
end