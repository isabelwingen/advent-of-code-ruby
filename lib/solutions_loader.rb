# frozen_string_literal: true

class SolutionsLoader
  def self.load_solution(year, day)
    # Construct the path to the solution file
    file_path = File.join(__dir__, 'solutions', "year#{year}", "day#{day}.rb")

    return unless File.exist?(file_path)

    require file_path
    # Dynamically create the class name (e.g., Year2024Day5)
    class_name = "Day#{day}"
    Object.const_get(class_name).new
  end
end
