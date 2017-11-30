class Category
  FILE = ENV['CATEGORIES_FILE']

  def self.all
    YAML.load_file(FILE)
  end
end
