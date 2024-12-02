# frozen_string_literal: true

class Day
  def read_input(split1: nil, split2: nil)
    day = self.class.name.downcase
    year = caller_locations.first.absolute_path.split('/').reverse.drop(1).first
    file_path = File.join(__dir__, '..', '..', 'data', year, "#{day}.txt")
    content = File.read(file_path)
    content = content.split(split1) if split1
    content = content.map { |x| x.split(split2) } if split2
    content
  end
end
