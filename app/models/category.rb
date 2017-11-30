class Category
  FILE = ENV['CATEGORIES_FILE']

  def self.all
    @categories = YAML.load_file(FILE)
  end
end
