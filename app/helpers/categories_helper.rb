module CategoriesHelper
  def category_options_for_select(selected = nil)
    options_for_select(traverse_cat_tree(Category.tree), selected)
  end

  private

  def traverse_cat_tree(tree, prefix = '')
    opts = []

    tree.each do |category, children|
      opts << ["#{prefix}#{category.title}", category.id]
      opts += traverse_cat_tree(children, prefix + '--')
    end

    opts
  end
end
