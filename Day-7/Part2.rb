require 'set'

class Directory
  attr_accessor :parent_directory, :child_directories, :files

  def initialize(parent_directory = nil, child_directories = Hash.new, files = Hash.new)
    @parent_directory = parent_directory
    @child_directories = child_directories
    @files = files
  end

  def calculate_total_size
    current_directory_size = @files.empty? ? 0 : @files.sum { |file_name, size| size }
    child_directory_size = @child_directories.empty? ? 0 : @child_directories.sum { |directory_name, directory| directory.calculate_total_size }
    return child_directory_size + current_directory_size
  end
end

def find_all_directory_sizes(directory)
  sizes = []
  sizes.push(directory.calculate_total_size)
  unless directory.child_directories.empty?
    directory.child_directories.values.each {|directory| sizes.concat(find_all_directory_sizes(directory))}
  end
  return sizes
end

def map_file_structure(input)
  root_directory = Directory.new
  directory_stack = []

  input.each do |line|
    if line[0] == '$' # command
      command = line.split(' ')[1]
      if command == 'cd' # cd
        next_directory_name = line.split(' ').last
        if next_directory_name == '..' # move up one directory
          directory_stack.pop
        elsif next_directory_name == '/' # move to root
          directory_stack.clear
          directory_stack.push(root_directory)
        else
          # move into directory
          current_directory = directory_stack.last
          directory_stack.push(current_directory.child_directories[next_directory_name])
        end
      end
    else
      # ls output
      current_directory = directory_stack.last
      if line.split(' ')[0] == 'dir' # new directory
        next_directory_name = line.split(' ').last
        unless current_directory.child_directories.include?(next_directory_name)
          current_directory.child_directories[next_directory_name] = Directory.new
        end
      else
        # new file
        file_size, file_name = line.split(' ')
        unless current_directory.files.include?(file_name)
          current_directory.files[file_name] = file_size.to_i
        end
      end
    end
  end

  return root_directory
end

input = File.readlines("Day-7/input.txt", chomp: true)

root_directory = map_file_structure(input)

TOTAL_DISK_SPACE = 70000000
MINIMUM_DISK_SPACE_REQUIRED = 30000000
unused_disk_space = TOTAL_DISK_SPACE - root_directory.calculate_total_size
additional_disk_space_required = MINIMUM_DISK_SPACE_REQUIRED - unused_disk_space

smallest_sufficiently_large_size = find_all_directory_sizes(root_directory).filter { |size| size >= additional_disk_space_required }.sort.first
puts smallest_sufficiently_large_size